part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequestEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginRequestEvent(this.username, this.password);

  @override
  List<Object> get props => [
        username,
        password,
      ];
}

class RegisterMobileRequestEvent extends LoginEvent {
  final String phone;

  const RegisterMobileRequestEvent({required this.phone});

  @override
  List<Object?> get props => [phone ];
}

class RegisterEmailRequestEvent extends LoginEvent {
  final String email;

  const RegisterEmailRequestEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class ForgetPasswordEvent extends LoginEvent {
  final String email;

  const ForgetPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class ResetPasswordEvent extends LoginEvent {
  final String email;
  final String code;
  final String newPassword;

  const ResetPasswordEvent({required this.email, required this.code, required this.newPassword});

  @override
  List<Object?> get props => [email, code, newPassword];
}
