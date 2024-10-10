import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/customers/data/models/entity/customer_orders.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

class CustomerOrdersListWidget extends StatefulWidget {
  const CustomerOrdersListWidget({
    Key? key,
    required this.orders,
    required this.hasMore,
    required this.getOrders,
  }) : super(key: key);

  final Function(bool getMore) getOrders;
  final List<CustomerOrder> orders;
  final bool hasMore;

  @override
  State<CustomerOrdersListWidget> createState() => _CustomerOrdersListWidgetState();
}

class _CustomerOrdersListWidgetState extends State<CustomerOrdersListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        widget.getOrders(true);
      }
    });
  }

  String selectedItemId = '0';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      primary: false,
      itemCount: (widget.hasMore && widget.orders.isNotEmpty) ? widget.orders.length + 1 : widget.orders.length,
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      itemBuilder: (context, index) => (index < widget.orders.length)
          ? _MobileOrderItemWidget(
              orderItem: widget.orders[index],
              onViewDetailsTap: () {
                setState(() => selectedItemId = selectedItemId = widget.orders[index].id);
              },
              selectedIemId: selectedItemId,
              closeDetailsTap: () => setState(() => selectedItemId = '0'),
            )
          : const CupertinoActivityIndicator(),
    );
  }
}

class _MobileOrderItemWidget extends StatelessWidget {
  final CustomerOrder orderItem;
  final Function() onViewDetailsTap;
  final Function() closeDetailsTap;
  final String selectedIemId;

  const _MobileOrderItemWidget({required this.orderItem, required this.onViewDetailsTap, required this.closeDetailsTap, required this.selectedIemId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.lightGray,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${S.current.orderNo}  - ${orderItem.queueNumber}",
                  textAlign: TextAlign.left,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              Text(
                orderItem.date,
                textAlign: TextAlign.right,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          context.sizedBoxHeightMicro,
          Row(
            children: [
              Expanded(
                  child: Text(
                "${S.current.discount}  = ${orderItem.totalDiscount.toString().getSeparatedNumber}",
                textAlign: TextAlign.left,
                style: context.textTheme.bodyMedium,
              )),
              Expanded(
                  child: Text(
                "${S.current.price}  = ${orderItem.totalPrice.toString().getSeparatedNumber}",
                textAlign: TextAlign.right,
                style: context.textTheme.bodyMedium,
              )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                "${S.current.tax}  = ${orderItem.totalTax.toString().getSeparatedNumber}",
                textAlign: TextAlign.left,
                style: context.textTheme.bodyMedium,
              )),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  TextButton(
                      onPressed: onViewDetailsTap,
                      child: Text(
                      S.current.viewDetails,
                        style: context.textTheme.titleSmall?.copyWith(decoration: TextDecoration.underline),
                      )),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: orderItem.id == selectedIemId,
                      child: IconButton(
                        onPressed: closeDetailsTap,
                        icon: const Icon(Icons.close_fullscreen_rounded),
                      ),
                    ),
                  ))
                ],
              ),
              context.sizedBoxHeightMicro,
              Visibility(
                  visible: orderItem.id == selectedIemId,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 8),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orderItem.customerOrderItem.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${S.current.name} - ${orderItem.customerOrderItem[index].item}",
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text("${S.current.quantity}  - ${orderItem.customerOrderItem[index].quantity}", textAlign: TextAlign.end, style: context.textTheme.titleSmall),
                          ],
                        ),
                        context.sizedBoxHeightMicro,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${S.current.price}  - ${orderItem.customerOrderItem[index].originalPrice}",
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text("${S.current.discount}  - ${orderItem.customerOrderItem[index].discountPrice}", textAlign: TextAlign.end, style: context.textTheme.titleSmall),
                          ],
                        ),
                        context.sizedBoxHeightMicro,
                        Divider(
                          color: AppColors.transparentGrayColor,
                          thickness: .7,
                        ),
                        context.sizedBoxHeightMicro,
                      ],
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  double _calculateAspectRatio(List<double> itemHeights) {
    // Calculate the average height of items
    double averageHeight = itemHeights.reduce((a, b) => a + b) / itemHeights.length;

    // Set the aspect ratio to be the reciprocal of the average height
    return 1.0 / (averageHeight / 100.0); // You can adjust the scale factor (100.0) as needed
  }
}
