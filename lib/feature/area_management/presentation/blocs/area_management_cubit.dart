import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/utils.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/entity/area_details.dart';
import '../../data/models/entity/area_item.dart';
import '../../data/repository/area_management_repository.dart';

part 'area_management_state.dart';

@injectable
class AreaManagementCubit extends Cubit<AreaManagementState> {
  final IAreaManagementRepository _areaManagementRepository;

  AreaManagementCubit(this._areaManagementRepository) : super(AreaManagementInitial());

  List<AreaItem> areas = [];
  List<AreaDetails> cityAreas = [];

  void getBranchAreas() async {
    emit(const GetAreasState(isLoading: true));
    final result = await _areaManagementRepository.getBranchAreas();

    result.fold(
      (left) => emit(GetAreasState(errorMessage: left.errorMessage)),
      (right) {
        areas = right;
        emit(const GetAreasState(isSuccess: true));
      },
    );
  }

  void getCityAreas({required int cityId}) async {
    cityAreas = [];
    emit(const GetCityAreasState(isLoading: true));
    final result = await _areaManagementRepository.getCityAreas(cityId);

    result.fold(
      (left) => emit(GetCityAreasState(errorMessage: left.errorMessage)),
      (right) {
        cityAreas = right;
        emit(const GetCityAreasState(isSuccess: true));
      },
    );
  }

  void createArea(
      {int? cityId,
      String? cityName,
      String? areaName,
      int? areaId,
      required num minimumOrderAmount,
      required num deliveryFee,
      num? maxDeliveryDiscount}) async {
    emit(const CreateAreaState(isLoading: true));
    final result = await _areaManagementRepository.createArea(
      cityId: cityId,
      areaId: areaId,
      areaName: areaName,
      cityName: cityName,
      maxDeliveryDiscount: maxDeliveryDiscount,
      minimumOrderAmount: minimumOrderAmount,
      deliveryFee: deliveryFee,
    );

    result.fold(
      (left) => emit(CreateAreaState(errorMessage: left.errorMessage)),
      (right) {
        areas.add(right);
        emit(const CreateAreaState(isSuccess: true));
      },
    );
  }

  void editArea({required int id, required num minimumOrderAmount, required num deliveryFee, num? maxDeliveryDiscount}) async {
    emit(const EditAreaState(isLoading: true));
    final result = await _areaManagementRepository.editArea(
        id: id, minimumOrderAmount: minimumOrderAmount, deliveryFee: deliveryFee, maxDeliveryDiscount: maxDeliveryDiscount);

    result.fold(
      (left) => emit(EditAreaState(errorMessage: left.errorMessage)),
      (right) {
        final index = areas.indexWhere((element) => element.id == id);
        areas[index] = areas[index].copyWith(right);
        emit(const EditAreaState(isSuccess: true));
      },
    );
  }

  void deleteArea({required int id}) async {
    emit(const DeleteAreaState(isLoading: true));
    final result = await _areaManagementRepository.deleteArea(areaId: id);

    result.fold(
      (left) => emit(DeleteAreaState(errorMessage: left.errorMessage)),
      (right) {
        areas.removeWhere((element) => element.id == id);

        emit(const DeleteAreaState(isSuccess: true));
      },
    );
  }
}
