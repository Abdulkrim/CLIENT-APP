import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/device/data/models/entity/pos_settings.dart';

import '../enums/print_order_options.dart';
import '../enums/print_trx_options.dart';

part 'pos_settings_response.g.dart';

@JsonSerializable()
class PosSettingsResponse {
  int? queueAllowed;
  int? discountAllowed;
  String? branchID;
  bool? printAllowed;
  String? footerMessage;
  bool? rePrint;
  int? merchantCopy;
  String? printingLogoLink;
  String? footerLogoLink;
  String? queueAllowedString;
  String? discountAllowedString;
  String? merchantCopyString;
  PrintOrderOptionsEnum? posOrderPrintType;
  PrintTrxOptionsEnum? posTransactionPrintType;

  PosSettingsResponse(
      {this.queueAllowed,
      this.posOrderPrintType,
      this.posTransactionPrintType,
      this.discountAllowed,
      this.branchID,
      this.printAllowed,
      this.footerMessage,
      this.rePrint,
      this.merchantCopy,
      this.printingLogoLink,
      this.footerLogoLink,
      this.queueAllowedString,
      this.discountAllowedString,
      this.merchantCopyString});

  factory PosSettingsResponse.fromJson(Map<String, dynamic> json) => _$PosSettingsResponseFromJson(json);

  POSSettings toEntity() => POSSettings(
      printOrderOptionsEnum: posOrderPrintType ?? PrintOrderOptionsEnum.none,
      printTrxOptionsEnum: posTransactionPrintType ?? PrintTrxOptionsEnum.none,
      queueAllowed: queueAllowed ?? 0,
      discountAllowed: discountAllowed ?? 0,
      printAllowed: printAllowed ?? false,
      footerMessage: footerMessage ?? '',
      rePrint: rePrint ?? false,
      merchantCopy: merchantCopy ?? 0,
      printingLogoLink: printingLogoLink ?? '',
      footerLogoLink: footerLogoLink ?? '',
      queueAllowedString: queueAllowedString ?? '',
      discountAllowedString: discountAllowedString ?? '',
      merchantCopyString: merchantCopyString ?? '');
}
