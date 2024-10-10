import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:merchant_dashboard/feature/merchant_info/presentation/widgets/merchant_logo_widget.dart';
import 'package:merchant_dashboard/feature/settings/presentation/widgets/parameter_settings_screen.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/radio_button_widget.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';
import 'package:merchant_dashboard/widgets/select_images_widget.dart';

import '../../../../generated/l10n.dart';
import '../../../../injection.dart';
import '../../../../theme/theme_data.dart';
import '../../../../widgets/app_status_toggle_widget.dart';
import '../../../../widgets/item_hint_textfield_widget.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/rounded_btn.dart';
import '../../../../widgets/rounded_dropdown_list.dart';
import '../../../../widgets/rounded_text_input.dart';
import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../../../widgets/tooltip_widget.dart';
import '../../../merchant_info/presentation/pages/merchant_info_screen.dart';
import '../../../products/presentation/widgets/product_details_widgets/image_selection_section_widget.dart';
import '../../data/models/enums/print_order_options.dart';
import '../../data/models/enums/print_trx_options.dart';
import '../blocs/device_cubit.dart';

class DeviceSettingsWidget extends StatefulWidget {
  const DeviceSettingsWidget({super.key});

  @override
  State<DeviceSettingsWidget> createState() => _DeviceSettingsWidgetState();
}

