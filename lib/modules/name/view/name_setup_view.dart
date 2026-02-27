import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_styles.dart';
import '../../../core/widgets/app_textfield.dart';
import '../controller/name_setup_controller.dart';

// ✅ your extension
import 'package:be_lucrative/extension/extension.dart';

class NameSetupView extends GetView<NameSetupController> {
  const NameSetupView({super.key});

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

                      SizedBox(height: c(sh(20), 16, 24)),

                      // Avatar box
                      Container(
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

                      SizedBox(height: c(sh(20), 16, 24)),

                      Text(
                        "What should we call you?",
                        style: AppTextStyles.heading24SemiBold,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: c(sh(6), 4, 8)),

                      Text(
                        "Your buddy is excited to meet you!",
                        style: AppTextStyles.body14Regular.copyWith(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: c(sh(20), 16, 24)),

                      // TextField (max 20 enforced)
                      AppTextField(
                        controller: controller.nameCtrl,
                        focusNode: controller.nameFocus,
                        hintText: "Enter your name",
                        maxLength: NameSetupController.maxChars,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                            NameSetupController.maxChars,
                          ),
                        ],
                        onChanged: (_) {},
                        onSubmitted: (_) => controller.onLetsGo(),
                      ),

                      SizedBox(height: c(sh(8), 6, 10)),

                      // Remaining chars
                      Obx(
                            () => Text(
                          "${controller.remaining} characters remaining",
                          style: AppTextStyles.body14Regular.copyWith(
                            fontSize: c(sw(12), 11, 13),
                            color: Colors.black.withOpacity(0.35),
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Button (activates on typing)
                      Obx(
                            () => PrimaryActionButton(
                          title: "Let's Go! 🚀",
                          enabled: controller.isValid.value,
                          icon: Icons.arrow_forward_ios,
                          onPressed: controller.isValid.value
                              ? controller.onLetsGo
                              : null,
                        ),
                      ),

                      SizedBox(height: c(sh(16), 12, 20)),
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