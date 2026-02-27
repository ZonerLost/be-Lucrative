class NameSetupModel {
  final String name;
  final String? buddyAvatarAsset; // optional

  const NameSetupModel({
    required this.name,
    this.buddyAvatarAsset,
  });

  NameSetupModel copyWith({
    String? name,
    String? buddyAvatarAsset,
  }) {
    return NameSetupModel(
      name: name ?? this.name,
      buddyAvatarAsset: buddyAvatarAsset ?? this.buddyAvatarAsset,
    );
  }
}