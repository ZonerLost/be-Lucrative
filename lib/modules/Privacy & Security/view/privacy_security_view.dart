import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../change_password/view/change_password_view.dart';
import '../controller/privacy_security_controller.dart';

class PrivacySecurityView extends GetView<PrivacySecurityController> {
  const PrivacySecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBg,
        elevation: 0,
        centerTitle: false,
        leadingWidth: 44,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(AppAssets.back, width: 22, height: 22),
        ),
        titleSpacing: 0,
        title: const Text(
          "Privacy & Security",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.5,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          _SettingsCard(
            iconBg: AppColors.tileLilac,
            iconColor: AppColors.purple,
            title: "Change Password",
            subtitle: "Update your account password",
            leading: SvgPicture.asset(
              AppAssets.lock,
              width: 18,
              height: 18,
              colorFilter:
              const ColorFilter.mode(AppColors.purple, BlendMode.srcIn),
            ),
            onTap: () => Get.to(() => const ChangePasswordView()),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.only(left: 2, bottom: 8),
            child: Text(
              "DANGER ZONE",
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF9A948D),
                letterSpacing: 0.6,
              ),
            ),
          ),
          _SettingsCard(
            iconBg: const Color(0xFFFCE9EA),
            iconColor: AppColors.logoutColor,
            title: "Delete Account",
            subtitle: "Permanently remove all data",
            leading: const Icon(
              Icons.delete_outline_rounded,
              size: 20,
              color: AppColors.logoutColor,
            ),
            onTap: () => controller.showDeleteDialog(),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget leading;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SettingsCard({
    required this.leading,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadowSoft,
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: leading),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: isDestructive
                            ? AppColors.logoutColor
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 22,
                color: AppColors.textSecondary.withOpacity(0.45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}