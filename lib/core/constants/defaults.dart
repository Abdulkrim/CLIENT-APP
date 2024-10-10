class UIDefaults {
  static const double drawerItemsWidth = 250;
  static const double drawerItemsHeight = 30;
}

class Defaults {
  static Duration defaultAnimDuration = const Duration(milliseconds: 300);

  static final String startDateRange = "${DateTime.now().year}/${DateTime.now().month}/01";
  static final String endDateRange = "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";

  static const String canceledRequest = "cancelled";

  static const String sortFiledPrice = 'price';
  static const String sortFiledQuantity = 'Quantity';
  static const String sortFiledSales = 'Sales';
  static const String sortTypeDESC = 'desc';
  static const String sortTypeASC = 'asc';

  static const String userG = 'business';
  static const String userM = 'branch';
  static const String userA = 'A';

  static const int cancelledStatusCode = 15;
  static const int completedStatusCode = 8;

  static const String businessNameKey = 'BusinessName';
  static const String contactNameKey = 'ContactName';
  static const String businessAddressKey = 'BusinessAddress';
  static const String phoneNumberKey = 'PhoneNumber';
}

enum QueryOperator {
  contains(0),
  greaterThan(1),
  greaterThanOrEqualTo(2),
  lessThan(3),
  lessThanOrEqualTo(4),
  startsWith(5),
  endsWith(6),
  equals(7),
  notEqual(8);

  const QueryOperator(this.value);

  final int value;
}

enum LogicalOperator {
  and(0),
  or(1);

  const LogicalOperator(this.value);
  final int value;
}

enum OrderOperator {
  asc(1),
  desc(2);

  const OrderOperator(this.value);
  final int value;
}

enum Gender {
  male(0),
  female(1);

  const Gender(this.value);
  final int value;
}

enum CustomerPayType {
  cash(1),
  credit(2);

  const CustomerPayType(this.value);
  final int value;
}

bool hideForThisV = false;
