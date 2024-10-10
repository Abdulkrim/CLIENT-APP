part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  const LoginState({this.isLoading = false, this.isSuccess = false, this.errorMessage});

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}

class LoginInitial extends LoginState {}

class LoginRequestState extends LoginState {
  const LoginRequestState({super.isLoading, super.errorMessage, super.isSuccess});
}

class RegisterMobileState extends LoginState {
  const RegisterMobileState({super.isLoading, super.errorMessage, super.isSuccess});
}

class RegisterEmailState extends LoginState {
  const RegisterEmailState({super.isLoading, super.errorMessage, super.isSuccess});
}

class ForgetPasswordState extends LoginState {
  const ForgetPasswordState({super.isLoading, super.errorMessage, super.isSuccess});
}

class ResetPasswordState extends LoginState {
  const ResetPasswordState({super.isLoading, super.errorMessage, super.isSuccess});
}

class RegisterRequestState extends LoginState {
  const RegisterRequestState({super.isLoading, super.errorMessage, super.isSuccess});
}
