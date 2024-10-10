import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/workers/data/models/entity/worker_list_info.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../widgets/profile_generator_image_widget.dart';

class DesktopWorkerSalesTableWidget extends StatelessWidget {
  final List<WorkerItem> workers;

  const DesktopWorkerSalesTableWidget({
    super.key,
    required this.workers,
  });

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
          S.current.sales,
        ],alignment:  Alignment.centerLeft),
        ...workers
            .map((e) => TableRow(children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: ProfileGeneratorImageWidget(
                        itemLabel: e.fullName,
                        itemColorIndex: 2,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.fullName,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.total.toString(),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ]))
            .toList()
      ],
    );
  }
}
