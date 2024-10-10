import '../../entity/order_status.dart';

class OrderStatusesResponse {
  List<OrderStatusItemResponse> statues;

  OrderStatusesResponse(this.statues);

  OrderStatusesResponse.fromJson(List<dynamic>? json) : statues = json?.map((e) => OrderStatusItemResponse.fromJson(e)).toList() ?? [];

  List<OrderStatus> toEntity() => statues.map((e) => OrderStatus(e.id ?? 0, e.title ?? '-', e.isCompleted ?? false)).toList();
}

class OrderStatusItemResponse {
  int? id;
  String? title;
  bool? isCompleted;

  OrderStatusItemResponse({this.id, this.title, this.isCompleted});

  OrderStatusItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() => {};
}
