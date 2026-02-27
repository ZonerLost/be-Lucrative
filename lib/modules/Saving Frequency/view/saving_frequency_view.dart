import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../controller/saving_frequency_controller.dart';
import '../model/saving_frequency_model.dart';

class SavingFrequencyView extends GetView<SavingFrequencyController> {
  const SavingFrequencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBg,
        elevation: 0,
        centerTitle: false, // ✅
        leadingWidth: 44,   // ✅ tighter like screenshot
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(
            AppAssets.back,
            width: 22,
            height: 22,
          ),
        ),
        titleSpacing: 0, // ✅ title right next to back
        title: const Text(
          "Saving Frequency",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Obx(() {
        final selected = controller.selected.value;

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          children: [

            /// Description
            Text(
              "Choose how often you want to save.\nChanging frequency will reset your current streak.",
              style: TextStyle(
                fontSize: 14,
                height: 1.35,
                color: AppColors.textSecondary.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            ...controller.options.map((o) {
              final isSelected = selected == o.type;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _Tile(
                  option: o,
                  selected: isSelected,
                  onTap: () => controller.selectOption(o.type),
                ),
              );
            }),

            const SizedBox(height: 8),

            /// Warning Box
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFEFEAE4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.flameColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Heads up: Changing your saving frequency will reset your current streak. Your total XP and history will be preserved.",
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.35,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _Tile extends StatelessWidget {
  final SavingFrequencyOption option;
  final bool selected;
  final VoidCallback onTap;

  const _Tile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.rhythmDaily
                : const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected
                  ? AppColors.purple
                  : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadowSoft,
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [

              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFFFFFFF) // warm beige for selected
                      : const Color(0xFFFFFFFF), // light grey for unselected
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    option.leadingSvg,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      selected
                          ? AppColors.flameColor
                          : AppColors.primaryDark,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              /// Text Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          option.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14.5,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),

                        /// Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8E6E3),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            option.badgeText,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      option.description,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        color: AppColors.textSecondary.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              /// Right Tick
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.purple
                      : const Color(0xFFDAD5CF),
                  shape: BoxShape.circle,
                ),
                child: selected
                    ? const Icon(Icons.check,
                    size: 14, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}