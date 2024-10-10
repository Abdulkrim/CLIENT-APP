import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'posOrderPrintType')
enum PrintOrderOptionsEnum {
  bothCloudAndPOS(0),
  onlyCloud(1),
  onlyPOS(2),
  none(3),
  ;

  final int posOrderPrintType;

  const PrintOrderOptionsEnum(this.posOrderPrintType);

  static PrintOrderOptionsEnum fromIntegerValue(int? value) {
    switch (value) {
      case 0:
        return PrintOrderOptionsEnum.bothCloudAndPOS;
      case 1:
        return PrintOrderOptionsEnum.onlyCloud;
      case 2:
        return PrintOrderOptionsEnum.onlyPOS;
      case 3:
        return PrintOrderOptionsEnum.none;
      default:
        return PrintOrderOptionsEnum.bothCloudAndPOS;
    }
  }
}