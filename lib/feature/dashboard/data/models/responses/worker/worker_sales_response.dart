import '../../entities/worker_report.dart';

class WorkerSalesResponse {
  List<WorkerSaleItemResponse>? items;

  WorkerSalesResponse.fromJson(List<dynamic>? data)
      : items = data?.map((e) => WorkerSaleItemResponse.fromJson(e)).toList() ?? [];

  List<WorkerReport> toEntity() =>
      items
          ?.map((e) => WorkerReport(
              workerName: e.workerName ?? '', workerId: e.workerId ?? '0', sumPrice: e.sumPrice ?? 0))
          .toList() ??
      [];
}

class WorkerSaleItemResponse {
  String? workerName;
  String? workerId;
  int? count;
  num? sumPrice;

  WorkerSaleItemResponse({this.workerName, this.workerId, this.count, this.sumPrice});

  WorkerSaleItemResponse.fromJson(Map<String, dynamic> json) {
    workerName = json['workerName'];
    workerId = json['workerId'];
    count = json['count'];
    sumPrice = json['sumPrice'];
  }
}
