import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/notifications_controller..dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Obx(() {
        final s = controller.state.value;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: const Text('Motivational reminders'),
              value: s.motivationalReminders,
              onChanged: controller.toggleMotivation,
            ),
            SwitchListTile(
              title: const Text('Streak alerts'),
              value: s.streakAlerts,
              onChanged: controller.toggleStreak,
            ),
            SwitchListTile(
              title: const Text('Product updates'),
              value: s.marketingUpdates,
              onChanged: controller.toggleMarketing,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('Done'),
              ),
            ),
          ],
        );
      }),
    );
  }
}