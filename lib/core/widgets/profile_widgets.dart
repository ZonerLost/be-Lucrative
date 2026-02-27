import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../modules/profile/model/profile_model.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import 'app_text_styles.dart';

class ProfileSectionTitle extends StatelessWidget {
  final String title;
  const ProfileSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 10),
      child: Text(
        title,
        style: AppTextStyles.body14Regular.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class ProfileHeaderCard extends StatelessWidget {
  final ProfileUserModel user;
  const ProfileHeaderCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: [
              // ================= USER ROW =================
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ExactAvatar(asset: AppAssets.luca),
                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: AppTextStyles.body14Regular.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.email,
                          style: AppTextStyles.body14Regular.copyWith(
                            fontSize: 12.5,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.memberSinceText,
                          style: AppTextStyles.body14Regular.copyWith(
                            fontSize: 12,
                            color: AppColors.textSecondary.withOpacity(0.85),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 16),

              Container(
                height: 1,
                color: const Color(0xFFEDE7E1),
              ),

              const SizedBox(height: 16),

              // ================= STATS =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _ExactMiniStat(
                      value: user.stats.totalSaves.toString(),
                      label: 'Total Saves',
                      bg: AppColors.tileLilac,
                      svg: AppAssets.CalendarBlank,
                      iconColor: AppColors.primaryDark,
                    ),
                  ),
                  Expanded(
                    child: _ExactMiniStat(
                      value: user.stats.bestStreak.toString(),
                      label: 'Best Streak',
                      bg: AppColors.flameBg,
                      svg: AppAssets.fire,
                      iconColor: AppColors.flameIcon,
                    ),
                  ),
                  Expanded(
                    child: _ExactMiniStat(
                      value: 'Stage 1',
                      label: 'Evolution',
                      bg: AppColors.tileYellow,
                      svg: AppAssets.StarFour,
                      iconColor: const Color(0xFFF5B74A),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ================= FLOATING BADGE =================

      ],
    );
  }
}


class ProfileMenuCard extends StatelessWidget {
  final ProfileMenuItemModel item;
  const ProfileMenuCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final destructive = item.isDestructive;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: item.onTap,
        child: Container(
          height: 62,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.035),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              _LeadingIcon(
                svg: item.leadingSvg,
                bg: item.iconBg,
                color: item.iconColor,
              ),
              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppTextStyles.body14Regular.copyWith(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: destructive
                            ? const Color(0xFFE54545)
                            : AppColors.textPrimary,
                      ),
                    ),
                    if (!destructive && item.subtitle.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        item.subtitle,
                        style: AppTextStyles.body14Regular.copyWith(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary.withOpacity(0.75),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              if (!destructive)
                Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: AppColors.textSecondary.withOpacity(0.55),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


class ProfileMenuList extends StatelessWidget {
  final List<ProfileMenuItemModel> items;
  const ProfileMenuList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // ✅ exact side spacing
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10), // ✅ exact vertical gap
      itemBuilder: (_, i) => ProfileMenuCard(item: items[i]),
    );
  }
}

class _ExactAvatar extends StatelessWidget {
  final String asset;
  const _ExactAvatar({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.tileYellow,
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        asset,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ExactMiniStat extends StatelessWidget {
  final String value;
  final String label;
  final Color bg;
  final String svg;
  final Color iconColor;

  const _ExactMiniStat({
    required this.value,
    required this.label,
    required this.bg,
    required this.svg,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: SvgPicture.asset(
              svg,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  final String svg;
  final Color bg;
  final Color color;

  const _LeadingIcon({
    required this.svg,
    required this.bg,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: SvgPicture.asset(
          svg,
          width: 18,
          height: 18,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;
  const LogoutDialog({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: AppColors.tileYellow,
                borderRadius: BorderRadius.circular(22),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                AppAssets.bunny,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Leaving so soon?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Your buddy will miss you! Don't worry your streak\nand XP will be here when you come back.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.8,
                height: 1.35,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary.withOpacity(0.9),
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Stay & Save",
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 48,
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFDAD5CF), width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  onLogout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.SignOut,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
