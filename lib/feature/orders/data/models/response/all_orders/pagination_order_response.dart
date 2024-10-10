import 'package:json_annotation/json_annotation.dart';

import '../../entity/orders.dart';
import 'order_item_response.dart';

part 'pagination_order_response.g.dart';

@JsonSerializable()
class PaginationOrderResponse {
  List<OrderItemResponse>? value;
  int? currentPageNumber;
  int? pageSize;
  int? totalPageCount;

  PaginationOrderResponse({this.value, this.currentPageNumber, this.pageSize, this.totalPageCount});

  factory PaginationOrderResponse.fromJson(Map<String, dynamic>? json) => json == null ?   PaginationOrderResponse():
      _$PaginationOrderResponseFromJson(json);

  OrderListInfo toEntity() => OrderListInfo(
      currentPageNumber: currentPageNumber ?? 1,
      totalPageCount: totalPageCount ?? 1,
      orderItem: value?.map((e) => e.toEntity()).toList() ?? []);
}
