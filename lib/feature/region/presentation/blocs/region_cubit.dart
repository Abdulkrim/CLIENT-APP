import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/entity/city.dart';
import '../../data/models/entity/country.dart';
import '../../data/repository/region_repository.dart';

part 'region_state.dart';

@injectable
class RegionCubit extends Cubit<RegionState> {
  final IRegionRepository _regionRepository;

  List<Country> countries = [];

  List<City> cities = [];

  String? countryNameByIP;
  String? cityNameByIP;

  RegionCubit(this._regionRepository) : super(RegionInitial());

  getAllCountriesAndCities([int? preSelectedCountry]) async {
    emit(const GetCountriesState(isLoading: true));
    if (countries.isEmpty) {
      final result = await _regionRepository.getCountries();
      result.fold((left) => debugPrint(left.errorMessage), (right) {
        countries = right;
        emit(const GetCountriesState(isSuccess: true));

        if (preSelectedCountry != null) getCountryCities(preSelectedCountry);
      });
    } else {
      if (preSelectedCountry != null) getCountryCities(preSelectedCountry);
    }
  }

  getCountryCities(int countryId) async {
    emit(const GetCitiesState(isLoading: true));

    final result = await _regionRepository.getCitiesOfCountry(countryId);
    result.fold((left) => debugPrint(left.errorMessage), (right) {
      cities = right;

      emit(const GetCitiesState(isSuccess: true));
    });
  }

  getCountryCityByIP() async {
    final result = await _regionRepository.getCountryCityByIP();
    result.fold((left) => debugPrint(left.errorMessage), (right) {
      countryNameByIP = right.countryName;
      cityNameByIP = right.cityName;
    });
  }

  getBranchCities() async {
    cities = [];
    emit(const GetCitiesState(isLoading: true));

    final result = await _regionRepository.getCitiesOfBranchCountry();
    result.fold((left) => debugPrint(left.errorMessage), (right) {
      cities = right;

      emit(const GetCitiesState(isSuccess: true));
    });
  }
}
