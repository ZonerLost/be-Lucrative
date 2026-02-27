import 'package:be_lucrative/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_styles.dart';
import '../../../core/widgets/app_textfield.dart';
import '../controller/join_app_controller.dart';

// make sure this extension file is imported where you defined it
// import 'path/to/build_context_extension.dart';

class JoinAppView extends GetView<JoinAppController> {
  const JoinAppView({super.key});

  @override
  Widget build(BuildContext context) {
    // quick responsive helpers
    final w = context.screenWidth;
    final h = context.screenHeight;

    // simple scaling (safe + easy)
    double sw(double v) => (w / 375.0) * v; // 375 = base iPhone width
    double sh(double v) => (h / 812.0) * v; // 812 = base iPhone height

    // clamps for stability on very small/large screens
    double c(double v, double min, double max) =>
        v < min ? min : (v > max ? max : v);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4EF),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: c(sw(18), 14, 24),
                vertical: c(sh(10), 8, 16),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Back
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            borderRadius: BorderRadius.circular(c(sw(10), 8, 12)),
                            child: Padding(
                              padding: EdgeInsets.all(c(sw(8), 6, 10)),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.back,
                                    width: c(sw(18), 16, 20),
                                    height: c(sw(18), 16, 20),
                                  ),
                                  SizedBox(width: c(sw(8), 6, 10)),
                                  Text(
                                    "Back",
                                    style: AppTextStyles.body14Regular.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.75),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: c(sh(18), 14, 22)),

                      // Buddy Icon
                      Center(
                        child: Container(
                          width: c(sw(86), 72, 96),
                          height: c(sw(86), 72, 96),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE7A6),
                            borderRadius: BorderRadius.circular(c(sw(22), 18, 26)),
                          ),
                          child: Center(
                            child: Image.asset(
                              AppAssets.luca,
                              width: c(sw(60), 50, 70),
                              height: c(sw(60), 50, 70),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: c(sh(16), 12, 18)),

                      Text(
                        "Join BeLucrative ",
                        style: AppTextStyles.heading24SemiBold,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: c(sh(6), 4, 8)),
                      Text(
                        "Start your savings adventure",
                        style: AppTextStyles.body14Regular.copyWith(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: c(sh(18), 14, 22)),

                      // ✅ WHITE CARD
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: c(sw(16), 14, 20),
                          vertical: c(sh(18), 14, 22),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(c(sw(18), 14, 20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: c(sw(18), 14, 22),
                              offset: Offset(0, c(sh(10), 8, 12)),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.black.withOpacity(0.04),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Email
                            Text(
                              "Email",
                              style: AppTextStyles.body14Regular.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.75),
                              ),
                            ),
                            SizedBox(height: c(sh(8), 6, 10)),
                            AppTextField(
                              controller: controller.emailCtrl,
                              focusNode: controller.emailFocus,
                              hintText: "you@example.com",
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                  left: c(sw(14), 12, 16),
                                  right: c(sw(10), 8, 12),
                                ),
                                child: Icon(
                                  Icons.mail_outline,
                                  size: c(sw(18), 16, 20),
                                  color: Colors.black.withOpacity(0.35),
                                ),
                              ),
                              onSubmitted: (_) => FocusScope.of(context)
                                  .requestFocus(controller.passFocus),
                            ),

                            SizedBox(height: c(sh(14), 10, 16)),

                            // Password
                            Text(
                              "Password",
                              style: AppTextStyles.body14Regular.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.75),
                              ),
                            ),
                            SizedBox(height: c(sh(8), 6, 10)),
                            Obx(
                                  () => AppTextField(
                                controller: controller.passCtrl,
                                focusNode: controller.passFocus,
                                hintText: "••••••••",
                                textInputAction: TextInputAction.next,
                                obscureText: !controller.showPass.value,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    left: c(sw(14), 12, 16),
                                    right: c(sw(10), 8, 12),
                                  ),
                                  child: Icon(
                                    Icons.lock_outline,
                                    size: c(sw(18), 16, 20),
                                    color: Colors.black.withOpacity(0.35),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: controller.togglePass,
                                  icon: Icon(
                                    controller.showPass.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    size: c(sw(18), 16, 20),
                                    color: Colors.black.withOpacity(0.35),
                                  ),
                                ),
                                onSubmitted: (_) => FocusScope.of(context)
                                    .requestFocus(controller.confirmFocus),
                              ),
                            ),

                            SizedBox(height: c(sh(14), 10, 16)),

                            // Confirm Password
                            Text(
                              "Confirm Password",
                              style: AppTextStyles.body14Regular.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.75),
                              ),
                            ),
                            SizedBox(height: c(sh(8), 6, 10)),
                            Obx(
                                  () => AppTextField(
                                controller: controller.confirmCtrl,
                                focusNode: controller.confirmFocus,
                                hintText: "••••••••",
                                textInputAction: TextInputAction.done,
                                obscureText: !controller.showConfirm.value,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    left: c(sw(14), 12, 16),
                                    right: c(sw(10), 8, 12),
                                  ),
                                  child: Icon(
                                    Icons.lock_outline,
                                    size: c(sw(18), 16, 20),
                                    color: Colors.black.withOpacity(0.35),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: controller.toggleConfirm,
                                  icon: Icon(
                                    controller.showConfirm.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    size: c(sw(18), 16, 20),
                                    color: Colors.black.withOpacity(0.35),
                                  ),
                                ),
                                onSubmitted: (_) => controller.onCreateAccount(),
                              ),
                            ),

                            SizedBox(height: c(sh(16), 12, 18)),

                            // Create Account button
                            Obx(
                                  () => PrimaryActionButton(
                                title: "Create Account",
                                enabled: controller.isValid.value,
                                onPressed: controller.isValid.value
                                    ? controller.onCreateAccount
                                    : null,
                              ),
                            ),

                            SizedBox(height: c(sh(12), 10, 14)),

                            // Already have an account? Log In
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: AppTextStyles.body14Regular.copyWith(
                                    color: Colors.black.withOpacity(0.55),
                                  ),
                                ),
                                InkWell(
                                  onTap: controller.onLoginTap,
                                  child: Text(
                                    "Log In",
                                    style: AppTextStyles.body14Regular.copyWith(
                                      color: AppColors.purple,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Footer text
                      Padding(
                        padding: EdgeInsets.only(
                          top: c(sh(14), 10, 16),
                          bottom: c(sh(10), 8, 14),
                        ),
                        child: Text(
                          "By signing up, you agree to our Terms of Service and Privacy Policy",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body14Regular.copyWith(
                            fontSize: c(sw(12), 11, 13),
                            color: Colors.black.withOpacity(0.35),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}