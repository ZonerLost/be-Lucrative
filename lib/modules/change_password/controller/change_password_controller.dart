import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/change_password_model.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final state = const ChangePasswordModel(
    current: '',
    newPass: '',
    confirm: '',
    obscureCurrent: true,
    obscureNew: true,
    obscureConfirm: true,
  ).obs;

  void setCurrent(String v) => state.value = state.value.copyWith(current: v);
  void setNew(String v) => state.value = state.value.copyWith(newPass: v);
  void setConfirm(String v) => state.value = state.value.copyWith(confirm: v);

  void toggleCurrent() =>
      state.value = state.value.copyWith(obscureCurrent: !state.value.obscureCurrent);

  void toggleNew() =>
      state.value = state.value.copyWith(obscureNew: !state.value.obscureNew);

  void toggleConfirm() =>
      state.value = state.value.copyWith(obscureConfirm: !state.value.obscureConfirm);

  void submit() {
    final ok = formKey.currentState?.validate() ?? false;
    if (!ok) return;

    if (state.value.newPass != state.value.confirm) {
      Get.snackbar('Error', 'New password and confirm password do not match.');
      return;
    }

    // TODO: call API
    Get.snackbar('Success', 'Password updated successfully.');
    Get.back();
  }
}