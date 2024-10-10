
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'posTransactionPrintType')
enum PrintTrxOptionsEnum {
  bothCloudAndPOS(0),
  onlyCloud(1),
  onlyPOS(2),
  none(3),
  ;

  final int posTransactionPrintType;

  const PrintTrxOptionsEnum(this.posTransactionPrintType);

  static PrintTrxOptionsEnum fromIntegerValue(int? value) {
    switch (value) {
      case 0:
        return PrintTrxOptionsEnum.bothCloudAndPOS;
      case 1:
        return PrintTrxOptionsEnum.onlyCloud;
      case 2:
        return PrintTrxOptionsEnum.onlyPOS;
      case 3:
        return PrintTrxOptionsEnum.none;
      default:
        return PrintTrxOptionsEnum.bothCloudAndPOS;
    }
  }
}
