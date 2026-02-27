import 'package:flutter/material.dart';

class HistoryCalendarView extends StatefulWidget {
  const HistoryCalendarView({super.key});

  @override
  State<HistoryCalendarView> createState() => _HistoryCalendarViewState();
}

class _HistoryCalendarViewState extends State<HistoryCalendarView> {
  // ---------- Config (replace with your AppColors if needed)
  static const bg = Color(0xFFF7F4F0);
  static const cardBorder = Color(0xFFE7E2DC);
  static const purple = Color(0xFF6D5EF6);
  static const text = Color(0xFF1F1F1F);
  static const subText = Color(0xFF8A8A8A);

  static const _months = [
    'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
  ];
  static const _week = ['Su','Mo','Tu','We','Th','Fr','Sa'];

  int month = 9;
  int year = 2025;

  DateTime? rangeStart;
  DateTime? rangeEnd;

  /// ✅ Dynamic data (demo): saved days (you can replace with controller data)
  /// Example: if you have history entries dates, convert them to DateTime list.
  late Set<DateTime> savedDays;

  @override
  void initState() {
    super.initState();

    savedDays = {
      DateTime(2025, 9, 9),
      DateTime(2025, 9, 10),
      DateTime(2025, 9, 11),
      DateTime(2025, 9, 12),
      DateTime(2025, 9, 13),
      DateTime(2025, 9, 2),
      DateTime(2025, 9, 22),
    };

    rangeStart = DateTime(2025, 9, 9);
    rangeEnd = DateTime(2025, 9, 13);
  }

  DateTime _firstOfMonth() => DateTime(year, month, 1);
  DateTime _lastOfMonth() => DateTime(year, month + 1, 0);
  int _daysInMonth() => _lastOfMonth().day;

  // Sunday=0..Saturday=6
  int _firstWeekdayOffset() => _firstOfMonth().weekday % 7;

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  bool _isInSelectedRange(DateTime d) {
    if (rangeStart == null || rangeEnd == null) return false;
    final s = _dateOnly(rangeStart!);
    final e = _dateOnly(rangeEnd!);
    final x = _dateOnly(d);
    return !x.isBefore(s) && !x.isAfter(e);
  }

  bool _isStart(DateTime d) => rangeStart != null && _sameDay(d, rangeStart!);
  bool _isEnd(DateTime d) => rangeEnd != null && _sameDay(d, rangeEnd!);

  bool _isSaved(DateTime d) {
    final x = _dateOnly(d);
    return savedDays.any((e) => _sameDay(e, x));
  }

  void _onTapDay(DateTime d) {
    setState(() {
      if (rangeStart == null || (rangeStart != null && rangeEnd != null)) {
        rangeStart = d;
        rangeEnd = null;
        return;
      }

      // start exists, end null
      if (d.isBefore(rangeStart!)) {
        rangeEnd = rangeStart;
        rangeStart = d;
      } else {
        rangeEnd = d;
      }
    });
  }

  void _prevMonth() {
    setState(() {
      if (month == 1) {
        month = 12;
        year -= 1;
      } else {
        month -= 1;
      }
      rangeStart = null;
      rangeEnd = null;
    });
  }

  void _nextMonth() {
    setState(() {
      if (month == 12) {
        month = 1;
        year += 1;
      } else {
        month += 1;
      }
      rangeStart = null;
      rangeEnd = null;
    });
  }

