import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/expense/data/models/entity/expenses_info.dart';
import 'package:merchant_dashboard/feature/expense/presentation/blocs/expense_cubit.dart';
import 'package:merchant_dashboard/feature/expense/presentation/widgets/desktop/desktop_expense_table_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/scrollable_widget.dart';
import '../../../../../widgets/shimmer.dart';
import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import 'desktop_expense_filters_widget.dart';

class ExpensesDesktopWidget extends StatefulWidget {
  const ExpensesDesktopWidget({super.key});

  @override
  State<ExpensesDesktopWidget> createState() => _ExpensesDesktopWidgetState();
}

class _ExpensesDesktopWidgetState extends State<ExpensesDesktopWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<ExpenseCubit>().resetFilter();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        context.read<ExpenseCubit>().getExpenses(getMore: true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.watch<MenuDrawerCubit>().selectedPageContent.text,
              style: context.textTheme.titleLarge,
            ),
            context.sizedBoxWidthMicro,
            IconButton(
                onPressed: () => context.read<ExpenseCubit>().resetFilter(),
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: Colors.black,
                )),
          ],
        ),
        context.sizedBoxHeightSmall,
        const DesktopExpenseFiltersWidget(),
        Visibility(
          visible: context.select<ExpenseCubit, num>((value) => value.expenseTotalAmount) > 0,
          child: RichText(
              text: TextSpan(children: [
            TextSpan(text: '${S.current.total}: ', style: context.textTheme.bodyMedium),
            TextSpan(
                text: '${context.select<ExpenseCubit, num>(
                      (value) => value.expenseTotalAmount,
                    ).toString()} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ])),
        ),
        context.sizedBoxHeightSmall,
        Expanded(
          child: BlocBuilder<ExpenseCubit, ExpenseState>(
            builder: (context, state) {
              if (state is GetExpensesState && state.isLoading) {
                return ShimmerWidget(width: Get.width, height: Get.height);
              }
              // if (state is WrongDateFilterRangeEnteredState) return const SizedBox();

              return ScrollableWidget(
                scrollController: _scrollController,
                child: Column(
                  children: [
                    DesktopExpenseTableWidget(
                        expenses: context.select<ExpenseCubit, List<ExpenseItem>>(
                      (value) => value.expensesPagination.listItems,
                    )),
                    Visibility(
                        visible: context.select<ExpenseCubit, bool>((value) => value.expensesPagination.hasMore) &&
                            (state is GetExpensesState && state.errorMessage.isNotEmpty),
                        child: const CupertinoActivityIndicator()),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
