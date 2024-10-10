import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/device/data/models/entity/pos_settings.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/injection.dart';

import '../../data/models/entity/optional_param_keys.dart';
import '../../data/repository/device_repository.dart';

part 'device_state.dart';

@injectable
class DeviceCubit extends Cubit<DeviceState> {
  final IDeviceRepository _deviceRepository;

  POSSettings? posSettings;

  DeviceCubit(this._deviceRepository) : super(DeviceInitial()) {
    getIt<MainScreenBloc>().stream.listen((event) {
      if (event is MerchantInfoSelectionChangedState && event.merchantInfo.hasData) {
        hasDevice = true;
        checkBranchHasDevice();
        getPOSsettings();
      }
    });
  }

  bool hasDevice = false;

  checkBranchHasDevice() async {
    emit(const CheckHasDeviceStates(isLoading: true));
    final result = await _deviceRepository.checkHasPos();

    result.fold(
      (left) => hasDevice = false,
      (right) => hasDevice = right,
    );
    emit(const CheckHasDeviceStates(isSuccess: true));
  }

  getPOSsettings() async {
    emit(const GetPOSSettingsState(isLoading: true));
    final result = await _deviceRepository.getPOSSetting();

    result.fold((left) => emit(GetPOSSettingsState(errorMessage: left.errorMessage)), (right) {
      posSettings = right;
      emit(GetPOSSettingsState(posSettings: right));
    });
  }

  updatePOSSettings(
      {required bool printAllowed,
      required String footerMessage,
      required bool rePrint,
      required int queueAllowed,
      required XFile? footerLogo,
      required XFile? printingLogo,
      required int discountAllowed,
      required int merchantCopy,
      required int posTrxFromPOS ,required int posOrderFromPOS}) async {
    emit(const UpdatePOSSettingsState(isLoading: true));
    final result = await _deviceRepository.updatePOSSettings(
      printAllowed: printAllowed,
      footerMessage: footerMessage,
      rePrint: rePrint,
      merchantCopy: merchantCopy,
      discountAllowed: discountAllowed,
      footerLogo: footerLogo,
      printingLogo: printingLogo,
      queueAllowed: queueAllowed,
      posTrxFromPOS: posTrxFromPOS,
      posOrderFromPOS: posOrderFromPOS,

    );

    result.fold((left) => emit(UpdatePOSSettingsState(errorMessage: left.errorMessage)),
        (right) => emit(const UpdatePOSSettingsState(isSuccess: true)));
  }

  getOptionalParams() async {
    emit(const GetOptionalParamsStates(isLoading: true));

    final result = await _deviceRepository.getOptionalParameters();

    result.fold((left) => emit(GetOptionalParamsStates(errorMessage: left.errorMessage)), (right) {

      emit(const GetOptionalParamsStates(isSuccess: true));
    });
  }

  /*updateOptionalParams(List<({String id, String value})> param) async {
    emit(const UpdateOptionalParamsState(isLoading: true));
    final result = await _deviceRepository.updateOptionalParameters(param);

    result.fold((left) => emit(UpdateOptionalParamsState(errorMessage: left.errorMessage)),
        (right) => emit(const UpdateOptionalParamsState(isSuccess: true)));
  }*/
}
