
/* 
class OrderDetails with DateTimeUtilities {

  /// This filed is the [id] field which is order original id that should use for operations
  final String originalId;

  /// This field is [queueNumber] which display as order id to the user
  final int id;

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
  final Customer customer;
  final String orderedAddress;
  final String note;

  final int? paymentType;
  // int? get paymentType => 2;

  final String paymentTypeTitle;
  final int deliveryServiceType;
  final String deliveryServiceTypeTitle;

  OrderDetails({
    required this.orderProducts,
    required this.param1Object,
    required this.param2Object,
    required this.param3Object,
    required this.originalId,
    required this.id,
    required this.possibleStatuses,
    required String createdOn,
    required this.queueStatusName,
    required this.totalFinalPrice,
    required this.totalPrice,
    required this.queueStatusId,
    required this.orderedAddress,
    required this.totalTax,
    required this.customer,
    required this.paymentType,
    required this.paymentTypeTitle,
    required this.deliveryServiceType,
    required this.note,
    required this.deliveryServiceTypeTitle,
  }) : _createdOn = createdOn;
}

class OrderProduct extends Equatable {
  final String id;
  final num originalPrice;
  final num quantity;
  final num discount;
  final num tax;
  final String productNameEn;
  final String productNameAr;
  final String productType;

  const OrderProducts({
    required this.id,
    required this.quantity,
    required this.discount,
    required this.originalPrice,
    required this.tax,
    required this.productNameEn,
    required this.productNameAr,
    required this.productType,
  });

  @override
  List<Object> get props => [
        id,
        quantity,
        discount,
        originalPrice,
        tax,
        productNameEn,
        productNameAr,
        productType,
      ];
}
 */