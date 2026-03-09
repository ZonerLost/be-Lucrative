import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../../core/constants/app_colors.dart';
import '../../../../extension/extension.dart';
import '../../modules/  progress/model/progress_models.dart';
import '../constants/app_assets.dart';
import 'app_text_styles.dart';

double _clamp(double v, double min, double max) {
  if (v < min) return min;
  if (v > max) return max;
  return v;
}

/* =======================
   SECTION TITLE
======================= */
class ProgressSectionTitle extends StatelessWidget {
  final String iconSvg;
  final String title;

  const ProgressSectionTitle({
    super.key,
    required this.iconSvg,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final icon = _clamp(w * 0.045, 16, 18);

    return Row(
      children: [
        SvgPicture.asset(
          iconSvg,
          width: icon,
          height: icon,
          colorFilter: ColorFilter.mode(
            AppColors.textPrimary.withOpacity(0.75), // ✅ replaced
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTextStyles.body14Regular.copyWith(
            fontSize: _clamp(w * 0.038, 12.5, 14),
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary.withOpacity(0.75), // ✅ replaced
          ),
        ),
      ],
    );
  }
}

/* =======================
   SOFT CARD
======================= */
class ProgressSoftCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const ProgressSoftCard({
    super.key,
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
            color: AppColors.cardShadowSoft, // ✅ replaced
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
class TotalSavedThisWeekCard extends StatelessWidget {
  final int amount; // e.g. 120
  final int days;   // e.g. 6
  final int totalDays; // 7

  const TotalSavedThisWeekCard({
    super.key,
    required this.amount,
    required this.days,
    this.totalDays = 7,
  });

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;

    final leftChip = _clamp(w * 0.12, 44, 50);
    final r = _clamp(w * 0.060, 20, 24);

    return Row(
      children: [
        // Left $ chip
        Container(
          width: leftChip,
          height: leftChip,
          decoration: BoxDecoration(
            color: const Color(0xFFF1EFFF), // subtle purple tint like SS
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              "\$",
              style: AppTextStyles.heading24SemiBold.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.progressFill, // purple
              ),
            ),
          ),
        ),

        const SizedBox(width: 14),

        // Amount + subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\$$amount",
                style: AppTextStyles.heading24SemiBold.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary.withOpacity(0.92),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                "$days days streak",
                style: AppTextStyles.body14Regular.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary.withOpacity(0.45),
                ),
              ),
            ],
          ),
        ),

        // Right ratio badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F1EC),
            borderRadius: BorderRadius.circular(r),
          ),
          child: Text(
            "$days/$totalDays",
            style: AppTextStyles.body14Regular.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary.withOpacity(0.55),
            ),
          ),
        ),
      ],
    );
  }
}
/* =======================
   EVOLUTION JOURNEY
======================= */

class EvolutionJourneySection extends StatelessWidget {
  final List<EvolutionStageModel> stages;

  final String progressLeftLabel; // e.g. "Progress to Teen"
  final String progressRightLabel; // e.g. "350 / 500 XP"
  final double progress; // 0..1

