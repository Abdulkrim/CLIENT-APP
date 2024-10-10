import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/orders/data/models/entity/orders.dart';
import 'package:merchant_dashboard/feature/orders/presentation/blocs/order_management_bloc.dart';
import 'package:merchant_dashboard/feature/orders/presentation/widgets/order_details_widget.dart';
import 'package:merchant_dashboard/feature/orders/presentation/widgets/order_status_box_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

class MobileOrdersListWidget extends StatelessWidget {
  const MobileOrdersListWidget({
    Key? key,
    required this.orders,
    // required this.hasMore,
  }) : super(key: key);
  final List<OrderItem> orders;

  // final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // key: key,
      itemCount: orders.length,
      itemBuilder: (context, index) => MobileOrderItemWidget(order: orders[index]),
    );
  }
}

class MobileOrderItemWidget extends StatefulWidget {
  final OrderItem order;

  const MobileOrderItemWidget({Key? key, required this.order}) : super(key: key);

  @override
  State<MobileOrderItemWidget> createState() => _MobileOrderItemWidgetState();
}

class _MobileOrderItemWidgetState extends State<MobileOrderItemWidget> {
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    //   _scrollController.addListener(() {
    //     if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
    //       context.read<OrderManagementBloc>().add(const GetAllOrderRequestEvent(getMore: true));
    //     }
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.lightGray,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                  child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: '${S.current.id} \n', style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                  TextSpan(text: widget.order.id.toString(), style: context.textTheme.bodyMedium),
                ]),
              )),
              Expanded(
                  child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: '${S.current.created} \n', style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                  TextSpan(text: widget.order.createdOn, style: context.textTheme.bodyMedium),
                ]),
              )),
            ],
          ),
          context.sizedBoxHeightExtraSmall,
          Row(
            children: [
              Expanded(
                  child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: '${S.current.amount} \n', style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                  TextSpan(text: widget.order.totalFinalPrice.toString(), style: context.textTheme.bodyMedium),
                ]),
              )),
              Expanded(
                  child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: '${S.current.status} \n', style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                  WidgetSpan(child: OrderStatusBoxWidget(orderItem: widget.order)),
                ]),
              )),
              Expanded(
                  child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '${S.current.orderDetails} \n', style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                  WidgetSpan(
                    child: TextButton(
                      onPressed: () {
                        Get.to(BlocProvider<OrderManagementBloc>.value(
                          value: BlocProvider.of<OrderManagementBloc>(context),
                          child: OrderDetailsWidget(
                            orderId: widget.order.originalId,
                            onBackTap: () {
                              Get.back();
                            },
                          ),
                        ));
                      },
                      child: Text(S.current.viewDetails,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(decoration: TextDecoration.underline)),
                    ),
                  ),
                ]),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
