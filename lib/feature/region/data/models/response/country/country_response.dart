import '../../entity/country.dart';
import 'country_data_response.dart';

class CountryResponse {
  final List<CountryDataResponse> countryList;

  const CountryResponse(this.countryList);

  CountryResponse.fromJson(List<dynamic> json)
      : countryList = json.map((e) => CountryDataResponse.fromJson(e)).toList();

  List<Country> toEntity() => countryList
      .map((e) => Country(
          id: e.id ?? 0, name: e.name ?? '', countryCode: e.countryCode ?? '', flagPicture: e.flagUrl ?? ''))
      .toList();
}
