class RegisterRequestParameter {
  final String phoneNumber;
  final String email;
  final String userId;
  final String password;

  RegisterRequestParameter.mobileRegistration({required this.phoneNumber})
      : email = '',
        userId = '',
        password = '';

  RegisterRequestParameter.emailRegistration({required this.email, required this.userId, required this.password})
      : phoneNumber = '';

  Map<String, dynamic> mobileStepToJson() => {'phoneNumber': phoneNumber};

  Map<String, dynamic> emailStepToJson() => {
        'email': email,
        'userId': userId,
        'password': password,
      };
}
