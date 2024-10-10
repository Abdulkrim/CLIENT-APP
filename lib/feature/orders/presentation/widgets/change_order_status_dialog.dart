import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';

import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/widgets/item_hint_textfield_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import '../../../cashiers/data/models/entity/cashier.dart';
import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../settings/data/models/entity/payment_type.dart';
import 'selectable_list_tile .dart';

class ChangeOrderStatusDialog extends StatefulWidget {
  const ChangeOrderStatusDialog(
      {super.key,
      required this.paymentModes,
      required this.onPaymentTypeTap,
      required this.cashiers,
      this.deliveryFee,
      required this.maxDiscount,
      required this.showDelieryDiscount,
      this.userPayTypeDefinedId});

  final int? userPayTypeDefinedId;
  final List<Cashier> cashiers;
  final List<PaymentType> paymentModes;
  final num? deliveryFee;
  final num maxDiscount;
  final bool showDelieryDiscount;
  final Function(int? paymentType, String? cashierId, String referenceID, num deliveryDiscount) onPaymentTypeTap;

  @override
  State<ChangeOrderStatusDialog> createState() => _ChangeOrderStatusDialogState();
}

class _ChangeOrderStatusDialogState extends State<ChangeOrderStatusDialog> {
  String? _selectedCashierId;
  late PaymentType? _selectedPaymentMode =
      widget.paymentModes.firstWhereOrNull((element) => element.id == widget.userPayTypeDefinedId);

  var referenceIDController = TextEditingController();

  final _discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
      title: S.current.selectPaymentMode,
      height: 600,
      width: 400,
      child: ScrollableWidget(
        scrollViewPadding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              S.current.selectCashier,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            context.sizedBoxHeightExtraSmall,
           ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: widget.cashiers.map((cashier) {
                final isSelected = cashier.id == _selectedCashierId;
                return SelectableListTile(
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedCashierId = isSelected ? null : cashier.id;
                    });
                  },
                  title: cashier.name,
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 92, 148, 66),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            context.sizedBoxHeightSmall,
            Text(
              S.current.selectPaymentForThisOrder,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            context.sizedBoxHeightExtraSmall,
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: widget.paymentModes
                  .map((e) => SwitchListTile(
                        value: e.id == _selectedPaymentMode?.id,
                        onChanged: (value) => setState(() => _selectedPaymentMode = value ? e : null),
                        title: Text(e.name, style: context.textTheme.bodyMedium),
                      ))
                  .toList(),
            ),
            context.sizedBoxHeightSmall,
            Visibility(
              visible: _selectedPaymentMode != null && _selectedPaymentMode!.canHaveReference,
              child: ItemHintTextFieldWidget(
                textEditingController: referenceIDController,
                hintText: S.current.referenceID,
              ),
            ),
            context.sizedBoxWidthExtraSmall,
            if (widget.showDelieryDiscount) ...[
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: 'Delivery Fee: ', style: context.textTheme.bodyMedium),
                TextSpan(
                    text: '${widget.deliveryFee} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                    style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
              ])),
              Row(
                children: [
                  const Expanded(child: Text('Delivery Discount: ')),
                  RoundedTextInputWidget(
                    hintText: '0.0',
                    width: 180,
                    margin: const EdgeInsets.only(right: 20),
                    textEditController: _discountController,
                    keyboardType: TextInputType.number,
                    validator: (p0) => num.parse((p0 ?? '').isEmpty ? '0' : p0!) > widget.maxDiscount
                        ? 'Must be less than ${widget.maxDiscount}'
                        : null,
                  )
                ],
              )
            ],
            context.sizedBoxHeightSmall,
            RoundedBtnWidget(
                onTap: () {
                  if (_selectedCashierId == null || _selectedPaymentMode == null) {
                    context.showCustomeAlert(S.current.plzEnterAllField);
                    return;
                  }

                  final delivDiscount =
                      num.tryParse(_discountController.text.trim().isEmpty ? '0' : _discountController.text.trim()) ?? 0;
                  if (delivDiscount > widget.maxDiscount) {
                    return;
                  }
                  widget.onPaymentTypeTap(
                    _selectedPaymentMode?.id,
                    _selectedCashierId,
                    referenceIDController.text,
                    delivDiscount,
                  );
                },
                btnPadding: const EdgeInsets.symmetric(vertical: 8),
                btnMargin: const EdgeInsets.symmetric(horizontal: 16),
                btnText: S.current.changeStatus)
          ],
        ),
      ),
    );
  }
}
