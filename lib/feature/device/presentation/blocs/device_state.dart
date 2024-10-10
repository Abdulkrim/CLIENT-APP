part of 'device_cubit.dart';

sealed class DeviceState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const DeviceState({this.isLoading = false, this.errorMessage, this.isSuccess = false});

  @override
  List<Object?> get props => [isLoading, errorMessage, isSuccess];
}

final class DeviceInitial extends DeviceState {}

final class CheckHasDeviceStates extends DeviceState {
  const CheckHasDeviceStates({super.isLoading, super.errorMessage, super.isSuccess});
}

class UpdateOptionalParamsState extends DeviceState {
  const UpdateOptionalParamsState({super.isLoading = false, super.isSuccess = false, super.errorMessage});
}

class GetOptionalParamsStates extends DeviceState {
  const GetOptionalParamsStates({super.isLoading = false, super.isSuccess = false, super.errorMessage});
}

class GetPOSSettingsState extends DeviceState {
  final POSSettings? posSettings;
  const GetPOSSettingsState({super.isLoading = false, this.posSettings, super.errorMessage});

  @override
  List<Object?> get props => [posSettings];
}

class UpdatePOSSettingsState extends DeviceState {
  const UpdatePOSSettingsState({super.isLoading = false, super.isSuccess = false, super.errorMessage});
}
