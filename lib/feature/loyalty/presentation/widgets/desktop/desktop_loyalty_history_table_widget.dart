import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/loyalty/data/models/entity/loyalty_point.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../generated/l10n.dart';

class DesktopLoyaltyHistoryTableWidget extends StatelessWidget {
  final List<LoyaltyPointItem> points;
  final Function(LoyaltyPointItem point) onLoyaltyInformationTapped;

  const DesktopLoyaltyHistoryTableWidget(
      {Key? key, required this.points, required this.onLoyaltyInformationTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(.3),
      },
      children: [
        context.headerTableRow([
          '',
          S.current.date,
          S.current.type,
          S.current.point,
          S.current.balance,
          '',
        ],alignment:  Alignment.centerLeft),
        ...points
            .map((e) => TableRow(children: [
                  const TableCell(
                      child: SizedBox(
                    height: 50,
                  )),
                  TableCell(
                    child: Text(
                      e.date,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.reasonName,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.point.toString(),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.balance.toString(),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TableCell(
                      child: Center(
                    child: RoundedBtnWidget(
                      onTap: () {},
                      btnText: S.current.view,
                      bgColor: Colors.white,
                      btnPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      btnTextColor: Colors.black,
                      boxBorder: Border.all(color: Colors.black, width: .5),
                    ),
                  )),
                ]))
            .toList()
      ],
    );
  }
}
