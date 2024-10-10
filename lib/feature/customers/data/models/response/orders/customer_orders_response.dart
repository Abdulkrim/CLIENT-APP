import 'package:json_annotation/json_annotation.dart';

import '../../entity/customer_orders.dart';
import 'customer_order_value_response.dart';

part 'customer_orders_response.g.dart';

@JsonSerializable()
class CustomerOrdersResponse {
  List<CustomerOrderValueResponse>? value;
  int? currentPageNumber;
  int? pageSize;
  int? totalPageCount;

  CustomerOrdersResponse({this.value, this.currentPageNumber, this.pageSize, this.totalPageCount});

  factory CustomerOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerOrdersResponseFromJson(json);

  CustomerOrders toEntity() => CustomerOrders(
        currentPageNumber: currentPageNumber ?? 1,
        totalPageCount: totalPageCount ?? 1,
        orders: value
                ?.map((e) => CustomerOrder(
                    id: e.id ?? '',
                    totalPrice: e.totalPrice ?? 0,
                    totalTax: e.totalTax ?? 0,
                    totalDiscount: e.totalDiscount ?? 0,
                    totalFinalPrice: e.totalFinalPrice ?? 0,
                    couponDetailId: e.couponDetailId ?? 0,
                    businessTypeId: e.businessTypeId ?? 0,
                    totalQuantity: e.totalQuantity ?? 0,
                    requestedBy: e.requestedBy ?? '',
                    queueNumber: e.orderQueue?.queueNumber.toString() ?? '',
                    customerOrderItem: e.orderDetails
                            ?.map((d) => CustomerOrderItem(
                                id: d.id ?? '',
                                originalPrice: d.originalPrice ?? 0,
                                discountPrice: d.discountPrice ?? 0,
                                taxPrice: d.taxPrice ?? 0,
                                finalPrice: d.finalPrice ?? 0,
                                quantity: d.quantity ?? 0,
                                taxTypeId: d.taxTypeId ?? 0,
                                taxValue: d.taxValue ?? 0,
                                item: d.item?.itemNameEN ?? '-'))
                            .toList() ??
                        [],
                    date: e.orderProcesses?.firstOrNull?.operationDate ?? '',
                    customer: e.customer ?? '',
                    branch: e.branch ?? ''))
                .toList() ??
            [],
      );
}
