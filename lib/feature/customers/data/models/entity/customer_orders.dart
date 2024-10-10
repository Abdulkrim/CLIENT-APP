import '../../../../../utils/mixins/date_time_utilities.dart';

class CustomerOrders {
  final int currentPageNumber;
  final int totalPageCount;

  final List<CustomerOrder> orders;

  CustomerOrders({required this.currentPageNumber, required this.totalPageCount, required this.orders});
}

class CustomerOrder with DateTimeUtilities {
  final String id;
  final String queueNumber;
  final num totalPrice;
  final num totalTax;
  final num totalDiscount;
  final num totalFinalPrice;
  final num couponDetailId;
  final num businessTypeId;
  final num totalQuantity;
  final String requestedBy;
  final List<CustomerOrderItem> customerOrderItem;

  final String customer;
  final String branch;

  final String _date;

  String get date => convertDateFormat(_date);

  CustomerOrder(
      {required this.id,
      required this.queueNumber,
      required this.totalPrice,
      required this.totalTax,
      required this.totalDiscount,
      required this.totalFinalPrice,
      required this.couponDetailId,
      required this.businessTypeId,
      required this.totalQuantity,
      required this.requestedBy,
      required this.customerOrderItem,
      required String date,
      required this.customer,
      required this.branch})
      : _date = date;
}

class CustomerOrderItem {
  final String id;
  final num originalPrice;
  final num discountPrice;
  final num taxPrice;
  final num finalPrice;
  final num quantity;
  final num taxTypeId;
  final num taxValue;
  final String item;

  CustomerOrderItem(
      {required this.id,
      required this.originalPrice,
      required this.discountPrice,
      required this.taxPrice,
      required this.finalPrice,
      required this.quantity,
      required this.taxTypeId,
      required this.taxValue,
      required this.item});
}
