import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/pages/main_screen.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../main_screen/data/models/menu_model.dart';
import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../../../region/presentation/blocs/region_cubit.dart';
import '../../blocs/sign_up_bloc.dart';
import '../signup_steps/business_name_step_widget.dart';
import '../signup_steps/business_types_step_widget.dart';
import '../signup_steps/configure_demo_data_step_widget.dart';
import '../signup_steps/configure_restaurant_step_widget.dart';
import '../signup_steps/domain_link_step_widget.dart';
import '../signup_steps/phone_number_step_widget.dart';
import '../signup_steps/region_step_widget.dart';

class DesktopSignupSetupGuideScreen extends StatefulWidget {
  const DesktopSignupSetupGuideScreen({super.key});

  @override
  State<DesktopSignupSetupGuideScreen> createState() => _DesktopSignupSetupGuideScreenState();
}

enum SignupSetupGuideStep {
  businessType(BusinessTypesStepWidget()),
  businessTypeName(BusinessNameStepWidget()),
  domainLink(DomainLinkStepWidget()),
  region(RegionStepWidget()),
  phoneNumber(PhoneNumberStepWidget()),
  restaurantConfiguration(ConfigureRestaurantStepWidget()),
  demoDataConfiguration(ConfigureDemoDataStepWidget());

  const SignupSetupGuideStep(this.page);

  final Widget page;
}

class _DesktopSignupSetupGuideScreenState extends State<DesktopSignupSetupGuideScreen> {
  final _pageViewController = PageController();
  final _sliderCurrentIndex = 0.0.obs;

  @override
  void initState() {
    super.initState();

    context.read<SignUpBloc>().add(const GetAllBusinessTypesEvent());
    context.read<RegionCubit>()
      ..getAllCountriesAndCities()
      ..getCountryCityByIP();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 800,
        child: ScrollableWidget(
          scrollViewPadding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SvgPicture.asset(Assets.logoCatalogakLogo, width: 150),
              context.sizedBoxHeightSmall,
              SizedBox(
                height: 500,
                child: PageView(
                  controller: _pageViewController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: SignupSetupGuideStep.values.map((e) => e.page).toList(),
                ),
              ),
              SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      activeTrackColor: context.colorScheme.primaryColor,
                      disabledActiveTrackColor: context.colorScheme.primaryColor,
                      trackHeight: 6,
                      thumbShape: SliderComponentShape.noOverlay),
                  child: Obx(() => Slider(
                        value: _sliderCurrentIndex.value,
                        onChanged: null,
                        max: 6,
                        min: 0,
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Visibility(
                      visible: _sliderCurrentIndex > 0,
                      child: RoundedBtnWidget(
                          onTap: () {
                            if (_sliderCurrentIndex.value == 6 &&
                                context.read<SignUpBloc>().saveSignupStepsParameter.businessTypeId != 1) {
                              _sliderCurrentIndex.value = _sliderCurrentIndex.value - 2;
                              _pageViewController.jumpToPage((_sliderCurrentIndex).toInt());
                            } else {
                              _pageViewController.jumpToPage((--_sliderCurrentIndex.value).toInt());
                            }
                            context.read<SignUpBloc>().saveSignupStepsParameter.doneSteps.value = true;
                          },
                          btnText: 'Back',
                          bgColor: Colors.transparent,
                          btnTextColor: Colors.black,
                          boxBorder: Border.all(color: Colors.black, width: .4),
                          btnTextStyle: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                          width: 100,
                          height: 35,
                          btnIcon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.black,
                            size: 12,
                          )),
                    ),
                  ),
                  BlocConsumer<SignUpBloc, SignUpState>(
                    listener: (context, state) {
                      if (state is SaveSetupDataState && state.error != null) {
                        context.showCustomeAlert(state.error, SnackBarType.error);
                      } else if (state is SaveSetupDataState && state.isSuccess) {
                        context.showCustomeAlert('Your Data Saved Successfully!', SnackBarType.success);
                        showSetupGuide(false);

                        context.read<MainScreenBloc>().add(const InitalEventsCall());

                        context
                            .read<MenuDrawerCubit>()
                            .changeBodyContent(menuItem: MenuModel.exploreAndSetup.getRelatedMenuItem());
                      }
                    },
                    buildWhen: (previous, current) => current is SaveSetupDataState,
                    builder: (context, state) => state is SaveSetupDataState && state.isLoading
                        ? const LoadingWidget()
                        : ValueListenableBuilder(
                            valueListenable: context.watch<SignUpBloc>().saveSignupStepsParameter.doneSteps,
                            builder: (context, value, child) {
                              return RoundedBtnWidget(
                                onTap: () {
                                  if (_sliderCurrentIndex.value == 4 &&
                                      context.read<SignUpBloc>().saveSignupStepsParameter.businessTypeId !=
                                          1) {
                                    _sliderCurrentIndex.value = 6;

                                    context.read<SignUpBloc>().saveSignupStepsParameter.resetKitchenSetup();

                                    _pageViewController.jumpToPage((_sliderCurrentIndex).toInt());
                                  } else {
                                    if (context.read<SignUpBloc>().canGoNext(
                                        page:
                                            SignupSetupGuideStep.values[_sliderCurrentIndex.value.toInt()])) {
                                      if (_sliderCurrentIndex.value == 6) {
                                        context.read<SignUpBloc>().add(const SaveSetupGuideData());
                                      } else {
                                        _pageViewController.jumpToPage((++_sliderCurrentIndex.value).toInt());
                                      }
                                    }
                                  }

                                  context.read<SignUpBloc>().saveSignupStepsParameter.doneSteps.value = false;
                                },
                                btnText: 'Next',
                                bgColor: !context.read<SignUpBloc>().canGoNext(
                                        page: SignupSetupGuideStep.values[_sliderCurrentIndex.value.toInt()])
                                    ? Colors.grey
                                    : context.colorScheme.primaryColor,
                                btnTextStyle:
                                    context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                                leadingIcon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                width: 100,
                                height: 35,
                              );
                            }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
