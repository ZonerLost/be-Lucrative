class HistoryEntryModel {
  final DateTime date;
  final int xp;
  final int day;
  final String note;
  final bool isStreak;

  // ✅ make it nullable-safe in runtime (hot reload issues)
  final String? amountLabel;

  HistoryEntryModel({
    required this.date,
    required this.xp,
    required this.day,
    required this.note,
    required this.isStreak,
    required this.amountLabel,
  });

  String get xpLabel => '+$xp XP';
  String get dayLabel => 'Day $day';

  // ✅ NEW getter (never crashes)
  String get moneyLabel => amountLabel ?? '\$9';
}