import 'package:merchant_dashboard/feature/customers/data/models/entity/customer_list_info.dart';
import 'package:merchant_dashboard/feature/orders/data/models/entity/param_object.dart';
import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';

import 'order_product.dart';
import 'order_status.dart';

class OrderListInfo {
  final int currentPageNumber;
  final int totalPageCount;

  final List<OrderItem> orderItem;

  OrderListInfo({required this.currentPageNumber, required this.totalPageCount, required this.orderItem});
}

class OrderItem with DateTimeUtilities {
  /// This filed is the [id] field which is order original id that should use for operations
  final String originalId;

  /// This field is [queueNumber] which display as order id to the user
  final int id;

  final List<OrderProduct> orderDetails;

  final List<OrderStatus> possibleStatuses;
  final String _createdOn;
  String get createdOn => convertDateFormat(_createdOn);
  final num totalPrice;
  final num totalFinalPrice;
  final ParamObject param1Object;
  final ParamObject param2Object;
  final ParamObject param3Object;

  final int queueStatusId;
  final String queueStatusName;
  final num totalTax;
  final Customer? customer;
  final String orderedAddress;
  final String note;

  final int? userPayTypeDefinedId;

  final String paymentTypeTitle;
  final int deliveryServiceType;
  final String deliveryServiceTypeTitle;
  final String transactionCashierName;
  final List<String> _paymentMods;
  final num deliveryFee;
  final num deliveryMaxDiscount;
  final num lat;
  final num lng;
  final bool deliveryDiscountAllowed;

  String get paymentMods => _paymentMods.isEmpty ? paymentTypeTitle : _paymentMods.join(',');

  OrderItem({
    required this.orderDetails,
    required this.param1Object,
    required this.param2Object,
    required this.param3Object,
    required this.originalId,
    required this.deliveryFee,
    required this.deliveryMaxDiscount,
    required this.deliveryDiscountAllowed,
    required this.id,
    required this.possibleStatuses,
    required String createdOn,
    required this.queueStatusName,
    required this.totalFinalPrice,
    required this.totalPrice,
    required this.queueStatusId,
    required this.orderedAddress,
    required this.lng,
    required this.lat,
    required this.totalTax,
    required this.customer,
    required this.userPayTypeDefinedId,
    required this.paymentTypeTitle,
    required this.deliveryServiceType,
    required this.note,
    required this.deliveryServiceTypeTitle,
    required this.transactionCashierName,
    required List<String> paymentMods,
  })  : _createdOn = createdOn,
        _paymentMods = paymentMods;
}
