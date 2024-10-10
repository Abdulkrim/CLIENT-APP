import 'package:dio/dio.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../merchant_info/data/models/params/update_merchant_logo_parameter.dart';

class UpdatePOSSettingsParameter extends MerchantBranchParameter {
  final bool printAllowed;
  final String footerMessage;
  final bool rePrint;
  final int merchantCopy;
  final int queueAllowed;
  final int discountAllowed;
  final UpdateMerchantLogoParameter? footerLogo;
  final UpdateMerchantLogoParameter? printingLogo;
  final int posOrderFromPOS;
  final int posTrxFromPOS;

  UpdatePOSSettingsParameter(
      {required this.printAllowed,
      required this.queueAllowed,
      required this.discountAllowed,
      required this.footerMessage,
      required this.footerLogo,
      required this.printingLogo,
      required this.rePrint,
      required this.posTrxFromPOS,
      required this.posOrderFromPOS,
      required this.merchantCopy});

  FormData toFormData() => FormData.fromMap({
        if (footerLogo != null) ...{
          'Logos[0].Logo':
              MultipartFile.fromBytes(footerLogo!.byte, filename: footerLogo!.filename, contentType: MediaType('image', '*')),
          'Logos[0].ImageType': footerLogo!.logoTypeId
        },
        if (printingLogo != null) ...{
          'Logos[1].Logo':
              MultipartFile.fromBytes(printingLogo!.byte, filename: printingLogo!.filename, contentType: MediaType('image', '*')),
          'Logos[1].ImageType': printingLogo!.logoTypeId
        },
        ..._toJson(),
      });

  Map<String, dynamic> _toJson() => {
        ...?super.branchToJson(),
        "printAllowed": printAllowed,
        "footerMessage": footerMessage,
        "rePrint": rePrint,
        "merchantCopy": merchantCopy,
        "queueAllowed": queueAllowed,
        "discountAllowed": discountAllowed,
        "PosOrderPrintType": posOrderFromPOS,
        "PosTransactionPrintType": posTrxFromPOS,
      };
}
