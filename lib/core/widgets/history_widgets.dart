import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../modules/history/controller/history_controller.dart';
import '../../modules/history/model/history_model.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';



class HistorySegmentedTabs extends GetView<HistoryController> {
  const HistorySegmentedTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.tabIndex.value;

      return Container(
        height: 44, // screenshot closer
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFE9E4DE), // same as your bg
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // ✅ Sliding white pill (indicator)
            AnimatedAlign(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              alignment: selected == 0 ? Alignment.centerLeft : Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ✅ Buttons
            Row(
              children: [
                Expanded(
                  child: _SegBtn(
                    selected: selected == 0,
                    icon: Icons.access_time_rounded,
                    label: 'Timeline',
                    onTap: () => controller.setTab(0),
                  ),
                ),
                Expanded(
                  child: _SegBtn(
                    selected: selected == 1,
                    icon: Icons.calendar_month_rounded,
                    label: 'Calendar',
                    onTap: () => controller.setTab(1),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _SegBtn extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SegBtn({
    required this.selected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // screenshot: selected darker, unselected lighter
    final Color c = Colors.black.withOpacity(selected ? 0.78 : 0.40);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: c),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: c,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/* =========================
   Timeline List
========================= */
class HistoryTimelineList extends GetView<HistoryController> {
  const HistoryTimelineList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = controller.entries;

      return Scrollbar(
        thumbVisibility: true,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 6, bottom: 14),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, i) {
            final item = list[i];
            return TimelineItem(
              entry: item,
              isFirst: i == 0,
              isLast: i == list.length - 1,
            );
          },
        ),
      );
    });
  }
}
/* =========================
   Timeline Item
========================= */
class TimelineItem extends StatelessWidget {
  final HistoryEntryModel entry;
  final bool isFirst;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.entry,
    required this.isFirst,
    required this.isLast,
  });

  String _formatDate(DateTime d) {
    const w = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const m = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${w[d.weekday - 1]}, ${m[d.month - 1]} ${d.day}';
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight( // ✅ makes left timeline stretch with card height
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          SizedBox(
            width: 22,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _TimelinePainter(
                      color: AppColors.timelineLine,
                      isFirst: isFirst,
                      isLast: isLast,
                      dotAsset: AppAssets.purple_circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 18, // 👈 same value as painter dotTop
                  left: (22 - 12) / 2,
                  child: SvgPicture.asset(
                    AppAssets.purple_circle,
                    width: 12,
                    height: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // card
          Expanded(
            child: HistoryCard(
              dateText: _formatDate(entry.date),
              xpText: entry.xpLabel,
              streakText: entry.dayLabel,
              note: entry.note,
            ),
          ),
        ],
      ),
    );
  }
}
/* =========================
   Card Widget
========================= */
class HistoryCard extends StatelessWidget {
  final String dateText;
  final String xpText;
  final String streakText;
  final String note;

  const HistoryCard({
    super.key,
    required this.dateText,
    required this.xpText,
    required this.streakText,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: AppColors.cardBg, // ✅ using your AppColors
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadowSoft,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Date + flame
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: AppColors.flameBg,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.fire, // ✅ your asset
                    width: 14,
                    height: 14,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// XP + Day row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.progressFill,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  xpText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$streakText 🔥',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// Note
          Text(
            note,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
class _TimelinePainter extends CustomPainter {
  final Color color;
  final bool isFirst;
  final bool isLast;
  final String dotAsset;

  _TimelinePainter({
    required this.color,
    required this.isFirst,
    required this.isLast,
    required this.dotAsset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double lineW = 3;
    const double dotSize = 12;

    final double centerX = size.width / 2;
    final double dotTop = 18; // 👈 screenshot match: 16-22 me tweak kar lena
    final double dotCenterY = dotTop + dotSize / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = lineW
      ..strokeCap = StrokeCap.round;

    // top segment
    if (!isFirst) {
      canvas.drawLine(
        Offset(centerX, 0),
        Offset(centerX, dotCenterY),
        paint,
      );
    }

    // bottom segment
    if (!isLast) {
      canvas.drawLine(
        Offset(centerX, dotCenterY),
        Offset(centerX, size.height),
        paint,
      );
    }

    // Dot SVG: CustomPainter directly SVG draw nahi karta
    // Isliye dot ko widget layer pe overlay karenge (next step).
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.isFirst != isFirst ||
        oldDelegate.isLast != isLast;
  }
}