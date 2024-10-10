import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/settings/data/models/entity/payment_type.dart';
import 'package:merchant_dashboard/feature/settings/presentation/widgets/manage_payement_modes_widget.dart';
import 'package:merchant_dashboard/feature/settings/presentation/widgets/parameter_settings_screen.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/radio_button_widget.dart';

import '../../../../injection.dart';

import '../../../../widgets/item_hint_textfield_widget.dart';
import '../../../../widgets/rounded_btn.dart';
import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../blocs/settings_bloc.dart';

class BranchParametersOptions extends StatefulWidget {
  const BranchParametersOptions({super.key});

  @override
  State<BranchParametersOptions> createState() => _BranchParametersOptionsState();
}

class _BranchParametersOptionsState extends State<BranchParametersOptions> {
  @override
  void initState() {
    super.initState();
    /*  if (getIt<MainScreenBloc>().selectedMerchantBranch.hasData) {

    }*/

    context.read<SettingsBloc>()
      ..add(const GetAllPaymentTypes())
      ..add(const GetBranchTaxValue())
      ..add(const GetBranchPaymentSettings());
  }

  bool customerAllowed = false;

  bool selectedClaim = false;

  List<int> selectedPayments = [];

  bool taxAllowed = false;

  final List<(int, String)> taxTypes = const [
    (1, "Exclusive"),
    (2, "Inclusive"),
  ];
  int selectedTaxType = 1;

  final _trnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is GetPaymentSettingsState && state.parameters != null) {
          customerAllowed = state.parameters!.customerAllowed ?? true;
          selectedClaim = state.parameters!.claimAllowed == 0 ? false : true;
          selectedPayments = state.parameters!.payment.map((e) => e.id).toList();
          taxAllowed = state.parameters!.taxAllowed;
          selectedTaxType = state.parameters!.taxTypeId;
          _trnController.text = state.parameters!.trn.toString();



          setState(() {});
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///customer management
          ContainerSetting(
            child: ParameterToggleOptionWidget(
              key: ValueKey(customerAllowed),
              title: S.current.customerManagement,
              subTitle: S.current.customerAllowedTooltip,
              flag: customerAllowed,
              onToggleChanged: (flag) {
                setState(
                  () => customerAllowed = flag,
                );
              },
            ),
          ),
          SizedBox(
            height: 12,
          ),

          ///refund
          ContainerSetting(
            child: ParameterToggleOptionWidget(
              key: ValueKey(selectedClaim),
              title: S.current.claim,
              subTitle: S.current.refund,
              flag: selectedClaim,
              onToggleChanged: (flag) {
                setState(
                  () => selectedClaim = flag,
                );
              },
            ),
          ),
          SizedBox(
            height: 12,
          ),

          // ContainerSetting(
          //   child: Padding(
          //     padding: const EdgeInsets.all(12.0),
          //     child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //       Text(S.current.claim, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),
          //      Row(
          //        crossAxisAlignment: CrossAxisAlignment.center,
          //        children: Claim.values
          //          .map(
          //            (Claim e) => AppSwitchToggle(
          //          label: e.title,
          //          currentStatus: selectedClaim == e.value,
          //          onStatusChanged: (status) => setState(() => selectedClaim = e.value),
          //          scale: .7,
          //        ),
          //      )
          //          .toList(),)
          //     ]),
          //   ),
          // ),

          ///payment
          ManagePaymentModesWidget(
            onPaymentsChanged: (selectedPaymentss) => selectedPayments = selectedPaymentss,
          ),

          SizedBox(
            height: 12,
          ),

          ///tax
          ContainerSetting(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ParameterToggleOptionWidget(
                  key: ValueKey(taxAllowed),
                  onToggleChanged: (flag) {
                    setState(() => taxAllowed = flag);
                  },
                  flag: taxAllowed,
                  subTitle: S.current.branchCountryTaxIs,
                  title: S.current.tax,
                ),
                context.sizedBoxHeightMicro,
                Visibility(
                  visible: taxAllowed,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 15,
                          runSpacing: 15,
                          children: taxTypes.map(
                            (e) {
                              return RadioButtonWidget<int>(
                                name: e.$2,
                                groupValue: selectedTaxType,
                                value: e.$1,
                                onChange: (p0) {
                                  setState(() => selectedTaxType = p0!);
                                },
                              );
                            },
                          ).toList(),
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     RoundedDropDownList(
                        //         margin: EdgeInsets.zero,
                        //         validator: (p0) => (p0.$1 == 0)
                        //             ? S.current.selectTaxType
                        //             : null,
                        //         maxWidth: 200,
                        //         selectedValue: taxTypes.firstWhereOrNull(
                        //             (element) => element.$1 == selectedTaxType),
                        //         isExpanded: false,
                        //         hintText: S.current.taxType,
                        //         onChange: (p0) =>
                        //             setState(() => selectedTaxType = p0.$1),
                        //         items: taxTypes
                        //             .map((e) => DropdownMenuItem<(int, String)>(
                        //                 value: e,
                        //                 child: Text(
                        //                   e.$2,
                        //                   style: Theme.of(context)
                        //                       .textTheme
                        //                       .labelMedium
                        //                       ?.copyWith(
                        //                           color: AppColors.black),
                        //                 )))
                        //             .toList()),
                        //     context.sizedBoxHeightMicro,
                        //     RichText(
                        //         text: TextSpan(children: [
                        //       TextSpan(
                        //           text: S.current.branchCountryTaxIs,
                        //           style: context.textTheme.titleSmall
                        //               ?.copyWith(fontWeight: FontWeight.bold)),
                        //       TextSpan(
                        //         text:
                        //             ' Tax ${context.select((SettingsBloc bloc) => bloc.branchTaxValue?.value)}%',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .titleMedium
                        //             ?.copyWith(color: AppColors.black),
                        //       ),
                        //     ])),
                        //   ],
                        // ),
                        context.sizedBoxHeightExtraSmall,
                        ItemHintTextFieldWidget(
                          isRow: !context.isPhone,
                          width: 150,
                          textEditingController: _trnController,
                          keyboardType: TextInputType.number,
                          hintText: S.current.trn,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 12,
          ),

          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state is UpdatePaymentSettingsState && state.isSuccess) {
                  context.showCustomeAlert(S.current.changesUpdateSuccessfully, SnackBarType.success);
                } else if (state is UpdatePaymentSettingsState && state.error != null) {
                  context.showCustomeAlert(state.error, SnackBarType.error);
                }
              },
              builder: (context, state) => (state is UpdatePaymentSettingsState && state.isLoading)
                  ? const LoadingWidget()
                  : RoundedBtnWidget(
                      onTap: () {
                        if (taxAllowed && selectedTaxType == 0) {
                          context.showCustomeAlert(S.current.selectTaxType);
                          return;
                        }

                        if (selectedPayments.isEmpty) {
                          context.showCustomeAlert(S.current.selectPaymentMode);
                          return;
                        }

                        context.read<SettingsBloc>().add(UpdatePaymentSettings(
                            payments: selectedPayments,
                            claimAllowed: selectedClaim ? 1 : 0,
                            customerAllowed: customerAllowed,
                            taxID: context.read<SettingsBloc>().branchTaxValue?.id ?? 0,
                            taxAllowed: taxAllowed,
                            taxTypeId: selectedTaxType,
                            trn: int.tryParse(_trnController.text.trim()) ?? 0));
                      },
                      btnText: S.current.save,
                      width: 200,
                      height: 40,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
