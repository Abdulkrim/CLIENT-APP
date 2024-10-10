import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/transaction.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/blocs/transaction_bloc.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/widgets/desktop/desktop_transaction_details_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';

import '../../../../../routes/app_routes.dart';

class DesktopTransactionTableWidget extends StatelessWidget with DownloadUtils {
  final List<Transaction> transactions;

  const DesktopTransactionTableWidget({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {6: FractionColumnWidth(.2)},
      children: [
        context.headerTableRow([
          S.current.cashier,
          S.current.transactionNo,
          S.current.customer,
          S.current.payment,
          S.current.date,
          S.current.total,
          S.current.action,
        ]),
        ...transactions
            .map((e) => TableRow(children: [
                  TableCell(
                    child: Text(
                      e.userName,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.transactionNo.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Visibility(
                      visible: e.customerPhoneNumber.isNotEmpty,
                      child: InkWell(
                        onTap: () => Get.toNamed(AppRoutes.customerSearchRoute, arguments: {"phone": e.customerPhoneNumber}),
                        child: Text(
                          e.customerName.isNotEmpty ? e.customerName : e.customerPhoneNumber,
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.payment.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.date,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.total.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                      child: Wrap(
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.dialog(BlocProvider.value(
                            value: getIt<TransactionBloc>()..add(GetTransactionDetailsEvent(e.transactionNo)),
                            child: DesktopTransactionDetailsWidget(transaction: e),
                          ));
                        },
                        child: Text(S.current.viewDetails,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(decoration: TextDecoration.underline)),
                      ),
                      Visibility(
                        visible: !e.isClaimed,
                        child: TextButton(
                          onPressed: () =>
                              context.read<TransactionBloc>().add(ClaimTransactionRequestEvent(e.transactionNo.toInt())),
                          child: Text(S.current.claim,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(decoration: TextDecoration.underline)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          openLink(url: e.transactionUrl);
                        },
                        child: Text(S.current.download,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.blueAccent, decoration: TextDecoration.underline)),
                      ),
                    ],
                  )),
                ]))
            .toList()
      ],
    );
  }
}
