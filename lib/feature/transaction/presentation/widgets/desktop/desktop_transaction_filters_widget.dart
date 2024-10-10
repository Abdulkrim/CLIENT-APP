import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/cashier_filter.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/category_filter.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/product_filter.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/blocs/transaction_bloc.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/date_picker_widget/date_range_picker_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_dropdown_list.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

class DesktopTransactionFiltersWidget extends StatefulWidget {
  const DesktopTransactionFiltersWidget({Key? key}) : super(key: key);

  @override
  State<DesktopTransactionFiltersWidget> createState() => _DesktopTransactionFiltersWidgetState();
}

class _DesktopTransactionFiltersWidgetState extends State<DesktopTransactionFiltersWidget> {
  bool _filterExpanded = true;

  String startTime = '';
  String endTime = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoundedBtnWidget(
          onTap: () {
            setState(() {
              _filterExpanded = !_filterExpanded;
            });
          },
          btnText: S.current.filter,
          width: 100,
          height: 35,
          btnIcon: SvgPicture.asset(
            Assets.iconsFilter,
            color: AppColors.white,
            height: 15,
          ),
        ),
        Visibility(
          visible: _filterExpanded,
          child: Wrap(
            children: [
              RoundedDropDownList(
                  maxWidth: 200,
                  isExpanded: true,
                  selectedValue: context
                      .select<TransactionBloc, CategoryFilter>((value) => value.selectedCategoryFilterItem),
                  onChange: (category) {
                    context.read<TransactionBloc>().add(ChangeCategoryFilterItemEvent(category));
                  },
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  items: context
                      .watch<TransactionBloc>()
                      .categories
                      .map<DropdownMenuItem<CategoryFilter>>(
                        (CategoryFilter value) => DropdownMenuItem<CategoryFilter>(
                          value: value,
                          child: Text(
                            value.name,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      )
                      .toList()),
              RoundedDropDownList(
                  maxWidth: 200,
                  isExpanded: true,
                  selectedValue: context.select<TransactionBloc, SubCategoryFilter>(
                      (value) => value.selectedSubCategoryCategoryFilterItem),
                  onChange: (subCategory) {
                    context.read<TransactionBloc>().add(ChangeSubCategoryFilterItemEvent(subCategory));
                  },
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  items: context
                      .watch<TransactionBloc>()
                      .subCategories
                      .map<DropdownMenuItem<SubCategoryFilter>>(
                        (SubCategoryFilter value) => DropdownMenuItem<SubCategoryFilter>(
                          value: value,
                          child: Text(
                            value.name,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      )
                      .toList()),
              RoundedDropDownList(
                  maxWidth: 200,
                  isExpanded: true,
                  selectedValue: context
                      .select<TransactionBloc, ProductFilter>((value) => value.selectedProductFilterItem),
                  onChange: (product) {
                    context.read<TransactionBloc>().add(ChangeProductFilterItemEvent(product));
                  },
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  items: context
                      .select<TransactionBloc, List<ProductFilter>>((TransactionBloc bloc) => bloc.products)
                      .map<DropdownMenuItem<ProductFilter>>(
                          (ProductFilter value) => DropdownMenuItem<ProductFilter>(
                                value: value,
                                child: Text(
                                  value.name,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(color: AppColors.black),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                      .toList()),
              RoundedDropDownList(
                  maxWidth: 200,
                  isExpanded: true,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  selectedValue: context
                      .select<TransactionBloc, CashierFilter>((value) => value.selectedCashierFilterItem),
                  onChange: (cashier) {
                    context.read<TransactionBloc>().add(ChangeCashierFilterItemEvent(cashier));
                  },
                  items: context
                      .watch<TransactionBloc>()
                      .cashiers
                      .map<DropdownMenuItem<CashierFilter>>(
                          (CashierFilter value) => DropdownMenuItem<CashierFilter>(
                                value: value,
                                child: Text(
                                  value.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(color: AppColors.black),
                                  textAlign: TextAlign.start,
                                ),
                              ))
                      .toList()),
              context.sizedBoxWidthMicro,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: DateRangePickerWidget(
                  height: _filterExpanded ? 50 : 0,
                  width: 300,
                  initialFromDate: context.select<TransactionBloc, String>((value) => value.fromDate),
                  initialToDate: context.select<TransactionBloc, String>((value) => value.toDate),
                  onDateRangeChanged: (String fromDate, String toDate) {
                    context
                        .read<TransactionBloc>()
                        .add(GetAllTransactionsEvent(fromDate: fromDate, toDate: toDate));
                  },
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 230,
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.lightGray,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppInkWell(
                            child: Text(startTime.isEmpty
                                ? 'Specify the Time Range Filter'
                                : '$startTime | $endTime'),
                            onTap: () => TimeRangePicker.show(
                              context: context,
                              onSubmitted: (TimeRangeValue value) {
                                startTime =
                                    '${value.startTime?.hour}:${value.startTime?.minute} ${value.startTime?.period.name}';
                                endTime =
                                    '${value.endTime?.hour}:${value.endTime?.minute} ${value.endTime?.period.name}';

                                setState(() {});

                                context.read<TransactionBloc>().add(GetAllTransactionsEvent(
                                    startTime: '${value.startTime?.hour}:${value.startTime?.minute}',
                                    endTime: '${value.endTime?.hour}:${value.endTime?.minute}'));
                              },
                            ),
                          ),
                        ),
                        Visibility(
                            visible: startTime.isNotEmpty,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    startTime = '';
                                    endTime = '';
                                    context
                                        .read<TransactionBloc>()
                                        .add(GetAllTransactionsEvent(startTime: null, endTime: null));
                                  });
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.black,
                                )))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
