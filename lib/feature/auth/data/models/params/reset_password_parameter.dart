class ResetPasswordParameter {
  final String email;
  final String code;
  final String password;

  ResetPasswordParameter({
    required this.email,
    required this.code,
    required this.password,
  });

  Map<String, dynamic> toJson() => {"email": email, "code": code, "password": password};
}
