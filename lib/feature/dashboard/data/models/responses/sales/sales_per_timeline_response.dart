import '../../entities/sales_per_timeline.dart';
import 'sales_per_timeline_item_response.dart';

class SalesPerTimelineResponse {
  List<SalesPerTimelineItemResponse> sales;

  SalesPerTimelineResponse(this.sales);

  SalesPerTimelineResponse.fromJson(List<dynamic>? json)
      : sales = json?.map((e) => SalesPerTimelineItemResponse.fromJson(e)).toList() ?? [];

  List<SalesPerTimeline> toEntity() => sales
      .asMap()
      .map((key, e) => MapEntry(
          key,
          SalesPerTimeline(
              sumPrice: e.sumPrice ?? 0,
              date: e.date ?? '',
              weekDay: e.weekDay ?? '',
              count: e.count ?? 0,
              day: e.day ?? '',
              hour: e.hour ?? 0,
              interval: e.interval ?? '',
              weekNumber: e.weekNumber ?? 0,
              itemNumber: key + 1)))
      .values
      .toList();
}
