import 'package:get/get.dart';

import '../model/NotificationsModel.dart';

class NotificationsController extends GetxController {
  final state = const NotificationsModel(
    motivationalReminders: true,
    streakAlerts: true,
    marketingUpdates: false,
  ).obs;

  void toggleMotivation(bool v) =>
      state.value = state.value.copyWith(motivationalReminders: v);

  void toggleStreak(bool v) =>
      state.value = state.value.copyWith(streakAlerts: v);

  void toggleMarketing(bool v) =>
      state.value = state.value.copyWith(marketingUpdates: v);
}