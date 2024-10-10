import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../data/models/entity/products_reports.dart';

class DesktopProductsReportTableWidget extends StatelessWidget {
  final List<ProductItemReport> products;

  const DesktopProductsReportTableWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {6: FractionColumnWidth(.2)},
      children: [
        context.headerTableRow([
          S.current.name,
          S.current.catEngName,
          S.current.total,
          S.current.tax,
        ]),
        ...products
            .map((e) => TableRow(children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e.itemName,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.subcategory,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.total.toString(),
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
