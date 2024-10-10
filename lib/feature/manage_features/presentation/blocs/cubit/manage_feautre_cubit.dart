import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/manage_features/data/models/entity/user_plan_feature.dart';
import 'package:merchant_dashboard/feature/manage_features/data/repository/manage_features_repository.dart';

part 'manage_feautre_state.dart';

@singleton
class ManageFeautreCubit extends Cubit<ManageFeautreState> {
  final IManageFeaturesRepository _manageFeaturesRepository;

  ManageFeautreCubit(this._manageFeaturesRepository) : super(ManageFeautreInitial());

  List<UserPlanFeature> userPlanFeautres = [];

  bool isFeatureEnable(String appFeatureKey) =>
      _manageFeaturesRepository.isFeatureEnable(appFeatureKey, userPlanFeautres);

  void getUserCurrentPlanFeatures() async {
    emit(const GetUserPlanFeaturesState(isLoading: true));

    final result = await _manageFeaturesRepository.getUserPlanFeatures();

    result.fold((left) => emit(GetUserPlanFeaturesState(errorMessage: left.errorMessage)), (right) {
      userPlanFeautres = right;
      emit(const GetUserPlanFeaturesState(isSuccessed: true));
    });
  }
}
