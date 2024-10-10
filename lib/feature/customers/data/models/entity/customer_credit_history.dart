import '../../../../../utils/mixins/date_time_utilities.dart';

class CustomerCreditHistory with DateTimeUtilities {
  final String _dateTime;

  String get dateTime => convertDateFormat(_dateTime);

  final int id;
  final String type;
  bool get isTransactionType => type.toLowerCase() == 'transaction';

  final num amount;
  final num balance;

  CustomerCreditHistory({
    required this. id,
    required String dateTime,
    required this.type,
    required this.amount,
    required this.balance,
  }): _dateTime = dateTime;
}
