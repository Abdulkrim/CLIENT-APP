import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/expense/presentation/blocs/expense_cubit.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/assets.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/rounded_dropdown_list.dart';
import '../../../../settings/data/models/entity/payment_type.dart';
import '../../../data/models/entity/expense_type.dart';

class MobileExpenseFiltersWidget extends StatelessWidget {
  const MobileExpenseFiltersWidget({super.key});

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
                  context.read<ExpenseCubit>().resetFilter();
                },
                child: Text(
                 S.current.reset,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: context.colorScheme.primaryColor),
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
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                        )))
                    .toList()),
          ),
          context.sizedBoxWidthExtraSmall,
          Flexible(
            child: RoundedDropDownList(
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
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                        )))
                    .toList()),
          ),
          context.sizedBoxHeightExtraSmall,
        ],
      ),
    );
  }
}
