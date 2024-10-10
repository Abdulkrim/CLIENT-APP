import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../data/models/entity/sub_categories_reports.dart';

class DesktopSubCategoriesReportTableWidget extends StatelessWidget {
  final List<SubCategoryItemReport> subCategories;

  const DesktopSubCategoriesReportTableWidget({
    Key? key,
    required this.subCategories,
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
          S.current.sales,
          S.current.tax,
        ]),
        ...subCategories
            .map((e) => TableRow(children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e.subName,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.categoryName.toString(),
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
