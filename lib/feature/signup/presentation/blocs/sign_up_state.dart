part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  const SignUpState({this.isLoading = false, this.isSuccess = false, this.error});

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}

class SignUpInitial extends SignUpState {}

class GetAllBusinessTypesDataSuccessState extends SignUpState {
  const GetAllBusinessTypesDataSuccessState();
}

class CreateBranchStates extends SignUpState {
  const CreateBranchStates({super.isLoading, super.isSuccess, super.error});
}

class ValidateBusinessNameState extends SignUpState {
  const ValidateBusinessNameState({super.isLoading, super.isSuccess, super.error});
}

class ValidateBusinessDomainState extends SignUpState {
  const ValidateBusinessDomainState({super.isLoading, super.isSuccess, super.error});
}

class SaveSetupDataState extends SignUpState {
  const SaveSetupDataState({super.isLoading, super.isSuccess, super.error});
}
