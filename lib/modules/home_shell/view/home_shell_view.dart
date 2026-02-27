import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:be_lucrative/extension/extension.dart'; // ✅ only this for context.screenWidth/Height

import '../../  progress/controller/progress_controller.dart';
import '../../  progress/view/progress_view.dart';
import '../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../core/widgets/home_tab_view.dart';
import '../../history/controller/history_controller.dart';
import '../../history/view/history_view.dart';
import '../../profile/controller/profile_controller.dart';
import '../../profile/view/profile_view.dart';
import '../controller/home_shell_controller.dart';

class HomeShellView extends GetView<HomeShellController> {
  const HomeShellView({super.key});

  @override
  Widget build(BuildContext context) {
    // (optional) use if needed later:
    // final w = context.screenWidth;
    // final h = context.screenHeight;

    final pages = [
       HomeTabView(),
      GetBuilder<ProgressController>(
        init: ProgressController(),
        builder: (_) => const ProgressView(),
      ),
      GetBuilder<HistoryController>(
        init: HistoryController(),
        builder: (_) => const HistoryScreen(),
      ),
      GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (_) => const ProfileView(),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4EF),
      extendBody: true,
      body: Obx(() => IndexedStack(
        index: controller.index.value,
        children: pages,
      )),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: controller.index,
        onChanged: controller.setIndex,
      ),
    );
  }
}