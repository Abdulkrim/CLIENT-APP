import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/app_status_toggle_widget.dart';
import 'package:merchant_dashboard/widgets/item_hint_textfield_widget.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_checkbox.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';

import '../../../../generated/l10n.dart';
import '../../../../injection.dart';
import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../blocs/loyalty_settings/loyalty_settings_cubit.dart';

class LoyaltySettingsWidget extends StatefulWidget {
  const LoyaltySettingsWidget({super.key});

  @override
  State<LoyaltySettingsWidget> createState() => _LoyaltySettingsWidgetState();
}

class _LoyaltySettingsWidgetState extends State<LoyaltySettingsWidget> {
  final _rechargePointController = TextEditingController();
  final _maxExpiringPointToNotifyCustomerController = TextEditingController();
  final _remainedDaysToExpirePointToNotifyCustomerController = TextEditingController();
  final _redeemPointController = TextEditingController();
  final _pointExpireDurationController = TextEditingController();
  final _splitPayController = TextEditingController();

  bool _isLoyaltyEnable = false;
  bool _isEnableSplitPay = false;

  @override
  void initState() {
    super.initState();

    if (getIt<MainScreenBloc>().selectedMerchantBranch.hasData) {
      context.read<LoyaltySettingsCubit>().getLoyaltySettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoyaltySettingsCubit, LoyaltySettingsState>(
      listener: (context, state) {
        if (state is ManageLoyaltySettingsState && state.isSuccess) {
          context.showCustomeAlert(S.current.changesUpdateSuccessfully, SnackBarType.success);
        } else if (state is ManageLoyaltySettingsState && state.errorMessage != null) {
          context.showCustomeAlert(state.errorMessage, SnackBarType.error);
        }

        if (state is GetLoyaltySettingsState && state.isSuccess) {
          _rechargePointController.text = context.read<LoyaltySettingsCubit>().loyaltySettings!.rechargePoint.toString();
          _redeemPointController.text = context.read<LoyaltySettingsCubit>().loyaltySettings!.redeemPoint.toString();
          _pointExpireDurationController.text = context.read<LoyaltySettingsCubit>().loyaltySettings!.expireDuration.toString();
          _splitPayController.text = context.read<LoyaltySettingsCubit>().loyaltySettings!.maxPercentOfPoint.toString();

          _maxExpiringPointToNotifyCustomerController.text =
              context.read<LoyaltySettingsCubit>().loyaltySettings!.maxExpiringPoint.toString();

          _remainedDaysToExpirePointToNotifyCustomerController.text =
              context.read<LoyaltySettingsCubit>().loyaltySettings!.remainedDaysToExpirePoint.toString();

          _isLoyaltyEnable = context.read<LoyaltySettingsCubit>().loyaltySettings!.loyaltyAllowed;
          _isEnableSplitPay = context.read<LoyaltySettingsCubit>().loyaltySettings!.branchIsSplitPaymentByPointsAllowed;
          setState(() {});
        }
      },
      builder: (context, state) {
        return (state is GetLoyaltySettingsState && state.isLoading)
            ? const LoadingWidget()
            : Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.current.loyalty,
                        style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      context.sizedBoxHeightExtraSmall,
                      AppSwitchToggle(
                        currentStatus: _isLoyaltyEnable,
                        onStatusChanged: (status) => setState(() => _isLoyaltyEnable = status),
                        label: S.current.loyalty,
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Visibility(
                          visible: _isLoyaltyEnable,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ItemHintTextFieldWidget(
                                textEditingController: _rechargePointController,
                                hintText: S.current.rechargePoint,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                isRequired: true,
                              ),
                              context.sizedBoxHeightExtraSmall,
                              ItemHintTextFieldWidget(
                                textEditingController: _redeemPointController,
                                hintText: S.current.redeemPoint,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                isRequired: true,
                              ),
                              context.sizedBoxHeightExtraSmall,
                              ItemHintTextFieldWidget(
                                textEditingController: _remainedDaysToExpirePointToNotifyCustomerController,
                                hintText: S.current.remainedDaysToExpirePointToNotifyCustomer,
                                keyboardType: TextInputType.number,
                                isRequired: true,
                              ),
                              context.sizedBoxHeightExtraSmall,
                              ItemHintTextFieldWidget(
                                textEditingController: _maxExpiringPointToNotifyCustomerController,
                                hintText: S.current.maxExpiringPointToNotifyCustomer,
                                keyboardType: TextInputType.number,
                                isRequired: true,
                              ),
                              context.sizedBoxHeightExtraSmall,
                              ItemHintTextFieldWidget(
                                textEditingController: _pointExpireDurationController,
                                hintText: S.current.pointExpireDuration,
                                keyboardType: TextInputType.number,
                                isRequired: true,
                              ),
                              context.sizedBoxHeightExtraSmall,
                              RoundedCheckBoxWidget(
                                onChnageCheck: (check) => setState(() => _isEnableSplitPay = check),
                                text: S.current.enableSplitPaymentTill,
                                initalCheck: _isEnableSplitPay,
                              ),
                              context.sizedBoxHeightExtraSmall,
                              Visibility(
                                visible: _isEnableSplitPay,
                                child: RoundedTextInputWidget(
                                  hintText: '50',
                                  textEditController: _splitPayController,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                  isRequired: true,
                                  suffixIcon: const Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('%'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      context.sizedBoxHeightExtraSmall,
                      (state is ManageLoyaltySettingsState && state.isLoading)
                          ? const LoadingWidget()
                          : RoundedBtnWidget(
                              onTap: () => _showMyDialog(
                                onYesTapped: () {
                                  context.read<LoyaltySettingsCubit>().manageLoyaltySettings(
                                      loyaltyAllowed: _isLoyaltyEnable,
                                      isSplitAllowed: _isEnableSplitPay,
                                      maxExpiringPointToNotifyCustomer:
                                          num.tryParse(_maxExpiringPointToNotifyCustomerController.text) ?? 0,
                                      remainedDaysToExpirePointToNotifyCustomer:
                                          num.tryParse(_remainedDaysToExpirePointToNotifyCustomerController.text) ?? 0,
                                      rechargePoint: num.tryParse(_rechargePointController.text) ?? 0,
                                      redeemPoint: num.tryParse(_redeemPointController.text.trim()) ?? 0,
                                      expireDuration: num.tryParse(_pointExpireDurationController.text.trim()) ?? 0,
                                      maxPercent: num.tryParse(_splitPayController.text.trim()) ?? 0);
                                },
                              ),
                              btnPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              btnMargin: const EdgeInsets.only(right: 24),
                              width: 300,
                              btnText: S.current.save,
                            )
                    ],
                  ),
                ),
              );
      },
    );
  }

  Future<void> _showMyDialog({required Function onYesTapped}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text(S.current.loyaltySettings),
          content: Text(S.current.applyLoyaltyWarning),
          actions: [
            TextButton(
              onPressed: () {
                onYesTapped();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
