import 'package:json_annotation/json_annotation.dart';

import '../../entities/cashier_report.dart';

part 'report_response.g.dart';

@JsonSerializable()
class ReportResponse {
  String? cashierName;
  String? cashierId;
  int? count;
  num? sumPrice;

  ReportResponse({this.cashierName, this.cashierId, this.count, this.sumPrice});

  factory ReportResponse.fromJson(Map<String, dynamic> json) => _$ReportResponseFromJson(json);
}

class ReportsResponse {
  List<ReportResponse> reports;

  ReportsResponse(this.reports);

  ReportsResponse.fromJson(List<dynamic>? json)
      : reports = json?.map((e) => ReportResponse.fromJson(e)).toList() ?? [];

  List<CashierReport> toEntity() => reports
      .map((e) => CashierReport(
          cashierName: e.cashierName ?? '',
          cashierId: e.cashierId ?? '',
          count: e.count ?? 0,
          sumPrice: e.sumPrice ?? 0))
      .toList();
}
