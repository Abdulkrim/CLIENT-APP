class LoginRequestParameter {
  final String username;
  final String password;

  LoginRequestParameter({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
