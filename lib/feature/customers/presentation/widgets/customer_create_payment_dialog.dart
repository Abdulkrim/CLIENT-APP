import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/customers/presentation/blocs/payment/customer_payment_cubit.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/settings/data/models/entity/payment_type.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';

import '../../../../generated/l10n.dart';

class CustomerCreatePaymentDialog extends StatefulWidget {
  const CustomerCreatePaymentDialog({super.key, required this.customerId, required this.totalCreditBalance});

  final num totalCreditBalance;
  final String customerId;

  @override
  State<CustomerCreatePaymentDialog> createState() => _CustomerCreatePaymentDialogState();
}

class _CustomerCreatePaymentDialogState extends State<CustomerCreatePaymentDialog> {
  final List<int> _selectPayModeIDs = [];

  _getRemainingBalance() {
    if (widget.totalCreditBalance > 0) {
      List<PaymentType> enteredList =
          context.read<CustomerPaymentCubit>().paymentTypes.where((element) => element.amount != 0).toList();

      num totalAmount = enteredList.fold(0.0, (sum, paymentType) => sum + paymentType.amount);

      return (widget.totalCreditBalance - totalAmount).toString();
    } else {
      return '0';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SizedBox(
            width: !context.isPhone ? 400 : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                  padding: const EdgeInsets.all(10.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.current.createPayment, style: context.textTheme.titleMedium?.copyWith(color: Colors.white)),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(S.current.creditBalance, textAlign: TextAlign.center, style: context.textTheme.bodyMedium),
                      context.sizedBoxHeightMicro,
                      Text('${widget.totalCreditBalance} ${getIt<MainScreenBloc>().branchGeneralInfo?.currency}',
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      BlocBuilder<CustomerPaymentCubit, CustomerPaymentState>(
                        builder: (context, state) => (state is GetPaymentTypeStates && state.isLoading)
                            ? const LoadingWidget()
                            : SizedBox(
                          height: 250,
                              child: ListView(
                                  shrinkWrap: true,
                                  children: context
                                      .read<CustomerPaymentCubit>()
                                      .paymentTypes
                                      .map(
                                        (e) => CheckboxListTile(
                                          value: _selectPayModeIDs.contains(e.id),
                                          contentPadding: const EdgeInsets.all(0),
                                          onChanged: (value) {
                                            if (!value!) {
                                              _selectPayModeIDs.remove(e.id);
                                            } else {
                                              _selectPayModeIDs.addIf(!_selectPayModeIDs.contains(e.id), e.id);
                                            }
                                            setState(() {});
                                          },
                                          title: Text(e.name, style: context.textTheme.bodyMedium),
                                          subtitle: Visibility(
                                            visible: _selectPayModeIDs.contains(e.id),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                RoundedTextInputWidget(
                                                  hintText: '20.000',
                                                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                                  onChange: (text) {
                                                    if (text.isNotEmpty) {
                                                      e.amount = num.parse(text);
                                                    } else {
                                                      e.amount = 0;
                                                    }

                                                    setState(() {});
                                                  },
                                                ),
                                                context.sizedBoxHeightMicro,
                                                Visibility(
                                                  visible: e.canHaveReference,
                                                  child: RoundedTextInputWidget(
                                                    hintText: S.current.enterVisaTransactionNumber,
                                                    onChange: (text) {
                                                      if (text.isNotEmpty) e.reference = text;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList()),
                            ),
                      ),
                      context.sizedBoxHeightMicro,
                      Row(
                        children: [
                          Text(S.current.remainingBalance, style: context.textTheme.bodyMedium),
                          Expanded(
                            child: Text(
                              _getRemainingBalance(),
                              textAlign: TextAlign.right,
                              style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      BlocConsumer<CustomerPaymentCubit, CustomerPaymentState>(
                        listener: (context, state) {
                          if (state is CreateCustomerPaymentState && state.errorMessage != null) {
                            context.showCustomeAlert(state.errorMessage);
                          } else if (state is CreateCustomerPaymentState && state.isSuccess) {
                            Get.back();
                            context.showCustomeAlert(S.current.paymentCreatedSuccessfully);
                          }
                        },
                        builder: (context, state) => RoundedBtnWidget(
                          onTap: () {
                            context.read<CustomerPaymentCubit>().createCustomerPayment(customerId: widget.customerId);
                          },
                          btnText: S.current.savePayment,
                          btnPadding: const EdgeInsets.symmetric(vertical: 10),
                          btnMargin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
