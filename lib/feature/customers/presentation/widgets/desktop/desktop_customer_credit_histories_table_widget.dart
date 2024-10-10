import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../injection.dart';
import '../../../../transaction/presentation/blocs/transaction_bloc.dart';
import '../../../data/models/entity/customer_credit_history.dart';
import '../transaction_details_dialog.dart';

class DesktopCustomerCreditHistoriesTableWidget extends StatelessWidget {
  const DesktopCustomerCreditHistoriesTableWidget({super.key, required this.creditHistories});

  final List<CustomerCreditHistory> creditHistories;

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {6: FractionColumnWidth(.2)},
      children: [
        context.headerTableRow([
          S.current.date,
          S.current.type,
          S.current.amount,
          S.current.balance,
          '',
        ]),
        ...creditHistories
            .map((e) => TableRow(children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        e.dateTime,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.type,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.amount.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.balance.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                      child: Visibility(
                    visible: e.isTransactionType,
                    child: Center(
                      child: RoundedBtnWidget(
                        bgColor: Colors.white,
                        boxBorder: Border.all(color: Colors.black , width: .5),
                        borderRadios: 10,
                        btnTextColor: Colors.black,
                        btnPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        onTap: () {
                          Get.dialog(BlocProvider.value(
                            value: getIt<TransactionBloc>()..add(GetTransactionDetailsEvent(e.id)),
                            child: const TransactionDetailsDialog(),
                          ));
                        },
                        btnText: S.current.viewDetails,
                      ),
                    ),
                  )),
                ]))
            .toList()
      ],
    );
  }
}
