import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  final user = const ProfileUserModel(
    name: 'Alex',
    email: 'alex@example.com',
    memberSinceText: 'Member since January 2025',
    avatarAsset: AppAssets.bunny,
    stats: ProfileStatsModel(
      totalSaves: 15,
      bestStreak: 23,
      stageLabel: 'Stage 1\nEvolution',
    ),
  ).obs;

  late final RxList<ProfileMenuItemModel> items;

  @override
  void onInit() {
    super.onInit();

    items = <ProfileMenuItemModel>[
      ProfileMenuItemModel(
        title: 'Edit Profile',
        subtitle: 'Update name & email',
        leadingSvg: AppAssets.EnvelopeSimple, // apna suitable svg
        onTap: () => Get.toNamed(AppRoutes.editProfile),
        iconBg: const Color(0xFFEAF6EE),
        iconColor: const Color(0xFF2E9B64),
      ),
      ProfileMenuItemModel(
        title: 'Saving Frequency',
        subtitle: 'Daily',
        leadingSvg: AppAssets.fire,
        onTap: () => Get.toNamed(AppRoutes.savingFrequency),
        iconBg: const Color(0xFFFFEFE6),
        iconColor: const Color(0xFFF57C38),
      ),
      ProfileMenuItemModel(
        title: 'Notifications',
        subtitle: 'Motivational reminders',
        leadingSvg: AppAssets.Bell,
        onTap: () => Get.toNamed(AppRoutes.notifications),
        iconBg: const Color(0xFFECF0FD),
        iconColor: const Color(0xFF4C6FFF),
      ),
      ProfileMenuItemModel(
        title: 'Privacy & Security',
        subtitle: 'Password, data settings',
        leadingSvg: AppAssets.Shield,
        onTap: () => Get.toNamed(AppRoutes.privacySecurity),
        iconBg: const Color(0xFFEAF6EE),
        iconColor: const Color(0xFF2E9B64),
      ),
      ProfileMenuItemModel(
        title: 'Help & FAQ',
        subtitle: 'Questions, support',
        leadingSvg: AppAssets.help,
        onTap: () => Get.toNamed(AppRoutes.helpFaq),
        iconBg: const Color(0xFFF1F0FF),
        iconColor: const Color(0xFF6B63FF),
      ),

      /// ✅ UPDATED LOGOUT
      ProfileMenuItemModel(
        title: 'Logout',
        subtitle: '',
        leadingSvg: AppAssets.SignOut,
        onTap: showLogoutDialog, // 🔥 updated here
        isDestructive: true,
        iconBg: const Color(0xFFFCE9EA),
        iconColor: const Color(0xFFE54545),
      ),
    ].obs;
  }

  /// 🔥 Logout Dialog (Screenshot Style)
  void showLogoutDialog() {
    Get.dialog(
      barrierColor: Colors.black.withOpacity(0.45),
      Dialog(
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
              /// Bunny Image
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: AppColors.tileYellow,
                  borderRadius: BorderRadius.circular(22),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  AppAssets.luca,
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
                "Your buddy will miss you! Don't worry your streak and XP will be here when you come back.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.35,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 18),

              /// Stay Button
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
                  onPressed: () => Get.back(),
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

              /// Logout Outline Button
              SizedBox(
                height: 48,
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Color(0xFFDAD5CF), width: 1.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    Get.snackbar("Logout", "Logout flow will be added.");
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
      ),
    );
  }
}