  int _savesThisMonth() {
    // ✅ dynamic: count savedDays in this month
    return savedDays.where((d) => d.year == year && d.month == month).length;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _daysInMonth();
    final offset = _firstWeekdayOffset();
    final totalCells = offset + daysInMonth;
    final rows = (totalCells / 7).ceil();

    final saves = _savesThisMonth();

    return Scaffold(
      backgroundColor: bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
        child: Column(
          children: [
            // ✅ Calendar Card
            Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cardBorder),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header row
                  Row(
                    children: [
                      _HeaderIconBtn(icon: Icons.chevron_left_rounded, onTap: _prevMonth),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _DropdownPill<int>(
                              value: month,
                              items: List.generate(12, (i) => i + 1),
                              label: (m) => _months[m - 1],
                              onChanged: (v) => setState(() {
                                month = v;
                                rangeStart = null;
                                rangeEnd = null;
                              }),
                            ),
                            const SizedBox(width: 10),
                            _DropdownPill<int>(
                              value: year,
                              items: List.generate(9, (i) => DateTime.now().year - 4 + i),
                              label: (y) => y.toString(),
                              onChanged: (v) => setState(() {
                                year = v;
                                rangeStart = null;
                                rangeEnd = null;
                              }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      _HeaderIconBtn(icon: Icons.chevron_right_rounded, onTap: _nextMonth),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Week labels
                  Row(
                    children: List.generate(7, (i) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            _week[i],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: subText,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 8),

                  // Days grid (more similar to screenshot)
                  Column(
                    children: List.generate(rows, (r) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: List.generate(7, (c) {
                            final cellIndex = r * 7 + c;
                            final dayNum = cellIndex - offset + 1;

                            if (dayNum < 1 || dayNum > daysInMonth) {
                              return const Expanded(child: SizedBox(height: 38));
                            }

                            final date = DateTime(year, month, dayNum);

                            final selected = _isInSelectedRange(date) || _isStart(date) || _isEnd(date);
                            final isStart = _isStart(date);
                            final isEnd = _isEnd(date);

                            // ✅ connected bar style (screenshot like)
                            BorderRadius br;
                            if (rangeStart != null && rangeEnd != null) {
                              if (isStart && isEnd) {
                                br = BorderRadius.circular(10);
                              } else if (isStart) {
                                br = const BorderRadius.horizontal(
                                  left: Radius.circular(10),
                                  right: Radius.circular(3),
                                );
                              } else if (isEnd) {
                                br = const BorderRadius.horizontal(
                                  left: Radius.circular(3),
                                  right: Radius.circular(10),
                                );
                              } else if (selected) {
                                br = BorderRadius.circular(3);
                              } else {
                                br = BorderRadius.circular(10);
                              }
                            } else {
                              br = BorderRadius.circular(10);
                            }

                            final bool saved = _isSaved(date);

                            return Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => _onTapDay(date),
                                child: SizedBox(
                                  height: 38,
                                  child: Center(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 160),
                                          curve: Curves.easeOutCubic,
                                          width: 38,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: selected ? purple : Colors.transparent,
                                            borderRadius: br,
                                          ),
                                        ),

                                        // ✅ day number
                                        Text(
                                          '$dayNum',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: selected ? Colors.white : text,
                                          ),
                                        ),

                                        // ✅ tiny saved dot (optional, nice dynamic)
                                        if (!selected && saved)
                                          Positioned(
                                            bottom: 3,
                                            child: Container(
                                              width: 4,
                                              height: 4,
                                              decoration: BoxDecoration(
                                                color: purple.withOpacity(0.9),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 16),

                  // Legend (match screenshot)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      _LegendItem(filled: true, label: 'Timeline'),
                      SizedBox(width: 22),
                      _LegendItem(filled: false, label: 'Timeline'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ✅ Saves card (dynamic)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: purple.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.star_rounded, color: purple, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$saves saves',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: text,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'this month',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: subText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- UI bits ---------------- */

class _HeaderIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE7E2DC)),
          ),
          child: Icon(icon, size: 20, color: Colors.black87),
        ),
      ),
    );
  }
}

class _DropdownPill<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String Function(T) label;
  final ValueChanged<T> onChanged;

  const _DropdownPill({
    required this.value,
    required this.items,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE7E2DC)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          items: items
              .map((e) => DropdownMenuItem<T>(
            value: e,
            child: Text(
              label(e),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final bool filled;
  final String label;

  const _LegendItem({required this.filled, required this.label});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6D5EF6);
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: filled ? purple : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: purple, width: 1.4),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Timeline',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}