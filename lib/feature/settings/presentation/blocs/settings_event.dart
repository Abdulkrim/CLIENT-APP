part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class UpdateOptionalParameters extends SettingsEvent {
  final List<({String id, String value})> param;
  final bool hasLoading;

  const UpdateOptionalParameters(this.param ): hasLoading = true;
  const UpdateOptionalParameters.onToggleChange(this.param ): hasLoading = false;

  @override
  List<Object> get props => [param];
}

class AddPaymentModeEvent extends SettingsEvent {
  final String name;
  final bool canHaveRefrence;

  const AddPaymentModeEvent(this.name, this.canHaveRefrence);

  @override
  List<Object> get props => [name, canHaveRefrence];
}

class GetOptionalParameters extends SettingsEvent {
  const GetOptionalParameters();
}

class GetBranchTaxValue extends SettingsEvent {
  const GetBranchTaxValue();
}

class GetAllPaymentTypes extends SettingsEvent {
  const GetAllPaymentTypes();
}

class UpdateDiscountValue extends SettingsEvent {
  final int discountType;
  final num discountValue;

  const UpdateDiscountValue({required this.discountType, required this.discountValue});

  @override
  List<Object> get props => [discountType, discountValue];
}


class UpdatePaymentSettings extends SettingsEvent {
  final List<int> payments;
  final int claimAllowed;
  final bool customerAllowed;
  final int taxID;
  final bool taxAllowed;
  final int taxTypeId;
  final int trn;

  const UpdatePaymentSettings(
      {required this.payments,
      required this.claimAllowed,
      required this.customerAllowed,
      required this.taxID,
      required this.taxAllowed,
      required this.taxTypeId,
      required this.trn});
}

class GetBranchPaymentSettings extends SettingsEvent {
  const GetBranchPaymentSettings();
}
