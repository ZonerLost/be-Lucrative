import 'package:get/get.dart';

import '../model/progress_models.dart';

class ProgressController extends GetxController {
  final RxString title = 'Progress'.obs;

  final RxList<EvolutionStageModel> stages = <EvolutionStageModel>[].obs;
  final RxDouble journeyProgress = 0.7.obs; // 0..1
  final RxString progressLeft = 'Progress to Teen'.obs;
  final RxString progressRight = '350 / 500 XP'.obs;

  final Rx<WeeklyXpModel> weeklyXp =
      const WeeklyXpModel(values: [0, 0, 0, 0, 0, 0, 0], thisWeekXp: 0).obs;

  final RxInt totalSavedThisWeek = 120.obs; // example
  final RxInt savingsStreakDays = 6.obs;    // example (6/7)
  final RxList<MilestoneModel> milestones = <MilestoneModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    stages.assignAll(ProgressDummy.stages);
    weeklyXp.value = ProgressDummy.weekly;
    milestones.assignAll(ProgressDummy.milestones);
  }
}