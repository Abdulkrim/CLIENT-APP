import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/expense/data/models/entity/expenses_info.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';

import '../../../../../theme/theme_data.dart';
import '../../blocs/expense_cubit.dart';
import '../desktop/desktop_add_expense_widget.dart';

class MobileExpenseListWidget extends StatefulWidget {
  const MobileExpenseListWidget({
    super.key,
    required this.expenses,
    required this.hasMore,
    required this.getExpenses,
  });

  final Function(bool getMore) getExpenses;
  final List<ExpenseItem> expenses;
  final bool hasMore;

  @override
  State<MobileExpenseListWidget> createState() => _MobileExpenseListState();
}

class _MobileExpenseListState extends State<MobileExpenseListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        widget.getExpenses(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.getExpenses(false);
        return Future<void>.delayed(const Duration(seconds: 2));
      },
      child: ListView.builder(
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        primary: false,
        itemCount: (widget.hasMore && widget.expenses.isNotEmpty)
            ? widget.expenses.length + 1
            : widget.expenses.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => (index < widget.expenses.length)
            ? _MobileExpenseItemWidget(
                expense: widget.expenses[index],
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

class _MobileExpenseItemWidget extends StatelessWidget with DownloadUtils {
  final ExpenseItem expense;

  const _MobileExpenseItemWidget({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.lightGray,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${S.current.typeOfExpense} - ${expense.expenseTypeName}",
                  style: context.textTheme.bodyMedium,
                ),
              ),
              Visibility(
                visible: expense.fileUrl.isNotEmpty,
                child: IconButton(
                    onPressed: () async {
                      openLink(url: expense.fileUrl);
                    },
                    icon: SvgPicture.asset(
                      Assets.iconsIcDownload,
                      width: 20,
                    )),
              ),
              IconButton(
                  onPressed: () {
                    Get.dialog(BlocProvider.value(
                      value: BlocProvider.of<ExpenseCubit>(context),
                      child: DesktopAddExpenseWidget(
                        expenseItem: expense,
                      ),
                    ));
                  },
                  icon: SvgPicture.asset(
                    Assets.iconsIcEdit,
                    width: 20,
                  )),
            ],
          ),
          context.sizedBoxHeightExtraSmall,
          Text(
            "${S.current.paymentMode} - ${expense.paymentModeName}",
            style: context.textTheme.bodyMedium,
          ),
          context.sizedBoxHeightExtraSmall,
          Text(
            "${S.current.expenseAmount} - ${expense.amount.toString()}",
            style: context.textTheme.bodyMedium,
          ),
          context.sizedBoxHeightExtraSmall,
          Text(
            "${S.current.notes} - ${expense.note}",
            style: context.textTheme.bodyMedium,
          ),
          Text(
            expense.formattedDate,
            textAlign: TextAlign.right,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
