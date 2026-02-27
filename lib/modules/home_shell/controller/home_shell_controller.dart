import 'package:get/get.dart';
import '../../  progress/controller/progress_controller.dart';

class HomeShellController extends GetxController {
  final RxInt index = 0.obs;
  void setIndex(int i) => index.value = i;

  final RxBool showSavePopup = false.obs;
  final RxInt earnedXp = 15.obs;
  final RxInt streakDays = 17.obs;

  void triggerSavePopup({required int xp, required int streak}) {
    earnedXp.value = xp;
    streakDays.value = streak;
    showSavePopup.value = true;
  }

  void closePopup() => showSavePopup.value = false;

  @override
  void onInit() {
    super.onInit();

    // ✅ register ProgressController
    if (!Get.isRegistered<ProgressController>()) {
      Get.put(ProgressController(), permanent: true);
    }
  }
}