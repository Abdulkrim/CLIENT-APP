import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/entity/branch_time_shifts.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/responese/branch_time_shifts_response.dart';
import 'package:merchant_dashboard/feature/business_hours/presentation/blocs/cubit/branch_shift_cubit.dart';
import 'package:merchant_dashboard/feature/business_hours/presentation/pages/business_hours_screen.dart';
import 'package:merchant_dashboard/feature/settings/presentation/widgets/parameter_settings_screen.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/item_hint_textfield_widget.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../../generated/l10n.dart';
import '../../../../business_hours/data/models/responese/working_hours_response.dart';
import 'business_hours_widget.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../blocs/online_ordering_cubit.dart';
import 'package:flutter/foundation.dart';

class DesktopOnlineOrderingScreen extends StatefulWidget {
  const DesktopOnlineOrderingScreen({super.key});

  @override
  State<DesktopOnlineOrderingScreen> createState() => _DesktopOnlineOrderingScreenState();
}

class _DesktopOnlineOrderingScreenState extends State<DesktopOnlineOrderingScreen> with DownloadUtils, DateTimeUtilities {
  bool _onlineOrdering = false;
  bool _orderViaWhatsapp = false;

  String domainAddress = '';

  final _englishMessageController = TextEditingController();
  final _arabicMessageController = TextEditingController();
  final _frenchMessageController = TextEditingController();
  final _turkishMessageController = TextEditingController();
  final _whatsappController = TextEditingController();

  /*  bool isMessageUpdated = false;
    bool isOnlineSettingUpdated = false;
    bool isBusinessHourUpdated = false;*/

  bool onlineOrderingLoading = false;
  bool timeShiftLoading = false;

