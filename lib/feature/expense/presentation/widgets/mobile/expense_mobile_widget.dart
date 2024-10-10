import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/expense/presentation/widgets/mobile/mobile_expense_filters_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/assets.dart';
import '../../../../../widgets/date_picker_widget/date_range_picker_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/shimmer.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../../data/models/entity/expenses_info.dart';
import '../../blocs/expense_cubit.dart';
import '../desktop/desktop_add_expense_widget.dart';
import '../expense_search_box_widget.dart';
import 'mobile_expense_list_widget.dart';

class ExpensesMobileWidget extends StatefulWidget {
  const ExpensesMobileWidget({super.key});

  @override
  State<ExpensesMobileWidget> createState() => _ExpensesMobileState();
}

class _ExpensesMobileState extends State<ExpensesMobileWidget> {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.watch<MenuDrawerCubit>().selectedPageContent.text,
              style: context.textTheme.titleLarge,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        isDismissible: false,
                        BlocProvider.value(
                          value: BlocProvider.of<ExpenseCubit>(context),
                          child: const MobileExpenseFiltersWidget(),
                        ));
                  },
                  icon: SvgPicture.asset(
                    Assets.iconsFilter,
                    height: 25,
                  ),
                ),
                DateRangePickerWidget(
                  initialFromDate: context.select<ExpenseCubit, String>((value) => value.fromDate),
                  initialToDate: context.select<ExpenseCubit, String>((value) => value.toDate),
                  onDateRangeChanged: (String fromDate, String toDate) =>
                      context.read<ExpenseCubit>().getExpenses(requestedFromDate: fromDate, requestedToDate: toDate),
                )
              ],
            ),
          ],
        ),
        context.sizedBoxHeightSmall,
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: BlocProvider.value(
                value: BlocProvider.of<ExpenseCubit>(context),
                child: ExpenseSearchBoxWidget(
                  expenseAmounts: context.select((ExpenseCubit bloc) => bloc.expensesAmount),
                ),
              )),
              RoundedBtnWidget(
                onTap: () {
                  Get.dialog(BlocProvider.value(
                    value: BlocProvider.of<ExpenseCubit>(context),
                    child: const DesktopAddExpenseWidget(),
                  ));
                },
                height: 35,
                btnMargin: const EdgeInsets.symmetric(horizontal: 10),
                btnIcon: const Icon(Icons.add_circle_outline_rounded, color: Colors.white),
                btnText: S.current.addExpense,
              ),
            ],
          ),
        ),
        context.sizedBoxHeightExtraSmall,
        Expanded(
          child: BlocBuilder<ExpenseCubit, ExpenseState>(
            builder: (context, state) {
              if (state is GetExpensesState && state.isLoading) {
                return ShimmerWidget(width: Get.width, height: Get.height);
              }
              // if (state is WrongDateFilterRangeEnteredState) return const SizedBox();

              return MobileExpenseListWidget(
                  hasMore: context.select<ExpenseCubit, bool>((value) => value.expensesPagination.hasMore),
                  getExpenses: (getMore) => context.read<ExpenseCubit>().getExpenses(getMore: getMore),
                  expenses: context.select<ExpenseCubit, List<ExpenseItem>>((value) => value.expensesPagination.listItems));
            },
          ),
        ),
      ],
    );
  }
}
