import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/cashier_filter.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/category_filter.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/product_filter.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/blocs/transaction_bloc.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_dropdown_list.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

import '../../../../../widgets/app_ink_well_widget.dart';

class MobileTransactionFilterWidget extends StatefulWidget {
  const MobileTransactionFilterWidget({Key? key}) : super(key: key);

  @override
  State<MobileTransactionFilterWidget> createState() => _MobileTransactionFilterWidgetState();
}

class _MobileTransactionFilterWidgetState extends State<MobileTransactionFilterWidget> {
  String startTime = '';

  String endTime = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          context.sizedBoxHeightMicro,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  S.current.filter,
                  style: context.textTheme.titleMedium,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<TransactionBloc>().add(const ResetAllFiltersEvent());
                },
                child: Text(
                  S.current.reset,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: context.colorScheme.primaryColor),
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  Assets.iconsCancelIcon,
                  width: 20,
                ),
                onPressed: () => Get.back(),
              )
            ],
          ),
          context.sizedBoxHeightSmall,
          Flexible(
            child: RoundedDropDownList(
                selectedValue: context.select<TransactionBloc, CategoryFilter>((value) => value.selectedCategoryFilterItem),
                onChange: (category) {
                  context.read<TransactionBloc>().add(ChangeCategoryFilterItemEvent(category));
                },
                isExpanded: true,
                items: context
                    .watch<TransactionBloc>()
                    .categories
                    .map<DropdownMenuItem<CategoryFilter>>(
                      (CategoryFilter value) => DropdownMenuItem<CategoryFilter>(
                        value: value,
                        child: SizedBox(
                          width: Get.width * 0.8,
                          child: Text(
                            value.name,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                    )
                    .toList()),
          ),
          context.sizedBoxHeightExtraSmall,
          Flexible(
            child:              Container(
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
          ),
          context.sizedBoxHeightExtraSmall,
          Flexible(
            child: RoundedDropDownList(
                selectedValue: context.select<TransactionBloc, SubCategoryFilter>((value) => value.selectedSubCategoryCategoryFilterItem),
                onChange: (subCategory) {
                  context.read<TransactionBloc>().add(ChangeSubCategoryFilterItemEvent(subCategory));
                },
                isExpanded: true,
                items: context
                    .watch<TransactionBloc>()
                    .subCategories
                    .map<DropdownMenuItem<SubCategoryFilter>>(
                      (SubCategoryFilter value) => DropdownMenuItem<SubCategoryFilter>(
                        value: value,
                        child: SizedBox(
                          width: Get.width * 0.8,
                          child: Text(
                            value.name,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                    )
                    .toList()),
          ),
          context.sizedBoxHeightExtraSmall,
          Flexible(
            child: RoundedDropDownList(
                selectedValue: context.watch<TransactionBloc>().selectedProductFilterItem,
                onChange: (product) {
                  context.read<TransactionBloc>().add(ChangeProductFilterItemEvent(product));
                },
                isExpanded: true,
                items: context
                    .select<TransactionBloc, List<ProductFilter>>((TransactionBloc bloc) => bloc.products)
                    .map<DropdownMenuItem<ProductFilter>>(
                      (ProductFilter value) => DropdownMenuItem<ProductFilter>(
                        value: value,
                        child: SizedBox(
                          width: Get.width * 0.8,
                          child: Text(
                            value.name,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                    )
                    .toList()),
          ),
          context.sizedBoxHeightExtraSmall,
          Flexible(
            child: RoundedDropDownList(
              selectedValue: context.watch<TransactionBloc>().selectedCashierFilterItem,
              onChange: (cashier) {
                context.read<TransactionBloc>().add(ChangeCashierFilterItemEvent(cashier));
              },
              isExpanded: true,
              items: context
                  .watch<TransactionBloc>()
                  .cashiers
                  .map<DropdownMenuItem<CashierFilter>>((CashierFilter value) => DropdownMenuItem<CashierFilter>(
                        value: value,
                        child: SizedBox(
                          width: Get.width * 0.8,
                          child: Text(
                            value.name,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          context.sizedBoxHeightSmall,
        ],
      ),
    );
  }
}
