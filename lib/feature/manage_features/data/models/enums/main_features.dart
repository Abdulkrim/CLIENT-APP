enum InvoiceManagementGroup {
  gKey('InvoiceManagement'),
  splitPayment('InvoiceManagement'),
  multiInvoiceCopies('MultiinvoiceCopies'),
  smsNotificationToCustomer('SMSnotificationtocustomer');

  const InvoiceManagementGroup(this.key);

  final String key;
}

enum RefundManagement {
  gKey('RefundManagement'),
  partialClaim('PartialClaim(Client-POS)'),
  approval('Approval');

  const RefundManagement(this.key);

  final String key;
}

enum OnlineOrdering {
  gKey('OnlineOrdering(Catalogak)');

  const OnlineOrdering(this.key);
  final String key;
}

enum BusinessTimingManagement {
  gKey('BusinessTimingManagement'),
  flexible('Flexible'),
  prefixedOrRestriced('Prefixed/Restricted');

  const BusinessTimingManagement(this.key);
  final String key;
}

enum Queue {
  gKey('Queue'),
  paidQueue('PaidQueue'),
  smsNotificationtocustomer('SMSnotificationtocustomer');

  const Queue(this.key);
  final String key;
}

enum CashDrawer {
  gKey('CashDrawer');

  const CashDrawer(this.key);
  final String key;
}

enum ExternalPrinter {
  gKey('ExternalPrinter');

  const ExternalPrinter(this.key);
  final String key;
}

enum Customer {
  gKey('Customer'),
  creditCustomer('CreditCustomer');

  const Customer(this.key);
  final String key;
}

enum Stock {
  gKey('BasicStock'),
  wac('WAC'),
  unitsManagement('UnitsManagement'),
  ingredients('Ingredients(Rawmaterials)(ALL)'),
  lowStocknotification('Lowstocknotification');

  const Stock(this.key);
  final String key;
}

enum SalesFacility {
  gKey('SalesFacility'),
  coupons('Coupons'),
  loyalty('Loyalty'),
  temporaryprices('Temporaryprices'),
  subscriptionforServiceorproduct('SubscriptionforServiceorproduct'),
  discountCard('DiscountCard');

  const SalesFacility(this.key);
  final String key;
}

enum Expense {
  gKey('Expense');

  const Expense(this.key);
  final String key;
}

enum DeliveryManagement {
  gKey('DeliveryManagement');

  const DeliveryManagement(this.key);
  final String key;
}

enum AppointmentOrBooking {
  gKey('Appointment/Booking'),
  withResource('WithResource'),
  withWorker('WithWorker');

  const AppointmentOrBooking(this.key);
  final String key;
}

enum POSLocationTracking {
  gKey('POSLocationTracking');

  const POSLocationTracking(this.key);
  final String key;
}

enum FastPrinting {
  gKey('FastPrinting');

  const FastPrinting(this.key);
  final String key;
}
