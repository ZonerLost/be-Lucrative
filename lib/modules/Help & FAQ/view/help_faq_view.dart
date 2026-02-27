import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_text_styles.dart'; // adjust path if different
import '../controller/help_faq_controller.dart';

class HelpFaqView extends GetView<HelpFaqController> {
  const HelpFaqView({super.key});

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
          "Help & FAQ",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.5,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Obx(() {
        final expanded = controller.expandedIndex.value;

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          children: [
            // FAQ Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadowSoft,
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: List.generate(controller.faqs.length, (i) {
                  final item = controller.faqs[i];
                  final isOpen = expanded == i;

                  return Column(
                    children: [
                      _FaqRow(
                        title: item.question,
                        isOpen: isOpen,
                        onTap: () => controller.toggle(i),
                      ),
                      if (isOpen)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                          child: Text(
                            item.answer,
                            style: AppTextStyles.body14Regular.copyWith(
                              fontSize: 12.4,
                              height: 1.45,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary.withOpacity(0.9),
                            ),
                          ),
                        ),
                      if (i != controller.faqs.length - 1)
                        Container(
                          height: 1,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          color: const Color(0xFFF0EBE5),
                        ),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 18),

            // Need more help?
            const Padding(
              padding: EdgeInsets.only(left: 2, bottom: 10),
              child: Text(
                "NEED MORE HELP?",
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF9A948D),
                  letterSpacing: 0.6,
                ),
              ),
            ),

            // Email Support Card
            InkWell(
              onTap: controller.contactSupport,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                height: 74,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
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
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.tileMint,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.EnvelopeSimple,
                          width: 18,
                          height: 18,
                          colorFilter: ColorFilter.mode(
                            AppColors.successGreen,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email Support",
                            style: AppTextStyles.body14Regular.copyWith(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "support@gmail.com",
                            style: AppTextStyles.body14Regular.copyWith(
                              fontSize: 11.8,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary.withOpacity(0.75),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SvgPicture.asset(
                      AppAssets.caretRight,
                      width: 18,
                      height: 18,
                      colorFilter: ColorFilter.mode(
                        AppColors.textSecondary.withOpacity(0.6),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _FaqRow extends StatelessWidget {
  final String title;
  final bool isOpen;
  final VoidCallback onTap;

  const _FaqRow({
    required this.title,
    required this.isOpen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.body14Regular.copyWith(
                  fontSize: 13.2,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            AnimatedRotation(
              turns: isOpen ? 0.5 : 0.0, // caret down when open
              duration: const Duration(milliseconds: 180),
              child: SvgPicture.asset(
                AppAssets.caretRight,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  AppColors.textSecondary.withOpacity(0.55),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}