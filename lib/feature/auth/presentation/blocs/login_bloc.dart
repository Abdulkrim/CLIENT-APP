import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:merchant_dashboard/core/notifications/pushy_service.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/auth/data/models/entities/user_data.dart';
import 'package:merchant_dashboard/feature/auth/data/models/params/login_request_parameter.dart';
import 'package:merchant_dashboard/feature/auth/data/repository/login_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

@Singleton()
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ILoginRepository _loginRepository;

  ({String userId, String password})? registeredPhone;

  LoginBloc(this._loginRepository) : super(LoginInitial()) {
    on<LoginRequestEvent>((event, emit) async {
      emit(const LoginRequestState(isLoading: true));

      final Either<Failure, UserData> loginResult = await _loginRepository.loginUserThroughUserName(LoginRequestParameter(
        username: event.username,
        password: event.password,
      ));

      loginResult.fold((left) => emit(LoginRequestState(errorMessage: left.errorMessage)), (right) {
        if (!kIsWeb) PushyService.pushySubscribeToOrderManagementTopic(right.branchID);
        emit(const LoginRequestState(isSuccess: true));
      });
    });

    on<RegisterMobileRequestEvent>((event, emit) async {
      emit(const RegisterMobileState(isLoading: true));

      final loginResult = await _loginRepository.registerMobile(phoneNumber: event.phone);

      loginResult.fold((left) async {
        emit(RegisterMobileState(errorMessage: left.errorMessage));
      }, (right) async {
        registeredPhone = right;
        emit(const RegisterMobileState(isSuccess: true));
      });
    });

    on<RegisterEmailRequestEvent>((event, emit) async {
      emit(const RegisterEmailState(isLoading: true));

      final loginResult = await _loginRepository.registerEmail(
          email: event.email, userId: registeredPhone!.userId, password: registeredPhone!.password);

      loginResult.fold((left) async {
        emit(RegisterEmailState(errorMessage: left.errorMessage));
      }, (right) async {
        emit(const RegisterEmailState(isSuccess: true));
      });
    });

    on<ForgetPasswordEvent>((event, emit) async {
      emit(const ForgetPasswordState(isLoading: true));
      final result = await _loginRepository.forgetPassword(event.email);

      result.fold((left) => emit(ForgetPasswordState(errorMessage: left.errorMessage)),
          (right) => emit(const ForgetPasswordState(isSuccess: true)));
    });
    on<ResetPasswordEvent>((event, emit) async {
      emit(const ResetPasswordState(isLoading: true));
      final result = await _loginRepository.resetPassword(email: event.email, code: event.code, newPassword: event.newPassword);

      result.fold((left) => emit(ResetPasswordState(errorMessage: left.errorMessage)),
          (right) => emit(const ResetPasswordState(isSuccess: true)));
    });
  }
}
