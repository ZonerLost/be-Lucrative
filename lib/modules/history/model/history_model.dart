class HistoryEntryModel {
  final DateTime date;
  final int xp;
  final int day;
  final String note;
  final bool isStreak;

  HistoryEntryModel({
    required this.date,
    required this.xp,
    required this.day,
    required this.note,
    required this.isStreak,
  });

  String get xpLabel => '+$xp XP';
  String get dayLabel => 'Day $day';
}