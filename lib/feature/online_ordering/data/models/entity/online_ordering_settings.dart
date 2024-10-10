class OnlineOrderingSettings {
  final bool onlineOrderingAllowed;
  final bool canTakeOrderViaWhatsapp;
  final String _orderWhatsAppNumber;
  String get orderWhatsAppNumber => _orderWhatsAppNumber.replaceFirst('+', '');
  final String domainAddress;

  OnlineOrderingSettings({
    required this.onlineOrderingAllowed,
    required this.canTakeOrderViaWhatsapp,
    required String orderWhatsAppNumber,
    required this.domainAddress,
  }): _orderWhatsAppNumber = orderWhatsAppNumber;
}
