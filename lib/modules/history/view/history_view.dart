import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/history_controller.dart';
import '../../../core/widgets/history_calendar_view.dart';
import '../../../core/widgets/history_widgets.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ put only once here
    final controller = Get.put(HistoryController());

    return Scaffold(
      backgroundColor: const Color(0xFFF6F2EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F2EE),
        elevation: 0,
        title: const Text(
          'History',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1B1A),
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Column(
          children: [
            const HistorySegmentedTabs(),
            const SizedBox(height: 14),
            Expanded(
              child: Obx(() {
                return controller.tabIndex.value == 0
                    ? const HistoryTimelineList()
                    : const HistoryCalendarView();
              }),
            ),
          ],
        ),
      ),
    );
  }
}