import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/loyalty/data/repository/loyalty_point_repository.dart';

import '../../../data/models/entity/loyalty_settings.dart';

part 'loyalty_settings_state.dart';

@injectable
class LoyaltySettingsCubit extends Cubit<LoyaltySettingsState> {
  final ILoyaltyPointRepository _loyaltyRepository;

  LoyaltySettingsCubit(this._loyaltyRepository) : super(LoyaltySettingsInitial());

  LoyaltySettings? loyaltySettings;

  void getLoyaltySettings() async {
    emit(const GetLoyaltySettingsState(isLoading: true));
    final result = await _loyaltyRepository.getLoyaltySettings();

    result.fold((left) => emit(GetLoyaltySettingsState(errorMessage: left.errorMessage)), (right) {
      loyaltySettings = right;
      emit(const GetLoyaltySettingsState(isSuccess: true));
    });
  }

  void manageLoyaltySettings(
      {required bool loyaltyAllowed,
      required bool isSplitAllowed,
      required num rechargePoint,
      required num redeemPoint,
      required num expireDuration,
      required num remainedDaysToExpirePointToNotifyCustomer,
      required num maxExpiringPointToNotifyCustomer,
      required num maxPercent}) async {
    emit(const ManageLoyaltySettingsState(isLoading: true));
    final result = await _loyaltyRepository.manageLoyaltySettings(
        loyaltyAllowed: loyaltyAllowed,
        isSplitAllowed: isSplitAllowed,
        rechargePoint: rechargePoint,
        redeemPoint: redeemPoint,
        expireDuration: expireDuration,
        remainedDaysToExpirePointToNotifyCustomer: remainedDaysToExpirePointToNotifyCustomer,
        maxExpiringPointToNotifyCustomer: maxExpiringPointToNotifyCustomer,
        maxPercent: maxPercent);

    result.fold((left) => emit(ManageLoyaltySettingsState(errorMessage: left.errorMessage)), (right) {
      emit(const ManageLoyaltySettingsState(isSuccess: true));
    });
  }
}