class _DeviceSettingsWidgetState extends State<DeviceSettingsWidget>
    with DownloadUtils {
  @override
  void initState() {
    super.initState();

    context.read<DeviceCubit>()
      ..getOptionalParams()
      ..getPOSsettings();
  }
  //
  // final _param1Contorller = TextEditingController();
  // final _param3Contorller = TextEditingController();
  // final _param2Contorller = TextEditingController();
  // bool _isParam1Enabled = false;
  // bool _isParam2Enabled = false;
  // bool _isParam3Enabled = false;

  int queueAllowed = 0;

  int _selectedPOSOrderPrintTypeId =
      PrintOrderOptionsEnum.none.posOrderPrintType;
  int _selectedPOSTransactionPrintTypeId =
      PrintTrxOptionsEnum.none.posTransactionPrintType;

  final List<(int, String)> merchantCopies = const [
    (0, "False"),
    (1, "True"),
    (2, "Ask"),
  ];
  int selectedMerchantCopy = -1;

  bool printAllowed = false;
  bool rePrint = false;
  final _footerController = TextEditingController();

  String? footerLogo;
  String? printingLogo;

  XFile? uploadedFooterLogo;
  XFile? uploadedPrintingLogo;

  final List<(int, String)> discountTypes = const [
    (0, "False"),
    (1, "Value"),
    (2, "Percentage"),
    (3, "User Selection"),
  ];
  int selectedDiscount = 0;

  @override
  Widget build(BuildContext context) {
    return ScrollableWidget(
      scrollViewPadding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    context.watch<MenuDrawerCubit>().selectedPageContent.text,
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  context.sizedBoxWidthMicro,
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: Colors.black,
                      )),
                ],
              ),
              context.sizedBoxHeightUltraSmall,
              RoundedBtnWidget(
                btnPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                onTap: () => openWhatsAppLink(
                    defaultText:
                        'Request POS device\nBranchId: ${getIt<MainScreenBloc>().selectedMerchantBranch.merchantId}\nBranchName: ${getIt<MainScreenBloc>().selectedMerchantBranch.merchantName}'),
                btnText: 'Request POS device',
              )
            ],
          ),
          context.sizedBoxHeightSmall,
          Visibility(
            visible: context.select((DeviceCubit bloc) => bloc.hasDevice),
            child: BlocConsumer<DeviceCubit, DeviceState>(
              listener: (context, state) {
                switch (state) {
                  // case (GetOptionalParamsStates st) when st.isSuccess:
                  //   {
                  //     _isParam1Enabled =
                  //         context.read<DeviceCubit>().isParam1Enabled.value;
                  //     _isParam2Enabled =
                  //         context.read<DeviceCubit>().isParam2Enabled.value;
                  //     _isParam3Enabled =
                  //         context.read<DeviceCubit>().isParam3Enabled.value;
                  //
                  //     _param1Contorller.text =
                  //         context.read<DeviceCubit>().param1Value.value;
                  //     _param2Contorller.text =
                  //         context.read<DeviceCubit>().param2Value.value;
                  //     _param3Contorller.text =
                  //         context.read<DeviceCubit>().param3Value.value;
                  //   }
                  case (GetPOSSettingsState st) when st.posSettings != null:
                    {
                      queueAllowed = state.posSettings!.queueAllowed;
                      selectedDiscount = state.posSettings!.discountAllowed;

                      selectedMerchantCopy = state.posSettings!.merchantCopy;
                      printAllowed = state.posSettings!.printAllowed;
                      rePrint = state.posSettings!.rePrint;
                      _footerController.text = state.posSettings!.footerMessage;
                      footerLogo = state.posSettings!.footerLogoLink;
                      printingLogo = state.posSettings!.printingLogoLink;

                      _selectedPOSOrderPrintTypeId = state
                          .posSettings!.printOrderOptionsEnum.posOrderPrintType;
                      _selectedPOSTransactionPrintTypeId = state.posSettings!
                          .printTrxOptionsEnum.posTransactionPrintType;

                      setState(() {});
                    }
                  case (UpdateOptionalParamsState st)
                      when st.errorMessage != null:
                    context.showCustomeAlert(
                        st.errorMessage, SnackBarType.error);
                  case (UpdateOptionalParamsState st) when st.isSuccess:
                    context.showCustomeAlert(
                        S.current.updateOptionalParamsSuccessfully,
                        SnackBarType.success);
                  case (UpdatePOSSettingsState st) when st.errorMessage != null:
                    context.showCustomeAlert(
                        st.errorMessage, SnackBarType.error);
                  case (UpdatePOSSettingsState st) when st.isSuccess:
                    context.showCustomeAlert(
                        S.current.updatePOSParamsSuccessfully,
                        SnackBarType.success);
                    default:{}
                }
              },
              builder: (context, state) {
                return Wrap(
                  runSpacing: 12,
                  spacing: 12,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 430
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Queue
                          ContainerSetting(
                            child: ParameterToggleOptionWidget(
                              key: ValueKey(queueAllowed),
                              title: S.current.queue,
                              subTitle: S.current.manageCustomerOrderAndLines,
                              flag: queueAllowed == 1,
                              onToggleChanged: (flag) {
                                setState(
                                      () => queueAllowed = flag ? 1 : 0,
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 12,),


                          ///discount Type
                          ContainerSetting(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(S.current.discountType,
                                      style: context.textTheme.titleSmall
                                          ?.copyWith(fontWeight: FontWeight.bold,color: AppColors.headerColor)),
                                  context.sizedBoxHeightMicro,
                                  Text(S.current.managerDiscount,
                                      style: context.textTheme.titleSmall
                                          ?.copyWith(color: AppColors.gray)),
                                  context.sizedBoxHeightExtraSmall,
                                  Wrap(
                                    runSpacing: 9,
                                    spacing: 9,
                                    children: discountTypes
                                        .map(
                                          (e) => RadioButtonWidget(
                                            onChange: (p0) {
                                              setState(() {
                                                selectedDiscount = p0 ?? -1;
                                              });
                                            },
                                            value: e.$1,
                                            groupValue: selectedDiscount,
                                            name: e.$2,
                                          ),
                                    )
                                        .toList(),
                                  )
                                ],
                              )),


                          SizedBox(height: 12,),

                          /// IMAGES
                          Column(
                            children: [

                              ///header
                              ContainerSetting(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.current.headerLogo,
                                      style: context.textTheme.titleSmall
                                          ?.copyWith(fontWeight: FontWeight.bold,color: AppColors.headerColor),
                                    ),
                                    context.sizedBoxHeightMicro,
                                    Text(
                                      S.current.headerLogoMsg,
                                      style: context.textTheme.titleSmall
                                          ?.copyWith(color: AppColors.gray),
                                    ),
                                    context.sizedBoxHeightMicro,
                                    SelectImagesWidget(
                                      imageUrl: printingLogo,
                                      onImageChanged: (file) {
                                        uploadedPrintingLogo = file;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),


                              SizedBox(height: 12,),

                              ///footer
                              ContainerSetting(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.current.footerLogo,
                                      style: context.textTheme.titleSmall
                                          ?.copyWith(fontWeight: FontWeight.bold,color: AppColors.headerColor),
                                    ),
                                    context.sizedBoxHeightMicro,
                                    Text(
                                      S.current.footerLogoMsg,
                                      style: context.textTheme.titleSmall
                                          ?.copyWith(color: AppColors.gray),
                                    ),
                                    context.sizedBoxHeightMicro,
                                    SelectImagesWidget(
                                      imageUrl: footerLogo,
                                      onImageChanged: (file) {
                                        uploadedFooterLogo = file;
                                        setState(() {});
                                      },
                                    ),
                                    context.sizedBoxHeightMicro,
                                    Text(S.current.footerMsg,
                                        style: context.textTheme.titleSmall
                                            ?.copyWith(fontWeight: FontWeight.bold,color: AppColors.headerColor)),
                                    context.sizedBoxHeightUltraSmall,
                                    RoundedTextInputWidget(
                                      hintText: S.current.footerMsg,
                                      textEditController: _footerController,
                                      maxLines: 2,
                                    ),
                                    context.sizedBoxHeightExtraSmall,
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12,),
                          ///SAVE BUTTON
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 450),
                            child: Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: (state is UpdatePOSSettingsState &&
                                      state.isLoading)
                                  ? const LoadingWidget()
                                  : RoundedBtnWidget(
                                      onTap: () {
                                        context.read<DeviceCubit>().updatePOSSettings(
                                              printAllowed: printAllowed,
                                              footerMessage:
                                                  _footerController.text.trim(),
                                              rePrint: rePrint,
                                              merchantCopy: selectedMerchantCopy,
                                              discountAllowed: selectedDiscount,
                                              footerLogo: uploadedFooterLogo,
                                              printingLogo: uploadedPrintingLogo,
                                              queueAllowed: queueAllowed,
                                              posTrxFromPOS:
                                                  _selectedPOSTransactionPrintTypeId,
                                              posOrderFromPOS:
                                                  _selectedPOSOrderPrintTypeId,
                                            );
                                      },
                                      btnText: S.current.save,
                                      width: 200,
                                      height: 40,
                                    ),
                            ),
                          ),
                          context.sizedBoxHeightSmall,
                        ],
                      ),
                    ),

                    ///printing
                    ContainerSetting(
                        maxWidth: 410,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.current.printing,
                              style: context.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            context.sizedBoxHeightExtraSmall,
                              Divider(endIndent: 10,indent: 10,color: AppColors.gray2,height: 1,thickness: 1,),
                            context.sizedBoxHeightExtraSmall,
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(S.current.printingInvoiceFromPOS,
                                      style: context.textTheme.titleSmall
                                          ?.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  context.sizedBoxWidthMicro,
                                  RoundedDropDownList(
                                      selectedValue:
                                      _selectedPOSTransactionPrintTypeId,
                                      maxWidth: 150,
                                      margin: EdgeInsets.zero,
                                      isExpanded: true,
                                      hintText: '',
                                      onChange: (p0) => setState(() =>
                                      _selectedPOSTransactionPrintTypeId =
                                          p0),
                                      items: PrintTrxOptionsEnum.values
                                          .map((e) => DropdownMenuItem<int>(
                                          value:
                                          e.posTransactionPrintType,
                                          child: Text(
                                            e.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(
                                                color: AppColors
                                                    .black),
                                          )))
                                          .toList()),
                                ],
                            ),
                            context.sizedBoxHeightExtraSmall,
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              Text(S.current.printingOrdersFromPOS,
                                  style: context.textTheme.titleSmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.bold)),
                              context.sizedBoxWidthMicro,
                              RoundedDropDownList(
                                  selectedValue:
                                  _selectedPOSOrderPrintTypeId,
                                  maxWidth: 150,
                                  margin: EdgeInsets.zero,
                                  isExpanded: true,
                                  hintText: '',
                                  onChange: (p0) => setState(() =>
                                  _selectedPOSOrderPrintTypeId = p0),
                                  items: PrintOrderOptionsEnum.values
                                      .map((e) => DropdownMenuItem<int>(
                                      value: e.posOrderPrintType,
                                      child: Text(
                                        e.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                            color: AppColors.black),
                                      )))
                                      .toList()),
                            ]),
                            context.sizedBoxHeightExtraSmall,

                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              Text(S.current.printingAllow,
                                  style: context.textTheme.titleSmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.bold)),
                              AppSwitchToggle(
                                currentStatus: printAllowed,
                                onStatusChanged: (status) =>
                                    setState(() => printAllowed = status),
                                scale: .7,
                              ),
                            ]),
                            context.sizedBoxHeightExtraSmall,
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              Text(S.current.reprint,
                                  style: context.textTheme.titleSmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.bold)),
                              AppSwitchToggle(

                                currentStatus: rePrint,
                                onStatusChanged: (status) =>
                                    setState(() => rePrint = status),
                                scale: .7,
                              ),
                            ]),
                            context.sizedBoxHeightExtraSmall,

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(S.current.merchantCopy,
                                      style: context.textTheme.titleSmall
                                          ?.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  context.sizedBoxWidthMicro,
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: merchantCopies
                                        .map(((int, String) e) =>
                                        RadioButtonWidget(name: e.$2,
                                          value: e.$1, groupValue: selectedMerchantCopy,
                                          onChange: (p0) {
                                            setState(() =>
                                            selectedMerchantCopy =
                                                p0 ?? -1);
                                          },)
                                    )
                                        .toList(),),
                                  )

                                ],
                            ),
                            context.sizedBoxHeightExtraSmall,
                          ],
                        ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}