import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'app_text_styles.dart';

class PrimaryActionButton extends StatelessWidget {
  final String title;
  final bool enabled;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double borderRadius;
  final double? height;

  const PrimaryActionButton({
    super.key,
    required this.title,
    required this.enabled,
    required this.onPressed,
    this.icon,
    this.borderRadius = 16,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;

    return SizedBox(
      width: double.infinity,
      height: height ?? (h * 0.065).clamp(48.0, 56.0),
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.purple,
          disabledBackgroundColor:
          AppColors.purple.withOpacity(0.45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTextStyles.button16SemiBold.copyWith(
                color: Colors.white,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 10),
              Icon(icon, size: 16, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }
}