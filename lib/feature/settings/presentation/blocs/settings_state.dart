part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  const SettingsState({this.isLoading = false, this.isSuccess = false, this.error});

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}

class SettingsInitial extends SettingsState {}

class GetParamsStates extends SettingsState {
  const GetParamsStates({super.isLoading = false, super.isSuccess = false, super.error});
}


class UpdateOptionalParamsState extends SettingsState {
  const UpdateOptionalParamsState({super.isLoading = false, super.isSuccess = false, super.error});
}


class AddPaymentModeState extends SettingsState {
  const AddPaymentModeState({super.isLoading = false, super.isSuccess = false, super.error});
}

class UpdateDiscountValueStates extends SettingsState {
  const UpdateDiscountValueStates({super.isLoading = false, super.isSuccess = false, super.error});

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}

class SaveParametersStates extends SettingsState {
  const SaveParametersStates({super.isLoading = false, super.isSuccess = false, super.error});

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}

class UpdatePaymentSettingsState extends SettingsState {
  const UpdatePaymentSettingsState({super.isLoading = false, super.isSuccess = false, super.error});

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}

class GetBranchParametersState extends SettingsState {
  final BranchParameters? parameters;

  const GetBranchParametersState({super.isLoading = false, this.parameters, super.error});

  @override
  List<Object?> get props => [isLoading, parameters, error];
}

class GetPaymentSettingsState extends SettingsState {
  final PaymentSettings? parameters;

  const GetPaymentSettingsState({super.isLoading = false, this.parameters, super.error});

  @override
  List<Object?> get props => [isLoading, parameters, error];
}

class GetBranchTaxValueStates extends SettingsState {
  final Tax? tax;

  const GetBranchTaxValueStates({super.isLoading = false, this.tax, super.error});

  @override
  List<Object?> get props => [isLoading, tax, error];
}



class GetPaymentTypesStates extends SettingsState {
  const GetPaymentTypesStates({super.isLoading = false, super.isSuccess = false, super.error});
}

class GetBusinessDefaultParameterValueState extends SettingsState {
  const GetBusinessDefaultParameterValueState(
      {super.isLoading = false, super.isSuccess = false, super.error});
}
