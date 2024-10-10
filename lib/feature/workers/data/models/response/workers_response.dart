import 'package:json_annotation/json_annotation.dart';

import '../entity/worker_list_info.dart';
import 'worker_item_response.dart';

part 'workers_response.g.dart';

@JsonSerializable()
class WorkersResponse {
  List<WorkerItemResponse>? value;
  int? currentPageNumber;
  int? totalPageCount;

  WorkersResponse({this.value, this.currentPageNumber, this.totalPageCount});

  factory WorkersResponse.fromJson(Map<String, dynamic> json) => _$WorkersResponseFromJson(json);

  WorkerListInfo toEntity() => WorkerListInfo(
      value
              ?.map((e) => WorkerItem(
                  id: e.id ?? '',
                  branchId: e.branchId ?? '',
                  fullName: e.fullName ?? '',
                  total: e.total ?? 0,
                  isActive: e.isActive ?? false))
              .toList() ??
          [],
      currentPageNumber ?? 1,
      totalPageCount ?? 1);
}
