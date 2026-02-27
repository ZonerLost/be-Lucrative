import 'package:flutter/material.dart';

enum SavingFrequencyType { daily, weekly, biWeekly, monthly }

class SavingFrequencyOption {
  final SavingFrequencyType type;

  final String title;
  final String badgeText;
  final String description;

  final String leadingSvg; // use AppAssets.*
  final Color tileBg;      // use AppColors.rhythm*
  final Color accent;      // use AppColors.rhythm*Accent

  const SavingFrequencyOption({
    required this.type,
    required this.title,
    required this.badgeText,
    required this.description,
    required this.leadingSvg,
    required this.tileBg,
    required this.accent,
  });
}