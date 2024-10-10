import '../../../../../utils/mixins/date_time_utilities.dart';

class LoyaltyPoint {
  final List<LoyaltyPointItem> points;
  final int totalPage;

  LoyaltyPoint(this.points, this.totalPage);
}

class LoyaltyPointItem with DateTimeUtilities {
  final int reasonId;
  final String reasonName;
  final num _point;

  num get originalPoint => _point;

  bool get isEarnedPoint => _point >= 0;

  String get point => _point.toStringAsFixed(2);

  String get pointWithSign => _point > 1 ? '+${_point.toStringAsFixed(2)}' : '-${_point.toStringAsFixed(2)}';

  String get pointType => _point > 1 ? 'Point Earned' : 'Point Spent';

  final String _date;

  String get date => convertDateFormat(_date, hasTime: false);

  String get dayDateFormatted => convertDateFormat(
        _date,
        hasTime: false,
        requestedFormet: "dd MMMM y",
      );

  final num balance;

  LoyaltyPointItem({
    required this.reasonId,
    required this.reasonName,
    required num point,
    required String date,
    required this.balance,
  })  : _date = date,
        _point = point;
}
