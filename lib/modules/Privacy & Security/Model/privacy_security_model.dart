class PrivacySecurityModel {
  final bool biometricLock;
  final bool hideEmail;
  final bool analyticsSharing;

  const PrivacySecurityModel({
    required this.biometricLock,
    required this.hideEmail,
    required this.analyticsSharing,
  });

  PrivacySecurityModel copyWith({
    bool? biometricLock,
    bool? hideEmail,
    bool? analyticsSharing,
  }) {
    return PrivacySecurityModel(
      biometricLock: biometricLock ?? this.biometricLock,
      hideEmail: hideEmail ?? this.hideEmail,
      analyticsSharing: analyticsSharing ?? this.analyticsSharing,
    );
  }
}