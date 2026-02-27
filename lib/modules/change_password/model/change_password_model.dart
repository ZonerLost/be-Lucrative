class ChangePasswordModel {
  final String current;
  final String newPass;
  final String confirm;
  final bool obscureCurrent;
  final bool obscureNew;
  final bool obscureConfirm;

  const ChangePasswordModel({
    required this.current,
    required this.newPass,
    required this.confirm,
    required this.obscureCurrent,
    required this.obscureNew,
    required this.obscureConfirm,
  });

  ChangePasswordModel copyWith({
    String? current,
    String? newPass,
    String? confirm,
    bool? obscureCurrent,
    bool? obscureNew,
    bool? obscureConfirm,
  }) {
    return ChangePasswordModel(
      current: current ?? this.current,
      newPass: newPass ?? this.newPass,
      confirm: confirm ?? this.confirm,
      obscureCurrent: obscureCurrent ?? this.obscureCurrent,
      obscureNew: obscureNew ?? this.obscureNew,
      obscureConfirm: obscureConfirm ?? this.obscureConfirm,
    );
  }
}