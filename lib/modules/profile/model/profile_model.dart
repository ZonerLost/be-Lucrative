import 'dart:ui';

class ProfileStatsModel {
  final int totalSaves;
  final int bestStreak;
  final String stageLabel;

  const ProfileStatsModel({
    required this.totalSaves,
    required this.bestStreak,
    required this.stageLabel,
  });
}

class ProfileUserModel {
  final String name;
  final String email;
  final String memberSinceText;
  final String avatarAsset; // PNG

  final ProfileStatsModel stats;

  const ProfileUserModel({
    required this.name,
    required this.email,
    required this.memberSinceText,
    required this.avatarAsset,
    required this.stats,
  });
}

class ProfileMenuItemModel {
  final String title;
  final String subtitle;
  final String leadingSvg;
  final VoidCallback onTap;
  final bool isDestructive;


  final Color iconBg;
  final Color iconColor;

  const ProfileMenuItemModel({
    required this.title,
    required this.subtitle,
    required this.leadingSvg,
    required this.onTap,
    this.isDestructive = false,
    required this.iconBg,
    required this.iconColor,
  });
}