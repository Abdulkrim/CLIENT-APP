import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/shimmer.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/entity/expenses_info.dart';
import '../blocs/expense_cubit.dart';

class ExpenseListBoxWidget extends StatefulWidget {
  const ExpenseListBoxWidget({super.key});

  @override
  State<ExpenseListBoxWidget> createState() => _ExpenseListBoxWidgetState();
}

class _ExpenseListBoxWidgetState extends State<ExpenseListBoxWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        context.read<ExpenseCubit>().getExpenses(getMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenses = context.select<ExpenseCubit, List<ExpenseItem>>((value) => value.expensesPagination.listItems);

    final hasMore = context.select<ExpenseCubit, bool>((value) => value.expensesPagination.hasMore);

    return Visibility(
      visible: expenses.isNotEmpty,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: 450,
          height: 400,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(80, 158, 158, 158),
              ),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      S.current.expense,
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(text: '${S.current.total}: ', style: context.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '${context.select((ExpenseCubit bloc) => bloc.expenseTotalAmount)} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                        style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ]))
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Expanded(
                  child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: BlocBuilder<ExpenseCubit, ExpenseState>(
                  builder: (context, state) {
                    if (state is GetExpensesState && state.isLoading) {
                      return ShimmerWidget(width: Get.width, height: Get.height);
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: (hasMore && expenses.isNotEmpty) ? expenses.length + 1 : expenses.length,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemBuilder: (context, index) => (index < expenses.length)
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    expenses[index].expenseTypeName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.textTheme.bodyMedium,
                                  )),
                                  Text(
                                    '${expenses[index].amount} ${getIt<MainScreenBloc>().branchGeneralInfo?.currency}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            )
                          : const CupertinoActivityIndicator(),
                    );
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
