import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class UpdateOnlineOrderingSettingsParameter extends MerchantBranchParameter {
  final bool onlineOrderingAllowed;
  final bool whatsappOrderingAllowed;
  final String whatsappNumber;

  UpdateOnlineOrderingSettingsParameter(
      {required this.onlineOrderingAllowed, required this.whatsappOrderingAllowed, required this.whatsappNumber});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        'onlineOrderingAllowed': onlineOrderingAllowed,
        'orderWhatsAppNumber': whatsappNumber,
        'canTakeOrderViaWhatsapp': whatsappOrderingAllowed,
      };
}
