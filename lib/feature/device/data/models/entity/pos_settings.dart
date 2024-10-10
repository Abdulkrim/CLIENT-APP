import '../enums/print_order_options.dart';
import '../enums/print_trx_options.dart';

class POSSettings {
  final int queueAllowed;
  final int discountAllowed;
  final bool printAllowed;
  final String footerMessage;
  final bool rePrint;
  final int merchantCopy;
  final String printingLogoLink;
  final String footerLogoLink;
  final String queueAllowedString;
  final String discountAllowedString;
  final String merchantCopyString;

  final PrintTrxOptionsEnum printTrxOptionsEnum;
  final PrintOrderOptionsEnum printOrderOptionsEnum;

  POSSettings({
    required this.printTrxOptionsEnum,
    required this.printOrderOptionsEnum,
    required this.queueAllowed,
    required this.discountAllowed,
    required this.printAllowed,
    required this.footerMessage,
    required this.rePrint,
    required this.merchantCopy,
    required this.printingLogoLink,
    required this.footerLogoLink,
    required this.queueAllowedString,
    required this.discountAllowedString,
    required this.merchantCopyString,
  });
}
