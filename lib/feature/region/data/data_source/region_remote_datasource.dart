import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../models/response/city/cities_response.dart';
import '../models/response/country/country_response.dart';

abstract class IRegionRemoteDataSource {
  Future<CountryResponse> getCountries();

  Future<CitiesResponse> getCitiesOfCountry(int country);

  Future<CitiesResponse> getCitiesOfBranchCountry();

  Future<({String cityName, String countryName})> getCountryCityByIP(String ip);

  Future<String> getUserIp();
}

@LazySingleton(as: IRegionRemoteDataSource)
class RegionRemoteDataSource extends IRegionRemoteDataSource {
  final Dio _dioClient;

  RegionRemoteDataSource(this._dioClient);

  @override
  Future<CountryResponse> getCountries() async {
    try {
      final Response response = await _dioClient.get("Region/GetCountries");

      if (response.statusCode == 200) {
        final CountryResponse convertedResponse = CountryResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<CitiesResponse> getCitiesOfCountry(int country) async {
    try {
      final Response response = await _dioClient.get("Region/GetCitiesByCountryId?countryId=$country");

      if (response.statusCode == 200) {
        final CitiesResponse convertedResponse = CitiesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<CitiesResponse> getCitiesOfBranchCountry() async {
    try {
      final Response response =
          await _dioClient.get("Region/BranchCountryCities", queryParameters: MerchantBranchParameter().branchToJson());

      if (response.statusCode == 200) {
        final CitiesResponse convertedResponse = CitiesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<String> getUserIp() async {
    try {
      final Response response = await Dio().get('https://api64.ipify.org');

      if (response.statusCode == 200) {
        return response.data;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<({String cityName, String countryName})> getCountryCityByIP(String ip) async {
    try {
      final Response response = await Dio().get('https://api.ipstack.com/$ip?access_key=4ac7113386cad2c6734ceba30f46b17d');

      if (response.statusCode == 200) {
        return (cityName: response.data['city'] as String, countryName: response.data['country_name'] as String);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
