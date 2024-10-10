import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/expense/data/models/entity/expenses_info.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../utils/mixins/mixins.dart';
import '../../blocs/expense_cubit.dart';
import 'desktop_add_expense_widget.dart';

class DesktopExpenseTableWidget extends StatelessWidget with DownloadUtils {
  const DesktopExpenseTableWidget({super.key, required this.expenses});

  final List<ExpenseItem> expenses;

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        1: FlexColumnWidth(.5),
      },
      children: [
        context.headerTableRow([
          S.current.typeOfExpense,
          S.current.paymentMode,
          S.current.expenseAmount,
          S.current.expenseDate,
          S.current.notes,
          "",
        ]),
        ...expenses
            .map((e) => TableRow(children: [
                  TableCell(
                    child: Text(e.expenseTypeName, textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text(e.paymentModeName, textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text(e.amount.toString(), textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text(e.formattedDate, textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text(e.note, textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Row(
                      children: [
                        Visibility(
                          visible: e.fileUrl.isNotEmpty,
                          child: IconButton(
                              onPressed: () async {
                                openLink(url: e.fileUrl);
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
                                  expenseItem: e,
                                ),
                              ));
                            },
                            icon: SvgPicture.asset(Assets.iconsIcEdit, width: 20)),

                      ],
                    ),
                  ),
                ]))
            .toList()
      ],
    );
  }
}
