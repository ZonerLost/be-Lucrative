import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../binding/change_password_binding.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ ensure controller is available even if you push directly
    ChangePasswordBinding().dependencies();

    final c = Get.find<ChangePasswordController>();

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
          "Change Password",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.5,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Form(
        key: c.formKey,
        child: Obx(() {
          final s = c.state.value;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            children: [
              _Field(
                label: "Current Password",
                obscure: s.obscureCurrent,
                onChanged: c.setCurrent,
                onToggle: c.toggleCurrent,
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              _Field(
                label: "New Password",
                obscure: s.obscureNew,
                onChanged: c.setNew,
                onToggle: c.toggleNew,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  if (v.length < 6) return 'Minimum 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: 12),

              _Field(
                label: "Confirm New Password",
                obscure: s.obscureConfirm,
                onChanged: c.setConfirm,
                onToggle: c.toggleConfirm,
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 18),

              SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: c.submit,
                  child: const Text(
                    "Update Password",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final bool obscure;
  final ValueChanged<String> onChanged;
  final VoidCallback onToggle;
  final String? Function(String?) validator;

  const _Field({
    required this.label,
    required this.obscure,
    required this.onChanged,
    required this.onToggle,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadowSoft,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextFormField(
        obscureText: obscure,
        onChanged: onChanged,
        validator: validator,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary.withOpacity(0.8),
          ),
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              color: AppColors.textSecondary.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}