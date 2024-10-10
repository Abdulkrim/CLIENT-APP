import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/widgets/profile_generator_image_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

class DesktopSalesTableWidget extends StatelessWidget {
  final List<Cashier> cashiers;

  const DesktopSalesTableWidget({
    Key? key,
    required this.cashiers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FixedColumnWidth(110),
        1: FixedColumnWidth(250),
        2: FixedColumnWidth(150),
        3: FlexColumnWidth(1),
      },
      children: [
        context.headerTableRow([
          "",
          S.current.employeeName,
          S.current.role,
          S.current.sales,
        ],alignment:  Alignment.centerLeft),
        ...cashiers
            .map((e) => TableRow(children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: ProfileGeneratorImageWidget(
                        itemLabel: e.name,
                        itemColorIndex: e.randomColorPos,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.name,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.cashierRole,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.totalSales.toString(),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ]))
            .toList()
      ],
    );
  }
}
