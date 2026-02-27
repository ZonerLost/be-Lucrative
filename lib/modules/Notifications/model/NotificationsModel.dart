class NotificationsModel {
  final bool motivationalReminders;
  final bool streakAlerts;
  final bool marketingUpdates;

  const NotificationsModel({
    required this.motivationalReminders,
    required this.streakAlerts,
    required this.marketingUpdates,
  });

  NotificationsModel copyWith({
    bool? motivationalReminders,
    bool? streakAlerts,
    bool? marketingUpdates,
  }) {
    return NotificationsModel(
      motivationalReminders: motivationalReminders ?? this.motivationalReminders,
      streakAlerts: streakAlerts ?? this.streakAlerts,
      marketingUpdates: marketingUpdates ?? this.marketingUpdates,
    );
  }
}