import 'package:merchant_dashboard/utils/mixins/mixins.dart';

class ChangeOrderStatusParameter with DateTimeUtils {
  final String orderId;
  final String? cashierId;
  final String? referenceId;
  final int statusCode;
  final num totalAmount;
  final int? paymentType;
  final num deliveryDiscount;
  late final String currentDate = fullTimeZoneCurrentDateTime;

  ChangeOrderStatusParameter(
      {required this.orderId,
      required this.cashierId,
      required this.statusCode,
      required this.totalAmount,
      required this.paymentType,
      required this.deliveryDiscount,
      this.referenceId});

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'statusId': statusCode,
        if (cashierId != null) 'cashierId': cashierId,
        'operatedOn': currentDate,
        if (paymentType != null)
          'paymentInfos': [
            {'amount': totalAmount, 'paymentMode': paymentType, "ReferenceNumber": referenceId},
          ],
        if (deliveryDiscount != null) 'deliveryDiscount': deliveryDiscount,
      };
}
