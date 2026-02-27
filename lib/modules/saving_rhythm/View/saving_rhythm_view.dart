import 'package:be_lucrative/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_styles.dart';
import '../../../core/widgets/saving_rhythm_widgets.dart';
import '../Controller/saving_rhythm_controller.dart';

// make sure your extension file is imported
// import 'path/to/build_context_extension.dart';

class SavingRhythmView extends StatelessWidget {
  const SavingRhythmView({super.key});

  @override
  Widget build(BuildContext context) {
    final SavingRhythmController c = Get.find<SavingRhythmController>();

    final w = context.screenWidth;
    final h = context.screenHeight;

    double sw(double v) => (w / 375.0) * v;
    double sh(double v) => (h / 812.0) * v;

    double clamp(double v, double min, double max) =>
        v < min ? min : (v > max ? max : v);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4EF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: clamp(sw(18), 14, 24),
            vertical: clamp(sh(10), 8, 16),
          ),
          child: Column(
            children: [
              // ✅ Back
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(clamp(sw(10), 8, 12)),
                    child: Padding(
                      padding: EdgeInsets.all(clamp(sw(8), 6, 10)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.back,
                            width: clamp(sw(18), 16, 20),
                            height: clamp(sw(18), 16, 20),
                          ),
                          SizedBox(width: clamp(sw(8), 6, 10)),
                          Text(
                            AppStrings.back,
                            style: AppTextStyles.body14Regular.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: clamp(sh(10), 8, 14)),

              // ✅ Buddy Avatar
              Obx(() {
                final buddy = c.selectedBuddy.value;

                return SizedBox(
                  width: clamp(sw(84), 72, 96),
                  height: clamp(sw(84), 72, 96),
                  child: Center(
                    child: Image.asset(
                      buddy?.avatarAsset ?? AppAssets.luca,
                      width: clamp(sw(100), 84, 110),
                      height: clamp(sw(100), 84, 110),
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              }),

              SizedBox(height: clamp(sh(14), 10, 18)),

              Text(
                'Set Your Saving Rhythm',
                style: AppTextStyles.heading24SemiBold.copyWith(
                  color: Colors.black.withOpacity(0.85),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: clamp(sh(6), 4, 8)),

              Text(
                'How often will you save?',
                style: AppTextStyles.body14Regular.copyWith(
                  color: Colors.black.withOpacity(0.55),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: clamp(sh(16), 12, 20)),

              // ✅ Tiles
              Expanded(
                child: Obx(() {
                  final list = c.items;

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: list.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: clamp(sh(12), 10, 14)),
                    itemBuilder: (_, i) {
                      final item = list[i];

                      return Obx(() {
                        final selected = c.selectedId.value == item.id;

                        return RhythmOptionTile(
                          item: item,
                          selected: selected,
                          onTap: () => c.selectRhythm(item.id),
                        );
                      });
                    },
                  );
                }),
              ),

              SizedBox(height: clamp(sh(14), 10, 18)),

              // ✅ Continue Button
              Obx(() {
                final enabled = c.selectedId.value != null;

                return PrimaryActionButton(
                  title: AppStrings.continueText,
                  enabled: enabled,
                  icon: Icons.arrow_forward_ios,
                  onPressed: c.onContinue,
                );
              }),

              // bottom spacer (keyboard safe-ish)
              SizedBox(height: clamp(sh(130), 90, 160)),
            ],
          ),
        ),
      ),
    );
  }
}