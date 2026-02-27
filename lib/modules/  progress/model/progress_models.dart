import '../../../../core/constants/app_assets.dart';

enum MilestoneStatus { done, locked }

class EvolutionStageModel {
  final String label;
  final String imagePng;
  final bool isActive;
  final bool isCompleted;

  const EvolutionStageModel({
    required this.label,
    required this.imagePng,
    required this.isActive,
    required this.isCompleted,
  });

  /// 🔥 Auto-computed getter
  bool get isLocked => !isActive && !isCompleted;
}

class MilestoneModel {
  final String title;
  final String subtitle;
  final String iconSvg; // use AppAssets SVG
  final MilestoneStatus status;

  const MilestoneModel({
    required this.title,
    required this.subtitle,
    required this.iconSvg,
    required this.status,
  });
}

class WeeklyXpModel {
  /// Mon..Sun
  final List<int> values;
  final int thisWeekXp;

  const WeeklyXpModel({
    required this.values,
    required this.thisWeekXp,
  });

  static const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
}

/// ✅ Dummy data helper (optional)
class ProgressDummy {
  static const stages = [
    EvolutionStageModel(
      label: 'Baby',
      imagePng: AppAssets.luca,
      isActive: true,
      isCompleted: false,
    ),
    EvolutionStageModel(
      label: 'Teen',
      imagePng: AppAssets.luca_teen,
      isActive: false,
      isCompleted: false,
    ),
    EvolutionStageModel(
      label: 'Champion',
      imagePng: AppAssets.luca_adult,
      isActive: false,
      isCompleted: false,
    ),
  ];

  static const weekly = WeeklyXpModel(
    values: [220, 260, 120, 380, 240, 310, 520],
    thisWeekXp: 70,
  );

  static const milestones = [
    MilestoneModel(
      title: '5-Day Streak',
      subtitle: '+25 XP Bonus',
      iconSvg: AppAssets.fire,
      status: MilestoneStatus.done,
    ),
    MilestoneModel(
      title: '10-Day Streak',
      subtitle: '+50 XP Bonus',
      iconSvg: AppAssets.green_Sparkle,
      status: MilestoneStatus.done,
    ),
    MilestoneModel(
      title: '30-Day Streak',
      subtitle: '+150 XP Bonus',
      iconSvg: AppAssets.trophy,
      status: MilestoneStatus.locked,
    ),
    MilestoneModel(
      title: '60-Day Streak',
      subtitle: '+350 XP Bonus',
      iconSvg: AppAssets.purple_diamond,
      status: MilestoneStatus.locked,
    ),
  ];
}