import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../extension/extension.dart';
import '../../../core/widgets/ProgressSectionTitle.dart';
import '../../../core/widgets/app_text_styles.dart';
import '../controller/progress_controller.dart';
import '../../../../core/constants/app_assets.dart';

class ProgressView extends GetView<ProgressController> {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;

    // ✅ simple responsive ratios
    final hPad = w * 0.05;
    final topPad = w * 0.04;
    final gap = w * 0.05;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(hPad, topPad, hPad, hPad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() => Text(
              controller.title.value,
              style: AppTextStyles.heading24SemiBold.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.black.withOpacity(0.92),
              ),
            )),

            SizedBox(height: gap),

            // Evolution Journey
            const ProgressSectionTitle(
              iconSvg: AppAssets.glowingStar,
              title: 'Evolution Journey',
            ),

            SizedBox(height: w * 0.03),

            ProgressSoftCard(
              padding: EdgeInsets.all(w * 0.04),
              child: Column(
                children: [
                  Obx(() => EvolutionJourneyRow(
                    stages: controller.stages.toList(),
                  )),
                  SizedBox(height: w * 0.04),
                  Obx(() => LabeledProgressBar(
                    leftLabel: controller.progressLeft.value,
                    rightLabel: controller.progressRight.value,
                    progress: controller.journeyProgress.value,
                  )),
                ],
              ),
            ),

            SizedBox(height: gap),

            // ✅ NEW: Total Saved This Week (ADD THIS BLOCK)
            const ProgressSectionTitle(
              iconSvg: AppAssets.glowingStar, // you can change icon if you have $
              title: "Total Saved This Week",
            ),

            SizedBox(height: w * 0.03),

            ProgressSoftCard(
              padding: EdgeInsets.all(w * 0.04),
              child: Obx(() => TotalSavedThisWeekCard(
                amount: controller.totalSavedThisWeek.value,
                days: controller.savingsStreakDays.value,
              )),
            ),

            SizedBox(height: gap),

            // Milestones
            const ProgressSectionTitle(
              iconSvg: AppAssets.fire,
              title: 'Streak Milestones',
            ),

            SizedBox(height: w * 0.03),

            Obx(() => Column(
              children: [
                for (final m in controller.milestones) ...[
                  MilestoneTile(milestone: m),
                  SizedBox(height: w * 0.03),
                ],
              ],
            )),
          ],
        ),
      ),
    );
  }
}