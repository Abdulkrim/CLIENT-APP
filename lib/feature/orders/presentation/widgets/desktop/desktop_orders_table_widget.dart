import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/orders/data/models/entity/orders.dart';
import 'package:merchant_dashboard/feature/orders/presentation/widgets/order_details_widget.dart';
import 'package:merchant_dashboard/feature/orders/presentation/widgets/order_status_box_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../blocs/order_management_bloc.dart';

class DesktopOrdersTableWidget extends StatelessWidget {
  const DesktopOrdersTableWidget({Key? key, required this.allOrders , required this.onOrderDetailsTap}) : super(key: key);

  final List<OrderItem> allOrders;
  final Function(OrderItem orderItem) onOrderDetailsTap;

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        context.headerTableRow([
          S.current.orderId,
          S.current.created,
          S.current.status,
          S.current.serviceType,
          S.current.amount,
          S.current.orderDetails,
        ]),
        ...allOrders
            .map((e) => TableRow(children: [
                  TableCell(
                    child: Text(
                      e.id.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(e.createdOn, textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: OrderStatusBoxWidget(orderItem: e)),
                  ),
                  TableCell(
                    child: Text(e.deliveryServiceTypeTitle, textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text(
                        '${e.totalFinalPrice} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                        textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: TextButton(
                      onPressed: () {
                       onOrderDetailsTap(e);
                      },
                      child: Text(S.current.viewDetails,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(decoration: TextDecoration.underline)),
                    ),
                  ),
                ]))
            .toList()
      ],
    );
  }
}
