import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/online_ordering/data/models/entity/online_ordering_settings.dart';

import '../../../../injection.dart';
import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../data/models/entity/message_settings.dart';
import '../../data/repository/online_ordering_repository.dart';

part 'online_ordering_state.dart';

@injectable
class OnlineOrderingCubit extends Cubit<OnlineOrderingState> {
  final IOnlineOrderingRepository _onlineOrderingRepository;

  OnlineOrderingCubit(this._onlineOrderingRepository) : super(OnlineOrderingInitial()) {
    getIt<MainScreenBloc>().stream.listen((event) {
      if (event is MerchantInfoSelectionChangedState && event.merchantInfo.hasData) {
        getOnlineOrderingSettings();
      }
    });
  }

  OnlineOrderingSettings? onlineOrderingSettings;

  void getOnlineOrderingSettings() async {
    emit(const GetOnlineOrderingSettingsState(isLoading: true));

    final result = await _onlineOrderingRepository.getOnlineOrderingSettings();

    result.fold((left) => emit(GetOnlineOrderingSettingsState(errorMessage: left.errorMessage)), (right) {
      onlineOrderingSettings = right;
      emit(GetOnlineOrderingSettingsState(settings: right));
    });
  }

  void saveOnlineOrderingSettings({
    required bool onlineOrderingAllowed,
    required bool whatsappOrderingAllowed,
    required String whatsappNumber,
  }) async {
    emit(const LoadingUpdateInfoState(isLoading: true));

    final result = await _onlineOrderingRepository.updateOnlineSettings(
        onlineOrderingAllowed: onlineOrderingAllowed,
        whatsappOrderingAllowed: whatsappOrderingAllowed,
        whatsappNumber: whatsappNumber);

    result.fold((left) => emit(LoadingUpdateInfoState(errorMessage: left.errorMessage)), (right) {
      emit(const LoadingUpdateInfoState(isSuccess: true));
    });
  }

  void getMessagesSettings() async {
    emit(const GetMessagesSettingsState(isLoading: true));

    final result = await _onlineOrderingRepository.getMessagesSetting();

    result.fold((left) => emit(GetMessagesSettingsState(errorMessage: left.errorMessage)), (right) {
      emit(GetMessagesSettingsState(messages: right));
    });
  }

  void saveMessagesSettings({
    required String engMessage,
    required String arMessage,
    required String frMessage,
    required String trMessage,
  }) async {
    emit(const LoadingUpdateInfoState(isLoading: true));

    final result = await _onlineOrderingRepository.updateMessagesSettings(
        engMessage: engMessage, arMessage: arMessage, frMessage: frMessage, trMessage: trMessage);

    result.fold((left) => emit(LoadingUpdateInfoState(errorMessage: left.errorMessage)), (right) {
      emit(const LoadingUpdateInfoState(isSuccess: true));
    });
  }
}
