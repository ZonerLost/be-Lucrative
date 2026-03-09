import 'package:be_lucrative/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../modules/home_shell/controller/home_shell_controller.dart';
import 'app_text_styles.dart';

double _clamp(double v, double min, double max) {
  if (v < min) return min;
  if (v > max) return max;
  return v;
}

class HomeTabView extends StatelessWidget {
  HomeTabView({super.key});

  final HomeShellController controller = Get.find<HomeShellController>();

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;

    final hPad = _clamp(w * 0.045, 14, 20);
    final topPad = _clamp(w * 0.03, 10, 16);
    final gap = _clamp(w * 0.03, 10, 16);
    final gridRatio = w < 360 ? 1.15 : (w < 420 ? 1.25 : 1.35);

    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(hPad, topPad, hPad, hPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Header(
                  name: "Alex",
                  streak: 15,
                  onSettingsTap: () => Get.snackbar("Settings", "Open settings"),
                ),
                SizedBox(height: gap),

                _LevelRow(
                  levelLabel: "Level 2",
                  xpText: "350 / 500 XP",
                  progress: 0.7,
                ),
                SizedBox(height: gap),

                _BuddyCard(
                  stageText: "Stage 1/3",
                  xpToEvolve: "150 XP until evolution",
                  onSavedTap: () {
                    controller.openSavePopup(xp: 15, streak: 17);
                  },
                ),
                SizedBox(height: gap),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: gridRatio,
                  children: const [
                    _MetricCard(iconPath: AppAssets.fire, title: "Current Streak", value: "15 days"),
                    _MetricCard(iconPath: AppAssets.glowingStar, title: "Total XP", value: "350"),
                    _MetricCard(iconPath: AppAssets.trophy, title: "Best Streak", value: "23 days"),
                    _MetricCard(iconPath: AppAssets.trendUp, title: "Next Milestone", value: "15 days"),
                  ],
                ),

