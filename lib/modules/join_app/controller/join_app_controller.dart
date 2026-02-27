import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../home_shell/binding/home_shell_binding.dart';
import '../../home_shell/view/home_shell_view.dart';
import '../model/user_signup_model.dart';

class JoinAppController extends GetxController {
  // Controllers
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  // Focus
  final emailFocus = FocusNode();
  final passFocus = FocusNode();
  final confirmFocus = FocusNode();

  // UI state
  final RxBool showPass = false.obs;
  final RxBool showConfirm = false.obs;

  // Form validation
  final RxBool isValid = false.obs;

  String get email => emailCtrl.text.trim();
  String get password => passCtrl.text;
  String get confirmPassword => confirmCtrl.text;

  SignupModel get signupData => SignupModel(
    email: email,
    password: password,
  );

  bool _isEmailValid(String value) {
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return regex.hasMatch(value.trim());
  }

  void _sync() {
    final okEmail = _isEmailValid(email);
    final okPass = password.trim().length >= 8;
    final okMatch = password == confirmPassword && confirmPassword.isNotEmpty;

    isValid.value = okEmail && okPass && okMatch;
  }

  @override
  void onInit() {
    super.onInit();

    emailCtrl.addListener(_sync);
    passCtrl.addListener(_sync);
    confirmCtrl.addListener(_sync);

    _sync(); // initial
  }

  void togglePass() => showPass.value = !showPass.value;
  void toggleConfirm() => showConfirm.value = !showConfirm.value;
  void onCreateAccount() {
    if (!isValid.value) return;

    HomeShellBinding().dependencies(); // ✅ inject controller(s)
    Get.offAll(() => const HomeShellView()); // ✅ navigate
  }

  void onLoginTap() {
    Get.offNamed(AppRoutes.login);
    // TODO: navigate to login screen
    //Get.snackbar("Login", "Navigate to login screen");
  }

  @override
  void onClose() {
    emailCtrl.removeListener(_sync);
    passCtrl.removeListener(_sync);
    confirmCtrl.removeListener(_sync);

    emailCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();

    emailFocus.dispose();
    passFocus.dispose();
    confirmFocus.dispose();

    super.onClose();
  }
}