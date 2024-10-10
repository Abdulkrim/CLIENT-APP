import 'package:json_annotation/json_annotation.dart';

part 'sales_per_timeline_item_response.g.dart';

@JsonSerializable()
class SalesPerTimelineItemResponse {
  num? sumPrice;
  String? date;
  String? weekDay;
  int? count;
  String? interval;
  String? day;
  int? hour;
  int? weekNumber;

  SalesPerTimelineItemResponse(
      {this.sumPrice,
      this.date,
      this.weekDay,
      this.count,
      this.interval,
      this.day,
      this.hour,
      this.weekNumber});

  factory SalesPerTimelineItemResponse.fromJson(Map<String, dynamic>? json) =>
      json != null ? _$SalesPerTimelineItemResponseFromJson(json) : SalesPerTimelineItemResponse();
}
