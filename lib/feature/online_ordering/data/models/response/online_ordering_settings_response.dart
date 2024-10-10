import 'package:merchant_dashboard/feature/online_ordering/data/models/entity/online_ordering_settings.dart';

class OnlineOrderingSettingsResponse {
  String? branchId;
  bool? onlineOrderingAllowed;
  bool? canTakeOrderViaWhatsapp;
  String? orderWhatsAppNumber;
  String? domainAddress;

  OnlineOrderingSettingsResponse(
      {this.branchId, this.onlineOrderingAllowed, this.canTakeOrderViaWhatsapp, this.orderWhatsAppNumber, this.domainAddress});

  OnlineOrderingSettingsResponse.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    onlineOrderingAllowed = json['onlineOrderingAllowed'];
    canTakeOrderViaWhatsapp = json['canTakeOrderViaWhatsapp'];
    orderWhatsAppNumber = json['orderWhatsAppNumber'];
    domainAddress = json['domainAddress'];
  }

  OnlineOrderingSettings toEntity() => OnlineOrderingSettings(
      onlineOrderingAllowed: onlineOrderingAllowed ?? false,
      canTakeOrderViaWhatsapp: canTakeOrderViaWhatsapp ?? false,
      orderWhatsAppNumber: orderWhatsAppNumber ?? '',
      domainAddress: domainAddress ?? '');
}
