import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/profile_widgets.dart';
import '../controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          child: Obx(() {
            final user = controller.user.value;
            final items = controller.items;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileSectionTitle(title: 'Profile'),
                ProfileHeaderCard(user: user),
                const SizedBox(height: 14),

                // Menu list
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => ProfileMenuCard(item: items[i]),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}