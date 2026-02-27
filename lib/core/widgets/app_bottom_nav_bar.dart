import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final RxInt currentIndex;
  final void Function(int index) onChanged;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -8),
            ),
          ],
          border: Border(
            top: BorderSide(color: Colors.black.withOpacity(0.04)),
          ),
        ),

        // ✅ ONLY THIS PART reactive
        child: Obx(() {
          final current = currentIndex.value;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                label: "Home",
                asset: AppAssets.home,
                active: current == 0,
                onTap: () => onChanged(0),
              ),
              _NavItem(
                label: "Progress",
                asset: AppAssets.progress,
                active: current == 1,
                onTap: () => onChanged(1),
              ),
              _NavItem(
                label: "History",
                asset: AppAssets.history,
                active: current == 2,
                onTap: () => onChanged(2),
              ),
              _NavItem(
                label: "Profile",
                asset: AppAssets.settingsBlack,
                active: current == 3,
                onTap: () => onChanged(3),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final String asset;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.asset,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color =
    active ? AppColors.purple : Colors.black.withOpacity(0.35);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              asset,
              height: 22,
              width: 22,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}