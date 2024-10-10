import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/expense/presentation/widgets/desktop/desktop_add_expense_widget.dart';
import 'package:merchant_dashboard/feature/expense/presentation/widgets/expense_search_box_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/assets.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/date_picker_widget/date_range_picker_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/rounded_dropdown_list.dart';
import '../../../../settings/data/models/entity/payment_type.dart';
import '../../../data/models/entity/expense_type.dart';
import '../../blocs/expense_cubit.dart';

class DesktopExpenseFiltersWidget extends StatefulWidget {
  const DesktopExpenseFiltersWidget({super.key});

  @override
  State<DesktopExpenseFiltersWidget> createState() => _DesktopExpenseFiltersWidgetStatet();
}

class _DesktopExpenseFiltersWidgetStatet extends State<DesktopExpenseFiltersWidget> {
  bool _filterExpanded = true;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: RoundedBtnWidget(
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
              ),
            ),
            SizedBox(
                width: 300,
                child: BlocProvider.value(
                  value: BlocProvider.of<ExpenseCubit>(context),
                  child: ExpenseSearchBoxWidget(
                    expenseAmounts: context.select((ExpenseCubit bloc) => bloc.expensesAmount),
                  ),
                )),
            context.sizedBoxWidthExtraSmall,
            RoundedBtnWidget(
              onTap: () {
                Get.dialog(BlocProvider.value(
                  value: BlocProvider.of<ExpenseCubit>(context),
                  child: const DesktopAddExpenseWidget(),
                ));
              },
              height: 35,
              btnIcon: SvgPicture.asset(
                Assets.iconsAddIcon,
                width: 20,
                color: Colors.white,
              ),
              btnText: S.current.addExpense,
            ),
          ],
        ),
        Visibility(
            visible: _filterExpanded,
            child: Wrap(
              children: [
                RoundedDropDownList(
                    maxWidth: 200,
                    isExpanded: true,
                    selectedValue:
                        context.select<ExpenseCubit, ExpenseType>((bloc) => bloc.selectedExpenseTypeFilter),
                    onChange: (item) => context.read<ExpenseCubit>().changeExpenseType(item),
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    items: context
                        .select<ExpenseCubit, List<ExpenseType>>((bloc) => bloc.expenseTypes)
                        .map((e) => DropdownMenuItem<ExpenseType>(
                            value: e,
                            child: Text(
                              e.name,
                              style:
                                  Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                            )))
                        .toList()),
                RoundedDropDownList(
                    maxWidth: 200,
                    isExpanded: true,
                    selectedValue:
                        context.select<ExpenseCubit, PaymentType>((bloc) => bloc.selectedPaymentTypeFilter),
                    onChange: (item) => context.read<ExpenseCubit>().changePaymentType(item),
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    items: context
                        .select<ExpenseCubit, List<PaymentType>>((bloc) => bloc.paymentModes)
                        .map((e) => DropdownMenuItem<PaymentType>(
                            value: e,
                            child: Text(
                              e.name,
                              style:
                                  Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                            )))
                        .toList()),
                context.sizedBoxWidthMicro,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: DateRangePickerWidget(
                    height: _filterExpanded ? 50 : 0,
                    width: 450,
                    initialFromDate: context.select<ExpenseCubit, String>((value) => value.fromDate),
                    initialToDate: context.select<ExpenseCubit, String>((value) => value.toDate),
                    onDateRangeChanged: (String fromDate, String toDate) => context
                        .read<ExpenseCubit>()
                        .getExpenses(requestedFromDate: fromDate, requestedToDate: toDate),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
