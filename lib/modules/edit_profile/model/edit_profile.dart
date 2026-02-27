class EditProfileModel {
  final String name;
  final String email;

  const EditProfileModel({
    required this.name,
    required this.email,
  });

  factory EditProfileModel.fromUser({
    required String name,
    required String email,
  }) {
    return EditProfileModel(name: name, email: email);
  }

  EditProfileModel copyWith({
    String? name,
    String? email,
  }) {
    return EditProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}