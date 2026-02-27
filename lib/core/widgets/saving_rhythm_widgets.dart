import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../modules/saving_rhythm/Model/saving_rhythm_model.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import 'app_text_styles.dart';

class RhythmOptionTile extends StatelessWidget {
  final SavingRhythmModel item;
  final bool selected;
  final VoidCallback onTap;

  const RhythmOptionTile({
    super.key,
    required this.item,
    required this.selected,
    required this.onTap,
  });

  String _iconFor(String id) {
    switch (id) {
      case 'daily':
        return AppAssets.fire;
      case 'weekly':
        return AppAssets.purpleShine;
      case 'biweekly':
        return AppAssets.Moon;
      case 'monthly':
        return AppAssets.Leaf;
      default:
        return AppAssets.fire;
    }
  }

  Color _bgFor(String id) {
    switch (id) {
      case 'daily':
        return AppColors.rhythmDaily;
      case 'weekly':
        return AppColors.rhythmWeekly;
      case 'biweekly':
        return AppColors.rhythmBiWeekly;
      case 'monthly':
        return AppColors.rhythmMonthly;
      default:
        return AppColors.rhythmDaily;
    }
  }

  // ✅ Strong border accents (NOT same as bg)
  Color _accentFor(String id) {
    switch (id) {
      case 'daily':
        return AppColors.rhythmDailyAccent;
      case 'weekly':
        return AppColors.rhythmWeeklyAccent;
      case 'biweekly':
        return AppColors.rhythmBiWeeklyAccent;
      case 'monthly':
        return AppColors.rhythmMonthlyAccent;
      default:
        return AppColors.rhythmDailyAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bg = _bgFor(item.id);
    final accent = _accentFor(item.id);
    final iconPath = _iconFor(item.id);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? accent : Colors.transparent,
              width: 1.8,
            ),
          ),
          child: Row(
            children: [
              _IconBadge(asset: iconPath),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item.title,
                          style: AppTextStyles.body14Regular.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _Pill(text: item.badge),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body14Regular.copyWith(
                        fontSize: 12,
                        color: AppColors.textPrimary.withOpacity(0.55),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final String asset;
  const _IconBadge({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: SvgPicture.asset(asset, width: 20, height: 20),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  const _Pill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: AppTextStyles.body14Regular.copyWith(
          fontSize: 11,
          height: 1.0,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary.withOpacity(0.55),
        ),
      ),
    );
  }
}