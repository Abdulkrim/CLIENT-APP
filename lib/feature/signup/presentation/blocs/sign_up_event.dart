part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}


class ValidateBusinessName extends SignUpEvent {
  final String businessName;
  final bool isReset;

  const ValidateBusinessName(this.businessName) : isReset = false;

  const ValidateBusinessName.reset()
      : businessName = '',
        isReset = true;

  @override
  List<Object> get props => [businessName, isReset];
}

class ValidateBusinessDomain extends SignUpEvent {
  final String businessDomain;
  final bool isReset;

  const ValidateBusinessDomain(this.businessDomain) : isReset = false;

  const ValidateBusinessDomain.reset()
      : businessDomain = '',
        isReset = true;

  @override
  List<Object> get props => [businessDomain, isReset];
}

class GetAllBusinessTypesEvent extends SignUpEvent {
  const GetAllBusinessTypesEvent();
}


class SaveSetupGuideData extends SignUpEvent {
  const SaveSetupGuideData();
}


class CreateBranchEvent extends SignUpEvent {
  final String name;
  final String phoneNumber;
  final String email;
  final String branchAddress;
  final String domainText;
  final int? selectedCityId;
  final int businessTypeId;

  final String cityName;
  final int countryId;

  const CreateBranchEvent({
    required this.domainText,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.branchAddress,
    required this.selectedCityId,
    required this.businessTypeId,
    required this.cityName,
    required this.countryId,
  });

  @override
  List<Object?> get props =>
      [name, phoneNumber, email, branchAddress, domainText, selectedCityId, businessTypeId, cityName, countryId];
}