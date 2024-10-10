import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/stock/presentation/blocs/stock_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../theme/theme_data.dart';
import '../../../../utils/responsive_widgets/responsive_dialog_widget.dart';
import '../../../../utils/snack_alert/snack_alert.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/rounded_btn.dart';
import '../../../../widgets/rounded_dropdown_list.dart';
import '../../../../widgets/rounded_text_input.dart';
import '../../../products/data/models/entity/measure_unit.dart';
import '../../data/models/entity/stocks.dart';

class IncreaseStockDialog extends StatefulWidget {
  const IncreaseStockDialog({super.key, required this.stock, this.height, this.width});
  final StockInfo stock;

  final double? width;
  final double? height;
  @override
  State<IncreaseStockDialog> createState() => _IncreaseStockDialogState();
}

class _IncreaseStockDialogState extends State<IncreaseStockDialog> {
  final _quantityController = TextEditingController();

  final _buyingPriceController = TextEditingController();
  late MeasureUnit? _selectedUnitOfMeasure = widget.stock.itemStock?.measureUnit;
  int _calcTotalQuantity = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _quantityController.addListener(() {
      setState(() {
        _calcTotalQuantity =
            int.parse(_quantityController.text.isEmpty ? '0' : _quantityController.text.toString()) +
                widget.stock.quantity.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
        height: widget.height,
        width: widget.width,
        title: S.current.increaseStockQuantity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: widget.stock.itemStock?.measureUnit == null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(S.current.measureUnit,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      RoundedDropDownList(
                          selectedValue: () {
                            _selectedUnitOfMeasure ??=
                                context.select((StockBloc bloc) => bloc.measureUnits).first;
                            return _selectedUnitOfMeasure;
                          }.call(),
                          onChange: (offer) => setState(() => _selectedUnitOfMeasure = offer),
                          margin: const EdgeInsets.only(right: 8),
                          isExpanded: true,
                          items: context
                              .select((StockBloc bloc) => bloc.measureUnits)
                              .map<DropdownMenuItem<MeasureUnit>>(
                                (MeasureUnit value) => DropdownMenuItem<MeasureUnit>(
                                  value: value,
                                  child: Text(
                                    '${value.name} - ${value.symbol}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: AppColors.black),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              )
                              .toList()),
                      context.sizedBoxHeightExtraSmall,
                    ],
                  ),
                ),
                Text(S.current.quantity, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                RoundedTextInputWidget(
                  hintText: S.current.enterQuantity,
                  textEditController: _quantityController,
                  keyboardType: TextInputType.number,
                  isRequired: true,
                ),
                context.sizedBoxHeightExtraSmall,
                Text(S.current.buyingPrice,
                    style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                context.sizedBoxHeightMicro,
                RoundedTextInputWidget(
                  hintText: S.current.enterBuyingPrice,
                  textEditController: _buyingPriceController,
                  isRequired: true,
                ),
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
                context.sizedBoxHeightExtraSmall,
                BlocConsumer<StockBloc, StockState>(
                  listener: (context, state) {
                    if (state is IncreaseStockState && state.isSuccess) {
                      Get.back();
                      context.showCustomeAlert(
                          '', SnackBarType.success);
                    } else if (state is IncreaseStockState && state.error != null) {
                      context.showCustomeAlert(state.error!, SnackBarType.error);
                    }
                  },
                  builder: (context, state) => (state is IncreaseStockState && state.isLoading)
                      ? const LoadingWidget()
                      : RoundedBtnWidget(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<StockBloc>().add(IncreaseStockEvent(
                                  itemId: widget.stock.id,
                                  amount: num.parse(_quantityController.text.trim()),
                                  pricePerUnit: num.parse(_buyingPriceController.text.trim()),
                                  unitMeasureId: _selectedUnitOfMeasure!.id));
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
