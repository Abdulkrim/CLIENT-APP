
import '../../../../../utils/mixins/mixins.dart';

class SalesPerTimeline with DateTimeUtils {
  final String date;
  final String weekDay;
  final int count;
  final String interval;
  final String day;
  final int hour;
  final int weekNumber;
  final int itemNumber;

  num sumPrice;
  num secondSumPrice = 0;
  String secondPriceType = '';
  String firstPriceType = '';

  int get horizontalAxisValue => switch (interval.toLowerCase()) {
        'hour' => hour,
        'day' => getDayNumber(weekDay),
        _ => itemNumber,
      };

  SalesPerTimeline(
      {required this.sumPrice,
      required this.date,
      required this.weekDay,
      required this.count,
      required this.interval,
      required this.day,
      required this.hour,
      required this.weekNumber,
      required this.itemNumber});
}
