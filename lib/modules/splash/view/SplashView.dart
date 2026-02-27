import 'package:be_lucrative/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_text_styles.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.buddySelection);
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final h = context.screenHeight;

    final s = (w < h ? w : h);

    final logoSize = (s * 0.28).clamp(90.0, 160.0);
    final titleSize = (s * 0.075).clamp(22.0, 34.0);
    final subtitleSize = (s * 0.035).clamp(12.0, 16.0);
    final gap1 = (h * 0.02).clamp(10.0, 18.0);
    final gap2 = (h * 0.008).clamp(6.0, 10.0);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: (w * 0.08).clamp(16.0, 40.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: logoSize,
                  height: logoSize,
                  child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
                ),
                SizedBox(height: gap1),
                Text(
                  AppStrings.appName,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading24SemiBold.copyWith(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: gap2),
                Text(
                  AppStrings.tagline,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body14Regular.copyWith(
                    fontSize: subtitleSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
