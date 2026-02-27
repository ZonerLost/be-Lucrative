import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  final emailFocus = FocusNode();
  final passFocus = FocusNode();

  final RxBool showPass = false.obs;
  final RxBool isValid = false.obs;

  String get email => emailCtrl.text.trim();
  String get password => passCtrl.text;

  LoginModel get loginData => LoginModel(email: email, password: password);

  bool _isEmailValid(String value) {
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return regex.hasMatch(value.trim());
  }

  void _sync() {
    final okEmail = _isEmailValid(email);
    final okPass = password.trim().isNotEmpty; // you can enforce >=8 if you want
    isValid.value = okEmail && okPass;
  }

  @override
  void onInit() {
    super.onInit();
    emailCtrl.addListener(_sync);
    passCtrl.addListener(_sync);
    _sync();
  }

  void togglePass() => showPass.value = !showPass.value;

  void onLogin() {
    if (!isValid.value) return;

    final data = loginData;
    // TODO: API login
    Get.snackbar("Logged In", data.email);
  }

  void onForgotPassword() {
    // TODO: forgot password screen
    Get.snackbar("Forgot Password", "Navigate to reset screen");
  }

  void onSignUpTap() {
    // back to join/signup
    Get.toNamed(AppRoutes.join);
  }

  @override
  void onClose() {
    emailCtrl.removeListener(_sync);
    passCtrl.removeListener(_sync);

    emailCtrl.dispose();
    passCtrl.dispose();

    emailFocus.dispose();
    passFocus.dispose();
    super.onClose();
  }
}