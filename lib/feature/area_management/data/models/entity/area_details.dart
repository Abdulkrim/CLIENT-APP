import 'package:merchant_dashboard/feature/region/data/models/entity/city.dart';

class AreaDetails {
  final int areaId;
  final String areaName;
  final int cityId;
  final String cityName;

  AreaDetails({required this.areaId, required this.areaName, required this.cityId, required this.cityName});
}

extension Converter on AreaDetails? {
  City toCity() => City(id: this?.cityId ?? 0, name: this?.cityName ?? '');

  AreaDetails toNewArea(String newName) => AreaDetails(areaId: 0 , cityId: 0, cityName: '' , areaName: newName);
}
