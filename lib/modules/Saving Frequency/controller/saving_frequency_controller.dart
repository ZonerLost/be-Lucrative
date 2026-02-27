import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../model/saving_frequency_model.dart';

class SavingFrequencyController extends GetxController {
  final selected = SavingFrequencyType.daily.obs;

  // ✅ initialize immediately (no late)
  final RxList<SavingFrequencyOption> options = <SavingFrequencyOption>[].obs;

  @override
  void onInit() {
    super.onInit();

    options.assignAll(const <SavingFrequencyOption>[
      SavingFrequencyOption(
        type: SavingFrequencyType.daily,
        title: 'Daily',
        badgeText: 'Challenge mode',
        description:
        'Save every day for maximum XP gains.\nStreak resets on XP miss.',
        leadingSvg: AppAssets.fire,
        tileBg: AppColors.rhythmDaily,
        accent: AppColors.rhythmDailyAccent,
      ),
      SavingFrequencyOption(
        type: SavingFrequencyType.weekly,
        title: 'Weekly',
        badgeText: 'Balanced',
        description:
        'Perfect pace for busy schedules. 24h grace\nperiod on misses.',
        leadingSvg: AppAssets.Bell,
        tileBg: AppColors.rhythmWeekly,
        accent: AppColors.rhythmWeeklyAccent,
      ),
      SavingFrequencyOption(
        type: SavingFrequencyType.biWeekly,
        title: 'Bi-weekly',
        badgeText: 'Relaxed',
        description: 'Perfect for paycheck-based saving schedules.',
        leadingSvg: AppAssets.Bell,
        tileBg: AppColors.rhythmBiWeekly,
        accent: AppColors.rhythmBiWeeklyAccent,
      ),
      SavingFrequencyOption(
        type: SavingFrequencyType.monthly,
        title: 'Monthly',
        badgeText: 'Easy start',
        description:
        'Great for building the habit, slowly.\nIncrease anytime!',
        leadingSvg: AppAssets.CalendarBlank,
        tileBg: AppColors.rhythmMonthly,
        accent: AppColors.rhythmMonthlyAccent,
      ),
    ]);
  }

  void selectOption(SavingFrequencyType type) => selected.value = type;
}