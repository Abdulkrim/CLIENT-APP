part of 'privacy_cubit.dart';

sealed class PrivacyState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  const PrivacyState({this.isLoading = false, this.isSuccess = false, this.errorMessage});

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}

final class PrivacyInitial extends PrivacyState {}

final class SendEmailState extends PrivacyState {
  const SendEmailState({super.isLoading, super.isSuccess, super.errorMessage});
}

final class VerifyEmailState extends PrivacyState {
  const VerifyEmailState({super.isLoading, super.isSuccess, super.errorMessage});
}
