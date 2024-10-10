import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/region/data/data_source/region_remote_datasource.dart';

import '../../../../core/utils/exceptions.dart';
import '../../../../core/utils/failure.dart';
import '../models/entity/city.dart';
import '../models/entity/country.dart';

abstract class IRegionRepository {
  Future<Either<Failure, List<Country>>> getCountries();

  Future<Either<Failure, List<City>>> getCitiesOfCountry(int country);

  Future<Either<Failure, List<City>>> getCitiesOfBranchCountry();

  Future<Either<Failure, ({String countryName, String cityName})>> getCountryCityByIP();
}

@LazySingleton(as: IRegionRepository)
class RegionRepository extends IRegionRepository {
  final IRegionRemoteDataSource _regionRemoteDataSource;

  RegionRepository(this._regionRemoteDataSource);

  @override
  Future<Either<Failure, List<Country>>> getCountries() async {
    try {
      final response = await _regionRemoteDataSource.getCountries();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<City>>> getCitiesOfCountry(int country) async {
    try {
      final response = await _regionRemoteDataSource.getCitiesOfCountry(country);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }


  @override
  Future<Either<Failure, List<City>>> getCitiesOfBranchCountry()async {
    try {
      final response = await _regionRemoteDataSource.getCitiesOfBranchCountry( );

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, ({String cityName, String countryName})>> getCountryCityByIP() async {
    try {
      final ip = await _regionRemoteDataSource.getUserIp();

      final response = await _regionRemoteDataSource.getCountryCityByIP(ip);

      return Right(response);

    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