  const EvolutionJourneySection({
    super.key,
    required this.stages,
    required this.progressLeftLabel,
    required this.progressRightLabel,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final titleSize = _clamp(w * 0.040, 14, 16);
    final titleIcon = _clamp(w * 0.050, 18, 20);
    final cardRadius = _clamp(w * 0.040, 16, 20);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row (⭐ Evolution Journey)
        Row(
          children: [
            Icon(
              Icons.star_border_rounded,
              size: titleIcon,
              color: AppColors.evoStarPurple, // ✅ replaced
            ),
            const SizedBox(width: 8),
            Text(
              "Evolution Journey",
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary.withOpacity(0.90), // ✅ replaced
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // White rounded card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(_clamp(w * 0.040, 14, 18)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(cardRadius),
            boxShadow: [
              const BoxShadow(
                color: AppColors.cardShadowSoft, // ✅ replaced
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              EvolutionJourneyRow(stages: stages),
              const SizedBox(height: 14),
              LabeledProgressBar(
                leftLabel: progressLeftLabel,
                rightLabel: progressRightLabel,
                progress: progress,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/* =======================
   EVOLUTION JOURNEY ROW
======================= */
class EvolutionJourneyRow extends StatelessWidget {
  final List<EvolutionStageModel> stages;

  const EvolutionJourneyRow({
    super.key,
    required this.stages,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final avatar = _clamp(w * 0.18, 58, 66);
    final inner = _clamp(w * 0.13, 42, 50);
    final labelSize = _clamp(w * 0.032, 11, 12.5);
    final chevronSize = _clamp(w * 0.055, 18, 20);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < stages.length; i++) ...[
          Expanded(
            child: Column(
              children: [
                _EvolutionAvatar(
                  size: avatar,
                  innerSize: inner,
                  imagePng: stages[i].imagePng,
                  isActive: stages[i].isActive,
                  isLocked: stages[i].isLocked,
                ),
                const SizedBox(height: 8),
                Text(
                  stages[i].label,
                  style: TextStyle(
                    fontSize: labelSize,
                    fontWeight: stages[i].isActive ? FontWeight.w700 : FontWeight.w500,
                    color: AppColors.textPrimary.withOpacity(stages[i].isActive ? 0.85 : 0.45), // ✅ replaced
                  ),
                ),
              ],
            ),
          ),
          if (i != stages.length - 1)
            Padding(
              padding: EdgeInsets.only(
                top: _clamp(w * 0.060, 16, 20),
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                size: chevronSize,
                color: AppColors.textPrimary.withOpacity(0.25), // ✅ replaced
              ),
            ),
        ],
      ],
    );
  }
}

class _EvolutionAvatar extends StatelessWidget {
  final double size;
  final double innerSize;
  final String imagePng;
  final bool isActive;
  final bool isLocked;

  const _EvolutionAvatar({
    required this.size,
    required this.innerSize,
    required this.imagePng,
    required this.isActive,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    // screenshot-like colors (✅ replaced with AppColors)
    final bg = isActive ? AppColors.evoActiveBg : AppColors.evoInactiveBg;
    final border = isActive ? AppColors.evoActiveBorder : AppColors.evoInactiveBorder;

    final r = _clamp(size * 0.35, 18, 22);
    final innerR = _clamp(innerSize * 0.35, 14, 18);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(r),
            border: Border.all(color: border, width: isActive ? 2 : 1),
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(innerR),
              child: Image.asset(
                imagePng,
                width: innerSize,
                height: innerSize,
                fit: BoxFit.cover,
                color: isActive ? null : AppColors.textPrimary.withOpacity(0.35), // ✅ replaced
                colorBlendMode: isActive ? null : BlendMode.saturation,
              ),
            ),
          ),
        ),

        // Active bottom orange badge (✅ replaced)
        if (isActive)
          Positioned(
            bottom: -_clamp(size * 0.06, 3, 4),
            child: Container(
              width: _clamp(size * 0.24, 14, 16),
              height: _clamp(size * 0.24, 14, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.evoActiveBorder, width: 2),
              ),
              child: Center(
                child: Container(
                  width: _clamp(size * 0.10, 6, 7),
                  height: _clamp(size * 0.10, 6, 7),
                  decoration: BoxDecoration(
                    color: AppColors.evoActiveBorder,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),

        // Locked bottom badge (✅ replaced)
        if (!isActive && isLocked)
          Positioned(
            bottom: -_clamp(size * 0.06, 3, 4),
            child: Container(
              width: _clamp(size * 0.24, 14, 16),
              height: _clamp(size * 0.24, 14, 16),
              decoration: BoxDecoration(
                color: AppColors.evoLockBadgeBg,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.evoLockBadgeBorder, width: 1),
              ),
              child: Icon(
                Icons.lock_rounded,
                size: _clamp(size * 0.14, 9, 10),
                color: AppColors.textPrimary.withOpacity(0.35), // ✅ replaced
              ),
            ),
          ),
      ],
    );
  }
}

/* =======================
   LABELED PROGRESS BAR
======================= */
class LabeledProgressBar extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;
  final double progress;

  const LabeledProgressBar({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
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
              leftLabel,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.progressLabelGrey, // ✅ replaced
              ),
            ),
            Text(
              rightLabel,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.progressFill, // ✅ replaced
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxW = constraints.maxWidth;

              return Container(
                height: 10,
                width: double.infinity,
                color: AppColors.progressTrack, // ✅ replaced
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: p),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  builder: (context, value, _) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: maxW * value,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.progressFill, // ✅ replaced
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/* =======================
   WEEKLY XP CHART
======================= */
class WeeklyXpChart extends StatelessWidget {
  final WeeklyXpModel data;

  const WeeklyXpChart({
    super.key,
    required this.data,
  });

  // Create "nice" max and ticks (e.g. 0, 200, 400, 600, 800)
  List<int> _buildTicks(int maxValue) {
    if (maxValue <= 0) return const [0];

    // target ~6 ticks like screenshot
    const targetTicks = 6;

    // pick a nice step (1,2,5 * 10^n)
    int niceStep(int rawStep) {
      final pow10 = _pow10(rawStep);
      final n = rawStep / pow10;
      if (n <= 1) return 1 * pow10;
      if (n <= 2) return 2 * pow10;
      if (n <= 5) return 5 * pow10;
      return 10 * pow10;
    }

    final rawStep = (maxValue / (targetTicks - 1)).ceil();
    final step = niceStep(rawStep);

    final niceMax = ((maxValue + step - 1) ~/ step) * step;

    // build ticks top -> bottom
    final ticks = <int>[];
    for (int v = niceMax; v >= 0; v -= step) {
      ticks.add(v);
    }

    // ensure at least 2 ticks
    if (ticks.length < 2) {
      ticks.insert(0, niceMax);
      ticks.add(0);
    }
    return ticks;
  }

  int _pow10(int n) {
    int p = 1;
    while (n >= 10) {
      n ~/= 10;
      p *= 10;
    }
    return p;
  }

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;

    final values = data.values.take(7).toList();
    final maxV = values.isEmpty ? 1 : values.reduce((a, b) => a > b ? a : b);

    final ticks = _buildTicks(maxV);
    final topTick = ticks.isEmpty ? 1 : ticks.first;

    final chartH = _clamp(w * 0.44, 150, 175);
    final barsAreaH = chartH - 6;

    final barW = _clamp((w - 140) / 12, 12, 18);
    final axisW = 40.0;

    return Column(
      children: [
        SizedBox(
          height: chartH,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Y axis
              SizedBox(
                width: axisW,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ticks.map((t) {
                    return Text(
                      '$t',
                      style: AppTextStyles.body14Regular.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary.withOpacity(0.35),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 10),

              // Bars
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(values.length, (i) {
                      final v = values[i];
                      final usableH = (barsAreaH - 22);
                      final h = (v / (topTick == 0 ? 1 : topTick)) * usableH;

                      return SizedBox(
                        width: barW + 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: barW,
                              height: h < 2 ? 2 : h,
                              decoration: BoxDecoration(
                                color: AppColors.progressFill,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              WeeklyXpModel.days[i],
                              style: AppTextStyles.body14Regular.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary.withOpacity(0.40),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // Bottom summary
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${data.thisWeekXp} XP',
              style: AppTextStyles.body14Regular.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary.withOpacity(0.92),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'this week',
              style: AppTextStyles.body14Regular.copyWith(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary.withOpacity(0.40),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
/* =======================
   MILESTONE TILE
======================= */
class MilestoneTile extends StatelessWidget {
  final MilestoneModel milestone;

  const MilestoneTile({
    super.key,
    required this.milestone,
  });

  bool get _isDone => milestone.status == MilestoneStatus.done;

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;

    final pad = _clamp(w * 0.045, 16, 20);
    final r = _clamp(w * 0.065, 20, 24);
    final chipSize = _clamp(w * 0.12, 44, 50);
    final iconSize = _clamp(w * 0.05, 18, 22);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: pad * 0.85),
      decoration: BoxDecoration(
        color: _isDone
            ? AppColors.milestoneDoneBg // #D8F3E0
            : AppColors.milestoneLockedBg, // #FFFFFF
        borderRadius: BorderRadius.circular(r),
        border: Border.all(
          color: AppColors.milestoneBorder,
        ),
      ),
      child: Row(
        children: [
          // LEFT ICON CHIP
          Container(
            width: chipSize,
            height: chipSize,
            decoration: BoxDecoration(
              color: _isDone
                  ? Colors.white.withOpacity(0.6)
                  : AppColors.milestoneLockedChipBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: SvgPicture.asset(
                milestone.iconSvg,
                width: iconSize,
                height: iconSize,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // TITLE + SUBTITLE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  milestone.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  milestone.subtitle,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // RIGHT SIDE STATUS
          if (_isDone)
            Row(
              children: [
                Icon(
                  Icons.check,
                  size: 18,
                  color: AppColors.milestoneDoneGreen, // #2BA650
                ),
                const SizedBox(width: 6),
                Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.milestoneDoneGreen, // #2BA650
                  ),
                ),
              ],
            )
          else
            Icon(
              Icons.lock_outline,
              size: 18,
              color: AppColors.milestoneLockedIcon,
            ),
        ],
      ),
    );
  }
}