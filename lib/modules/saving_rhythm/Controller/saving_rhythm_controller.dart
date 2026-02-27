import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../Model/saving_rhythm_model.dart';

import '../../buddy_selection/Model/buddy_model.dart';

class SavingRhythmController extends GetxController {
  final RxList<SavingRhythmModel> items = <SavingRhythmModel>[].obs;
  final RxnString selectedId = RxnString();

  // ✅ ADD THIS (Buddy)
  final Rxn<BuddyModel> selectedBuddy = Rxn<BuddyModel>();

  @override
  void onInit() {
    super.onInit();

    // ✅ Get buddy from previous screen
    final arg = Get.arguments;
    if (arg is BuddyModel) {
      selectedBuddy.value = arg;
    }

    // ✅ Keep order fixed: Daily, Weekly, Bi-weekly, Monthly
    final defaults = _defaultRhythms()
      ..sort((a, b) => a.order.compareTo(b.order));

    items.assignAll(defaults);
  }

  void selectRhythm(String id) {
    print('Tapped rhythm: $id');
    selectedId.value = id;
  }

  List<SavingRhythmModel> _defaultRhythms() => [
    SavingRhythmModel(
      id: 'daily',
      title: 'Daily',
      badge: 'Challenge mode',
      subtitle: 'Save every day for maximum XP gains',
      iconAsset: '',
      order: 1,
      bgColorValue: AppColors.rhythmDaily.value,
    ),
    SavingRhythmModel(
      id: 'weekly',
      title: 'Weekly',
      badge: 'Balanced',
      subtitle: 'Perfect pace for busy schedules',
      iconAsset: '',
      order: 2,
      bgColorValue: AppColors.rhythmWeekly.value,
    ),
    SavingRhythmModel(
      id: 'biweekly',
      title: 'Bi-weekly',
      badge: 'Relaxed',
      subtitle: 'Steady progress, less pressure',
      iconAsset: '',
      order: 3,
      bgColorValue: AppColors.rhythmBiWeekly.value,
    ),
    SavingRhythmModel(
      id: 'monthly',
      title: 'Monthly',
      badge: 'Easy start',
      subtitle: 'Great for building the habit slowly',
      iconAsset: '',
      order: 4,
      bgColorValue: AppColors.rhythmMonthly.value,
    ),
  ];

  void onContinue() {
    if (selectedId.value == null) {
      Get.snackbar(
        'Select rhythm',
        'Please choose a saving rhythm to continue.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    print("Navigating to Name Page...");

    Get.toNamed(
      AppRoutes.nameSetup,
      arguments: {
        'rhythmId': selectedId.value,
      },
    );
  }
}