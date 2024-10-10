import 'package:json_annotation/json_annotation.dart';

part 'worker_item_response.g.dart';

@JsonSerializable()
class WorkerItemResponse {
  String? id;
  String? branchId;
  String? fullName;
  bool? isActive;
  num? total;

  WorkerItemResponse({this.id, this.total, this.branchId, this.fullName, this.isActive});

  factory WorkerItemResponse.fromJson(Map<String, dynamic> json) => _$WorkerItemResponseFromJson(json);
}
