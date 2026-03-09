import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../  progress/controller/progress_controller.dart';

enum SavePopupStep { enterAmount, success }

class HomeShellController extends GetxController {
  final RxInt index = 0.obs;
  void setIndex(int i) => index.value = i;

  final RxBool showSavePopup = false.obs;

  final RxInt earnedXp = 15.obs;
  final RxInt streakDays = 17.obs;

  final Rx<SavePopupStep> popupStep = SavePopupStep.enterAmount.obs;

  final TextEditingController amountCtrl = TextEditingController();

  void openSavePopup({required int xp, required int streak}) {
    earnedXp.value = xp;
    streakDays.value = streak;

    popupStep.value = SavePopupStep.enterAmount;
    amountCtrl.clear();

    showSavePopup.value = true;
  }

  void submitSave() {
    final txt = amountCtrl.text.trim();
    final amount = double.tryParse(txt);

    if (amount == null || amount <= 0) {
      Get.snackbar("Invalid amount", "Please enter a valid amount");
      return;
    }

    // ✅ here you can update progress controller if needed
    // Get.find<ProgressController>().addSaving(amount);

    popupStep.value = SavePopupStep.success;
  }

  void closePopup() {
    showSavePopup.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    if (!Get.isRegistered<ProgressController>()) {
      Get.put(ProgressController(), permanent: true);
    }
  }

  @override
  void onClose() {
    amountCtrl.dispose();
    super.onClose();
  }
}