  @override
  void initState() {
    super.initState();

    context.read<OnlineOrderingCubit>()
      ..getOnlineOrderingSettings()
      ..getMessagesSettings();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableWidget(
        scrollViewPadding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.watch<MenuDrawerCubit>().selectedPageContent.text,
              style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            context.sizedBoxHeightExtraSmall,

            Wrap(
              children: [
                MultiBlocListener(
                  listeners: [
                    BlocListener<OnlineOrderingCubit, OnlineOrderingState>(
                      listener: (context, state) {
                        switch (state) {
                          case (GetOnlineOrderingSettingsState state) when state.settings != null:
                            {
                              _onlineOrdering = state.settings!.onlineOrderingAllowed;
                              _orderViaWhatsapp = state.settings!.canTakeOrderViaWhatsapp;
                              domainAddress = state.settings!.domainAddress;
                              _whatsappController.text = state.settings!.orderWhatsAppNumber;

                              setState(() {});
                            }
                          case (GetMessagesSettingsState state) when state.messages != null:
                            {
                              _englishMessageController.text =
                                  state.messages!.firstWhereOrNull((element) => element.languageName == 'en')?.message ?? '';
                              _turkishMessageController.text =
                                  state.messages!.firstWhereOrNull((element) => element.languageName == 'tr')?.message ?? '';
                              _arabicMessageController.text =
                                  state.messages!.firstWhereOrNull((element) => element.languageName == 'ar')?.message ?? '';
                              _frenchMessageController.text =
                                  state.messages!.firstWhereOrNull((element) => element.languageName == 'fr')?.message ?? '';
                            }

                          case (LoadingUpdateInfoState state) when state.errorMessage != null:
                            context.showCustomeAlert(state.errorMessage);
                          case (LoadingUpdateInfoState state) when state.isSuccess:
                            {
                              context.showCustomeAlert(S.current.onlineOrderingSettingsSavedSuccessfully);
                              context.read<MenuDrawerCubit>().isPreviousScreenHasData = false;
                            }
                          default:
                            null;
                        }
                        setState(() => onlineOrderingLoading = state is LoadingUpdateInfoState && state.isLoading);
                      },
                    ),
                    BlocListener<BranchShiftCubit, BranchShiftState>(
                      listener: (context, state) {
                        if (state is ManageBranchShiftState && state.errorMsg != null) {
                          context.showCustomeAlert(state.errorMsg, SnackBarType.error);
                        }

                        setState(() => timeShiftLoading = state is ManageBranchShiftState && state.isLoading);
                      },
                    ),
                  ],
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ContainerSetting(
                        maxWidth: 530,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///onlineOrder
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ParameterToggleOptionWidget(
                                    key: ObjectKey(_onlineOrdering),
                                    onToggleChanged: (status) => setState(() {
                                          _onlineOrdering = status;
                                        }),
                                    flag: _onlineOrdering,
                                    subTitle: S.current.onlineOrderingTooltip,
                                    title: S.current.onlineOrdering),
                                context.sizedBoxHeightUltraSmall,
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(12.0),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(color: AppColors.black),
                                      ),
                                    ),
                                    onPressed: () async => openLink(url: 'https://$domainAddress'),
                                    child: Text(
                                      '$domainAddress 🔗',
                                      style: context.textTheme.bodyMedium?.copyWith(color: AppColors.headerColor),
                                    )),
                              ],
                            ),

                            context.sizedBoxHeightExtraSmall,

                            ///messages
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 15,
                                  runSpacing: 15,
                                  children: [
                                    ItemHintTextFieldWidget(
                                      hintText: S.current.storeStatus(S.current.engMessage),
                                      textEditingController: _englishMessageController,
                                      width: 350,
                                      descriptionText: S.current.closeMessageTooltip,
                                    ),
                                    // context.sizedBoxHeightUltraSmall,
                                    ItemHintTextFieldWidget(
                                      hintText: S.current.storeStatus(S.current.arMessage),
                                      textEditingController: _arabicMessageController,
                                      width: 350,
                                    ),
                                    // context.sizedBoxHeightUltraSmall,
                                    ItemHintTextFieldWidget(
                                      hintText: S.current.storeStatus(S.current.trMessage),
                                      textEditingController: _turkishMessageController,
                                      width: 350,
                                    ),
                                    // context.sizedBoxHeightUltraSmall,
                                    ItemHintTextFieldWidget(
                                      hintText: S.current.storeStatus(S.current.frMessage),
                                      textEditingController: _frenchMessageController,
                                      width: 350,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                    context.sizedBoxHeightExtraSmall,
                    ContainerSetting(
                        maxWidth: 530,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ParameterToggleOptionWidget(
                                key: ObjectKey(_orderViaWhatsapp),
                                onToggleChanged: (status) => setState(() {
                                      _orderViaWhatsapp = status;
                                    }),
                                flag: _orderViaWhatsapp,
                                subTitle: S.current.orderViaWhatsappTooltip,
                                title: S.current.orderViaWhatsapp),
                            context.sizedBoxHeightExtraSmall,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(S.current.whatsappNumberForOrders,
                                    style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                                context.sizedBoxHeightMicro,
                                RoundedTextInputWidget(
                                  width: 350,
                                  hintText: '971501231234',
                                  textEditController: _whatsappController,
                                  keyboardType: TextInputType.number,
                                  // prefixIconConstraints: BoxConstraints(maxHeight: 30,maxWidth: 40),
                                  prefixWidget: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          Assets.iconsWhatsapp,
                                          width: 20,
                                          height: 20,
                                          color: Colors.green,
                                        ),
                                        const Text('  +  '),
                                      ],
                                    ),
                                  ),
                                  onChange: (text) {},
                                ),
                              ],
                            ),
                          ],
                        )),
                  ]),
                ),
                const OnlineOrderBusinessHoursWidget(),
              ],
            ),

            ///save button
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10, end: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: (timeShiftLoading || onlineOrderingLoading)
                        ? const LoadingWidget()
                        : RoundedBtnWidget(
                            width: 150,
                            onTap: () {
                              // if (isOnlineSettingUpdated) {
                              context.read<OnlineOrderingCubit>().saveOnlineOrderingSettings(
                                    onlineOrderingAllowed: _onlineOrdering,
                                    whatsappOrderingAllowed: _orderViaWhatsapp,
                                    whatsappNumber: '+${_whatsappController.text.trim()}',
                                  );
                              // }
                              // if (isMessageUpdated) {
                              context.read<OnlineOrderingCubit>().saveMessagesSettings(
                                  engMessage: _englishMessageController.text.trim(),
                                  frMessage: _frenchMessageController.text.trim(),
                                  arMessage: _arabicMessageController.text.trim(),
                                  trMessage: _turkishMessageController.text.trim());
                              // }

                              // if (isBusinessHourUpdated) {
                              var shift = context.read<BranchShiftCubit>().branchShifts;

                              for (var element in shift?.workingHours ?? <({List<WorkingHours> hours, WorkDay workday})>[]) {
                                if (element.hours.firstWhereOrNull((element) =>
                                        (element.from != null && element.to == null) ||
                                        (element.from == null && element.to != null)) !=
                                    null) {
                                  context.showCustomeAlert(S.current.emptyHoursError);
                                  return;
                                }

                                if (element.hours
                                        .firstWhereOrNull((element) => element.fromType == null || element.toType == null) !=
                                    null) {
                                  context.showCustomeAlert(S.current.timeTypeFormat);
                                  return;
                                }
                              }

                              context.read<BranchShiftCubit>().manageWorkTypeShiftTimes(
                                  workType: WorkType.serviceProvision.workTypeCode, shifts: shift?.workingHours ?? []);
                              // }
                            },
                            btnText: S.current.save,
                            btnPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                          ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
