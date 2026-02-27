import 'package:be_lucrative/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../join_app/controller/join_app_controller.dart';
import '../../join_app/view/join_app_view.dart';

class NameSetupController extends GetxController {
  static const int maxChars = 20;

  final nameCtrl = TextEditingController();
  final nameFocus = FocusNode();

  final RxInt typedLen = 0.obs;
  final RxBool isValid = false.obs;

  String get trimmedName => nameCtrl.text.trim();
  int get remaining => maxChars - typedLen.value;

  void _syncState() {
    final raw = nameCtrl.text;
    typedLen.value = raw.length;

    final trimmed = raw.trim();
    isValid.value = trimmed.isNotEmpty;
  }

  @override
  void onInit() {
    super.onInit();
    nameCtrl.addListener(_syncState);

    // ✅ initial sync (important)
    _syncState();
  }

  void onLetsGo() {
    if (!isValid.value) return;

    if (!Get.isRegistered<JoinAppController>()) {
      Get.put(JoinAppController());
    }
    Get.to(() => const JoinAppView());
  }

  @override
  void onClose() {
    nameCtrl.removeListener(_syncState);
    nameCtrl.dispose();
    nameFocus.dispose();
    super.onClose();
  }
}