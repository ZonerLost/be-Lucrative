import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_styles.dart';
import '../../../core/widgets/app_textfield.dart';
import '../controller/login_controller.dart';

// ✅ your extension
import 'package:be_lucrative/extension/extension.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final h = context.screenHeight;

    double sw(double v) => (w / 375.0) * v;
    double sh(double v) => (h / 812.0) * v;
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
                        "Welcome Back!",
                        style: AppTextStyles.heading24SemiBold,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: c(sh(6), 4, 8)),
                      Text(
                        "Your buddy missed you!",
                        style: AppTextStyles.body14Regular.copyWith(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: c(sh(18), 14, 22)),

                      // ✅ White Card
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
                                textInputAction: TextInputAction.done,
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
                                onSubmitted: (_) => controller.onLogin(),
                              ),
                            ),

                            SizedBox(height: c(sh(10), 8, 12)),

                            // Forgot password
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: controller.onForgotPassword,
                                child: Text(
                                  "Forgot password?",
                                  style: AppTextStyles.body14Regular.copyWith(
                                    color: AppColors.purple,
                                    fontSize: c(sw(12.5), 11.5, 13.5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: c(sh(14), 10, 16)),

                            // Log In button
                            Obx(
                                  () => PrimaryActionButton(
                                title: "Log In",
                                enabled: controller.isValid.value,
                                onPressed: controller.isValid.value
                                    ? controller.onLogin
                                    : null,
                              ),
                            ),

                            SizedBox(height: c(sh(12), 10, 14)),

                            // Don't have account? Sign Up
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don’t have an account? ",
                                  style: AppTextStyles.body14Regular.copyWith(
                                    color: Colors.black.withOpacity(0.55),
                                  ),
                                ),
                                InkWell(
                                  onTap: controller.onSignUpTap,
                                  child: Text(
                                    "Sign Up",
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

                      const Spacer(),
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