                SizedBox(height: gap),
                const _TipPill(text: "Small savings grow into big dreams"),
              ],
            ),
          ),

          // ✅ POPUP OVERLAY (EnterAmount -> Success)
          Obx(() {
            if (!controller.showSavePopup.value) return const SizedBox.shrink();

            return Positioned.fill(
              child: GestureDetector(
                onTap: controller.closePopup,
                child: Container(
                  color: Colors.black.withOpacity(0.45),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {}, // ✅ prevent closing when tapping dialog
                    child: Obx(() {
                      return controller.popupStep.value == SavePopupStep.enterAmount
                          ? _SaveEnterAmountDialog(controller: controller)
                          : _SaveSuccessDialog(
                        xp: controller.earnedXp.value,
                        streak: controller.streakDays.value,
                      );
                    }),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
class _Header extends StatelessWidget {
  final String name;
  final int streak;
  final VoidCallback onSettingsTap;

  const _Header({
    required this.name,
    required this.streak,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;

    // ✅ responsive but visually same
    final nameSize = _clamp(w * 0.06, 20, 26);
    final morningSize = _clamp(w * 0.036, 12.5, 14.5);
    final fireSize = _clamp(w * 0.05, 18, 22);
    final streakSize = _clamp(w * 0.045, 16, 18);
    final btn = _clamp(w * 0.12, 42, 48);
    final icon = _clamp(w * 0.05, 18, 22);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good morning,",
              style: AppTextStyles.body14Regular.copyWith(
                fontSize: morningSize,
                height: 1.2,
                color: Colors.black.withOpacity(0.45),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  name,
                  style: AppTextStyles.heading24SemiBold.copyWith(
                    fontSize: nameSize,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.2,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.fire,
                      width: fireSize,
                      height: fireSize,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      "$streak",
                      style: AppTextStyles.body14Regular.copyWith(
                        fontSize: streakSize,
                        height: 1,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepOrange.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        InkWell(
          onTap: onSettingsTap,
          borderRadius: BorderRadius.circular(1000),
          child: Container(
            width: btn,
            height: btn,
            decoration: const BoxDecoration(
              color: Color(0xFFE8E5DF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.settingsBlack,
                width: icon,
                height: icon,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LevelRow extends StatelessWidget {
  final String levelLabel;
  final String xpText;
  final double progress;

  const _LevelRow({
    required this.levelLabel,
    required this.xpText,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final p = progress.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              levelLabel,
              style: AppTextStyles.body14Regular.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Text(
              xpText,
              style: AppTextStyles.body14Regular.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.purple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxW = constraints.maxWidth;
            return Container(
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFFE3DED7),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: p),
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutCubic,
                builder: (context, animP, _) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: maxW * animP,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF8B7CF6),
                            Color(0xFF5F4BE8),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                          BoxShadow(
                            color: AppColors.purple.withOpacity(0.30),
                            blurRadius: 18,
                            spreadRadius: 1,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _BuddyCard extends StatelessWidget {
  final String stageText;
  final String xpToEvolve;
  final VoidCallback onSavedTap;

  const _BuddyCard({
    required this.stageText,
    required this.xpToEvolve,
    required this.onSavedTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;

    final box = _clamp(w * 0.30, 105, 128);
    final mascot = _clamp(w * 0.22, 74, 92);
    final btnH = _clamp(w * 0.13, 48, 56);

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF1EFEC),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Text(
                stageText,
                style: AppTextStyles.body14Regular.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.55),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: box,
            height: box,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE7A6),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Center(
              child: Image.asset(
                AppAssets.luca,
                width: mascot,
                height: mascot,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            xpToEvolve,
            style: AppTextStyles.body14Regular.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.55),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: btnH,
            child: ElevatedButton(
              onPressed: onSavedTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.sparkle,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "I Saved Today!",
                    style: AppTextStyles.button16SemiBold.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _SaveEnterAmountDialog extends StatelessWidget {
  final HomeShellController controller;

  const _SaveEnterAmountDialog({required this.controller});

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final cardW = _clamp(w * 0.78, 255, 320);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: cardW,
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 40,
              offset: const Offset(0, 22),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppAssets.luca, // ✅ or your emoji asset
              width: 58,
              height: 58,
            ),
            const SizedBox(height: 10),
            Text(
              "How much you saved today?",
              style: AppTextStyles.body14Regular.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: controller.amountCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "\$  Enter Amount",
                filled: true,
                fillColor: const Color(0xFFF4F1EC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              ),
            ),

            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: controller.submitSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: AppTextStyles.button16SemiBold.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _MetricCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String value;

  const _MetricCard({
    required this.iconPath,
    required this.title,
    required this.value,
  });

  Color _chipBg(String path) {
    if (path == AppAssets.fire) return const Color(0xFFFFEEE3);
    if (path == AppAssets.glowingStar) return const Color(0xFFEEE8FF);
    if (path == AppAssets.trophy) return const Color(0xFFFFF5D8);
    if (path == AppAssets.trendUp) return const Color(0xFFE6F7EC);
    return const Color(0xFFF1F1F1);
  }

  Color _iconColor(String path) {
    if (path == AppAssets.fire) return const Color(0xFFFF6A00);
    if (path == AppAssets.glowingStar) return AppColors.purple;
    if (path == AppAssets.trophy) return const Color(0xFFFFB800);
    if (path == AppAssets.trendUp) return const Color(0xFF16A34A);
    return Colors.black.withOpacity(0.7);
  }

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;

    final pad = w < 360 ? 12.0 : 16.0;
    final chip = w < 360 ? 34.0 : 36.0;
    final icon = w < 360 ? 16.0 : 18.0;

    final chipBg = _chipBg(iconPath);
    final iconColor = _iconColor(iconPath);

    return _SoftCard(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: chip,
            height: chip,
            decoration: BoxDecoration(color: chipBg, shape: BoxShape.circle),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: icon,
                height: icon,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ✅ overflow proof for all devices
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.body14Regular.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.45),
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: AppTextStyles.heading24SemiBold.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                        color: Colors.black.withOpacity(0.92),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipPill extends StatelessWidget {
  final String text;

  const _TipPill({required this.text});

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;

    final vPad = w < 360 ? 12.0 : 14.0;
    final hPad = w < 360 ? 16.0 : 18.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        color: const Color(0xFFEFE6DB),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body14Regular.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.75),
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SvgPicture.asset(
            AppAssets.glowingStar,
            width: 18,
            height: 18,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.75),
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const _SoftCard({
    required this.child,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final r = _clamp(w * 0.055, 18, 24);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(r),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }

}
class _SaveSuccessDialog extends StatelessWidget {
  final int xp;
  final int streak;

  const _SaveSuccessDialog({
    required this.xp,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;

    // ✅ slightly smaller like screenshot
    final cardW = _clamp(w * 0.78, 255, 320);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: cardW,
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26), // ✅ more rounded
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 40,
              offset: const Offset(0, 22),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ icon without background box
            Image.asset(
              AppAssets.partyPopper,
              width: 127,
              height: 80,

            ),

            const SizedBox(height: 5),

            Text(
              "Awesome Save!",
              style: AppTextStyles.heading24SemiBold.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.black.withOpacity(0.92),
              ),
            ),

            const SizedBox(height: 12),

            // ✅ XP pill smaller & rounder
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              decoration: BoxDecoration(
                color: AppColors.purple,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                "+$xp XP",
                style: AppTextStyles.button16SemiBold.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              "$streak day streak! Keep it up!",
              textAlign: TextAlign.center,
              style: AppTextStyles.body14Regular.copyWith(
                fontSize: 11.5, // ✅ smaller like SS
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.45),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}