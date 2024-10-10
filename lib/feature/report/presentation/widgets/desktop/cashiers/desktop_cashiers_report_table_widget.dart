import 'package:flutter/material.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../data/models/entity/cashiers_reports.dart';

class DesktopCashiersReportTableWidget extends StatelessWidget {
  final List<CashierItemReport> cashiers;

  const DesktopCashiersReportTableWidget({
    Key? key,
    required this.cashiers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {6: FractionColumnWidth(.2)},
      children: [
        context.headerTableRow([
          S.current.name,
          S.current.sales,
          S.current.tax,
        ]),
        ...cashiers
            .map((e) => TableRow(children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e.cashierName,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.totalSales.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.tax.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]))
            .toList()
      ],
    );
  }
}
