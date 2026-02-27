import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/controller/profile_controller.dart';
import '../../profile/model/profile_model.dart';
import '../model/edit_profile.dart';

class EditProfileController extends GetxController {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  final isSaving = false.obs;
  final form = const EditProfileModel(name: '', email: '').obs;

  late final ProfileController profileController;

  @override
  void onInit() {
    super.onInit();
    profileController = Get.find<ProfileController>();

    final u = profileController.user.value;
    form.value = EditProfileModel.fromUser(name: u.name, email: u.email);

    nameCtrl.text = form.value.name;
    emailCtrl.text = form.value.email;
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    super.onClose();
  }

  bool _isEmailValid(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email.trim());
  }

  void save() async {
    final name = nameCtrl.text.trim();
    final email = emailCtrl.text.trim();

    if (name.isEmpty) {
      Get.snackbar('Validation', 'Please enter your name');
      return;
    }
    if (!_isEmailValid(email)) {
      Get.snackbar('Validation', 'Please enter a valid email');
      return;
    }

    isSaving.value = true;

    final current = profileController.user.value;

    // ✅ No copyWith: rebuild object using constructor
    final updated = ProfileUserModel(
      name: name,
      email: email,
      memberSinceText: current.memberSinceText,
      avatarAsset: current.avatarAsset,
      stats: current.stats,
    );

    profileController.user.value = updated;

    isSaving.value = false;
    Get.back();
    Get.snackbar('Saved', 'Profile updated successfully');
  }
}