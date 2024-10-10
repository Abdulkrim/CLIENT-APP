import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../my_account/data/repository/account_details_repository.dart';

part 'privacy_state.dart';

@injectable
class PrivacyCubit extends Cubit<PrivacyState> {
  final IAccountDetailsRepository _accountDetailsRepository;

  PrivacyCubit(this._accountDetailsRepository) : super(PrivacyInitial());

  void sendDeletionEmail(String userEmail) async {
    emit(const SendEmailState(isLoading: true));

    final result = await _accountDetailsRepository.sendDeletionEmail(userEmail);

    result.fold((left) => emit(SendEmailState(errorMessage: left.errorMessage)),
        (right) => emit(const SendEmailState(isSuccess: true)));
  }

  void verifyDeletionOtp(String otpCode) async {
    emit(const VerifyEmailState(isLoading: true));

    final result = await _accountDetailsRepository.verifyDeletionOtp(otpCode);

    result.fold((left) => emit(VerifyEmailState(errorMessage: left.errorMessage)),
        (right) => emit(const VerifyEmailState(isSuccess: true)));
  }
}
