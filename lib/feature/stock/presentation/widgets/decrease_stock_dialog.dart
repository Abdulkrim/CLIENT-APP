import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/decrease_reason.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_dropdown_list.dart';

import '../../../../theme/theme_data.dart';
import '../../../../utils/responsive_widgets/responsive_dialog_widget.dart';
import '../../../../utils/snack_alert/snack_alert.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/rounded_btn.dart';
import '../../../../widgets/rounded_text_input.dart';
import '../blocs/stock_bloc.dart';

class DecreaseStockDialog extends StatefulWidget {
  const DecreaseStockDialog(
      {super.key, required this.stockId, required this.currentStockQuantity, this.height, this.width});
  final int stockId;
  final num currentStockQuantity;

  final double? width;
  final double? height;

  @override
  State<DecreaseStockDialog> createState() => _DecreaseStockDialogState();
}

class _DecreaseStockDialogState extends State<DecreaseStockDialog> {
  final _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DecreaseReasons? _selectedDecreaseReason;
  int _calcTotalQuantity = 0;

  @override
  void initState() {
    super.initState();
    _quantityController.addListener(() {
      setState(() {
        _calcTotalQuantity = widget.currentStockQuantity.toInt() -
            int.parse(_quantityController.text.isEmpty ? '0' : _quantityController.text.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
        width: widget.width,
        height: widget.height,
        title: S.current.decreaseStockQuantity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(S.current.quantity, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                context.sizedBoxHeightMicro,
                RoundedTextInputWidget(
                  hintText:S.current.enterQuantity,
                  textEditController: _quantityController,
                  isRequired: true,
                ),
                context.sizedBoxHeightExtraSmall,
                Text(S.current.reason, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                context.sizedBoxHeightMicro,
                RoundedDropDownList(
                    margin: EdgeInsets.zero,
                    selectedValue: _selectedDecreaseReason ??=
                        context.select((StockBloc bloc) => bloc.decreaseReasons).first,
                    isExpanded: true,
                    onChange: (p0) {
                      _selectedDecreaseReason = p0;
                    },
                    items: context
                        .select((StockBloc bloc) => bloc.decreaseReasons)
                        .map((e) => DropdownMenuItem<DecreaseReasons>(
                            value: e,
                            child: Text(
                              e.reasonText,
                              style:
                                  Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                            )))
                        .toList()),
                context.sizedBoxHeightExtraSmall,
                Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: AppColors.lightGray, borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      child: Column(children: [
                        Text(
                          S.current.totalQuantity,
                          style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        context.sizedBoxHeightMicro,
                        Text(
                          _calcTotalQuantity.toString(),
                          style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold, color: context.colorScheme.primaryColor),
                        ),
                      ]),
                    ),
                  ),
                ),
                context.sizedBoxHeightDefault,
                BlocConsumer<StockBloc, StockState>(
                  listener: (context, state) {
                    if (state is DecreaseStockState && state.isSuccess) {
                      Get.back();
                      context.showCustomeAlert(
                          S.current.decreasedSuccessfully, SnackBarType.success);
                    } else if (state is DecreaseStockState && state.error != null) {
                      context.showCustomeAlert(state.error!, SnackBarType.error);
                    }
                  },
                  builder: (context, state) => (state is DecreaseStockState && state.isLoading)
                      ? const LoadingWidget()
                      : RoundedBtnWidget(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<StockBloc>().add(DecreaseStockEvent(
                                  itemId: widget.stockId,
                                  amount: num.parse(_quantityController.text.trim()),
                                  reasonId: _selectedDecreaseReason!.reasonId));
                            }
                          },
                          height: 35,
                          btnText: S.current.save,
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
