import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/entity/merchant_information.dart';
import 'package:merchant_dashboard/feature/merchant_info/presentation/blocs/merchant_info_bloc.dart';
import 'package:merchant_dashboard/feature/merchant_info/presentation/widgets/desktop/desktop_merchant_info_body_widget.dart';
import 'package:merchant_dashboard/feature/merchant_info/presentation/widgets/merchant_logo_widget.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/product_details_widgets/image_selection_section_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/item_hint_textfield_widget.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../pages/merchant_info_screen.dart';

class DesktopMerchantInfoUI extends StatefulWidget {
  const DesktopMerchantInfoUI({Key? key}) : super(key: key);

  @override
  State<DesktopMerchantInfoUI> createState() => _DesktopMerchantInfoUIState();
}

class _DesktopMerchantInfoUIState extends State<DesktopMerchantInfoUI> {
  MerchantInformation? merchantInformation;

  TextEditingController _nameController = TextEditingController();

  TextEditingController _contactNumController = TextEditingController();

  TextEditingController _facebookController = TextEditingController();

  TextEditingController _instagramController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _twitterController = TextEditingController();

  TextEditingController _businessAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    merchantInformation =
        context.select<MerchantInfoBloc, MerchantInformation?>(
                (value) => value.merchantInformation);
    initControllerValue();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.watch<MenuDrawerCubit>().selectedPageContent.text,
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        context.sizedBoxHeightExtraSmall,
        Wrap(
          runSpacing: 10,
          children: [
            MerchantLogoWidget(
              title: S.current.defaultLogo,
              tooltipText: 'Will Be shown when items image not uploaded',
              url: context.select<MerchantInfoBloc, String>(
                  (value) => value.merchantInformation?.defaultLogoLink ?? ''),
              onDeleteTap: () => context.read<MerchantInfoBloc>().add(
                  DeleteMerchantLogo(context
                      .read<MerchantInfoBloc>()
                      .merchantInformation
                      ?.defaultLogoLink)),
              onSaveTapped: (image) => context.read<MerchantInfoBloc>().add(
                  UpdateMerchantLogoEvent(
                      image: image, imgKey: LogoTypes.defaulltLogo.typeId)),
            ),
            MerchantLogoWidget(
              title: S.current.logo,
              tooltipText: 'This is the logo will be display on your site',
              onDeleteTap: () => context.read<MerchantInfoBloc>().add(
                  DeleteMerchantLogo(context
                      .read<MerchantInfoBloc>()
                      .merchantInformation
                      ?.logoLink)),
              url: context.select<MerchantInfoBloc, String>(
                  (value) => value.merchantInformation?.logoLink ?? ''),
              onSaveTapped: (image) => context.read<MerchantInfoBloc>().add(
                  UpdateMerchantLogoEvent(
                      image: image, imgKey: LogoTypes.logo.typeId)),
            ),


            ContainerSetting(
              maxWidth: 560,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.storeDetails,
                    style: context.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold,color: AppColors.headerColor),
                  ),
                  context.sizedBoxHeightExtraSmall,
                  Divider(),
                  context.sizedBoxHeightExtraSmall,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ItemHintTextFieldWidget(
                            textEditingController: _nameController,
                            hintText: S.current.branchName,
                            isEnable: false),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: ItemHintTextFieldWidget(

                          hintText: S.current.contactNumber,
                          keyboardType: TextInputType.number,
                          prefixWidget: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text('  +')],
                          ),
                          textEditingController: _contactNumController,
                          isRequired: true,
                        ),
                      ),
                    ],
                  ),
                  context.sizedBoxHeightSmall,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ItemHintTextFieldWidget(

                            textEditingController: _emailController,
                            hintText: S.current.email),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: ItemHintTextFieldWidget(

                          isRequired: true,
                          hintText: S.current.businessAddress,
                          textEditingController: _businessAddressController,

                        ),
                      ),
                    ],
                  ),
                  context.sizedBoxHeightSmall,
                  context.sizedBoxHeightSmall,
                ],
              ),
            ),


            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 580
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContainerSetting(
                    maxWidth: 580,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.current.socialMediaLink,
                          style: context.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold,color: AppColors.headerColor),
                        ),
                        context.sizedBoxHeightExtraSmall,
                        Divider(),
                        context.sizedBoxHeightExtraSmall,
                        Row(
                          children: [
                            Expanded(
                              child: ItemHintTextFieldWidget(
                                  prefixIconConstraints:
                                  const BoxConstraints(maxWidth: 25, maxHeight: 25),
                                  prefixWidget: SvgPicture.asset(Assets.iconsFacebook),
                                  width: 300,
                                  textEditingController: _facebookController,
                                  hintText: S.current.facebookLink),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ItemHintTextFieldWidget(
                                  prefixIconConstraints:
                                  const BoxConstraints(maxWidth: 25, maxHeight: 25),
                                  width: 300,
                                  prefixWidget: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(Assets.iconsInstagram),
                                  ),
                                  textEditingController: _instagramController,
                                  hintText: S.current.instagramLink),
                            ),
                          ],
                        ),
                        context.sizedBoxHeightSmall,
                        ItemHintTextFieldWidget(
                            prefixIconConstraints:
                            const BoxConstraints(maxWidth: 25, maxHeight: 25),
                            prefixWidget: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SvgPicture.asset(Assets.iconsTwiter),
                            ),
                            textEditingController: _twitterController,
                            hintText: S.current.twitter)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: BlocBuilder<MerchantInfoBloc, MerchantInfoState>(
                      builder: (context, state) {
                        return Visibility(
                          visible: (state is UpdateMerchantInfoState ||
                              state is DeleteMerchantLogoState) &&
                              state.isLoading,
                          replacement: RoundedBtnWidget(
                            onTap: () {
                              context.read<MerchantInfoBloc>().add(
                                  UpdateMerchantInfoEvent(
                                      firstPhoneNumber:
                                      '+${_contactNumController.text.trim()}',
                                      branchAddress:
                                      _businessAddressController.text.trim(),
                                      email: _emailController.text.trim(),
                                      facebook: _facebookController.text.trim(),
                                      instagram: _instagramController.text.trim(),
                                      twitter: _twitterController.text.trim()));
                            },
                            btnText: S.current.save,
                            width: 150,
                            height: 40,
                            btnTextStyle: context.textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          child: const LoadingWidget(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ],
    );
  }

  initControllerValue() {
    _nameController = TextEditingController(text: merchantInformation?.name);
    _contactNumController =
        TextEditingController(text: merchantInformation?.firstPhoneNumber);
    _facebookController =
        TextEditingController(text: merchantInformation?.facebookLink);
    _instagramController =
        TextEditingController(text: merchantInformation?.instagramLink);
    _emailController = TextEditingController(text: merchantInformation?.email);
    _twitterController =
        TextEditingController(text: merchantInformation?.twitter);
    _businessAddressController =
        TextEditingController(text: merchantInformation?.branchAddress);
  }


}
