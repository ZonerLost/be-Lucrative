class SignupModel {
  final String email;
  final String password;

  const SignupModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}