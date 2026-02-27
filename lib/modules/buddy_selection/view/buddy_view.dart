import 'package:be_lucrative/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_button.dart';
import '../controller/buddy_controller.dart';



class BuddyView extends GetView<BuddyController> {
  const BuddyView({super.key});

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final h = context.screenHeight;

    final paddingX = (w * 0.08).clamp(16.0, 40.0);
    final titleSize = ((w < h ? w : h) * 0.065).clamp(22.0, 30.0);
    final subSize = ((w < h ? w : h) * 0.035).clamp(12.0, 16.0);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingX),
          child: Column(
            children: [


              Image.asset(
                AppAssets.partyPopper,
                width: 127,
                height: 80,

              ),
              SizedBox(height: (h * 0.02).clamp(10.0, 16.0)),

              Text(
                'Meet Your\nLucrative Buddies!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'InterTight',
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1.15,
                ),
              ),

              SizedBox(height: (h * 0.012).clamp(6.0, 10.0)),

              Text(
                'Choose a companion for your savings journey',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'InterTight',
                  fontSize: subSize,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),

              SizedBox(height: (h * 0.03).clamp(14.0, 22.0)),

              // grid (dynamic)
              Expanded(
                child: Obx(() {
                  final items = controller.buddies;

                  // ✅ 3 columns on normal screens, 4 on big screens
                  final crossAxisCount = w >= 900 ? 4 : 3;

                  // ✅ spacing
                  const crossSpacing = 14.0;
                  const mainSpacing = 14.0;

                  // ✅ dynamic tile size based on available width
                  final totalSpacing = (crossAxisCount - 1) * crossSpacing;
                  final tileSize =
                  ((w - (paddingX * 2) - totalSpacing) / crossAxisCount).clamp(80.0, 110.0);

                  // ✅ calculate height so no overflow happens
                  const nameGap = 6.0;
                  const nameHeight = 18.0; // approx for 12.5 font
                  final tileHeight = tileSize + nameGap + nameHeight;

                  // ✅ aspect ratio = width / height
                  final childAspectRatio = tileSize / tileHeight;

                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: crossSpacing,
                      mainAxisSpacing: mainSpacing,
                      childAspectRatio: childAspectRatio, // ✅ fixes overflow
                    ),
                    itemBuilder: (_, i) {
                      final b = items[i];

                      return Obx(() {
                        final selected = controller.selectedBuddyId.value == b.id;

                        return GestureDetector(
                          onTap: () => controller.selectBuddy(b.id),
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                width: tileSize,
                                height: tileSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  border: selected
                                      ? Border.all(
                                    color: b.bgColor,
                                    width: 2.5,
                                  )
                                      : null,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    b.avatarAsset,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              const SizedBox(height: nameGap),

                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 180),
                                style: TextStyle(
                                  fontFamily: 'InterTight',
                                  fontSize: 12.5,
                                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                                  color: selected ? AppColors.textPrimary : AppColors.textSecondary,
                                ),
                                child: Text(
                                  b.name,
                                  maxLines: 1, // ✅ prevents height increase
                                  overflow: TextOverflow.ellipsis, // ✅ avoids overflow
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                    },
                  );
                }),
              ),


               // small spacing only

              // 🔹 Button
              Obx(() {
                final enabled = controller.selectedBuddyId.value != null;

                return PrimaryActionButton(
                  title: AppStrings.selectYourBuddy,
                  enabled: enabled,
                  icon: Icons.arrow_forward_ios,
                  onPressed: controller.onContinue,
                );
              }),
              const SizedBox(height: 240), // bottom spacing (optional)

            ],
          ),
        ),
      ),
    );
  }
}
