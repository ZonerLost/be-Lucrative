import 'package:flutter/material.dart';

class HistoryCalendarView extends StatefulWidget {
  const HistoryCalendarView({super.key});

  @override
  State<HistoryCalendarView> createState() => _HistoryCalendarViewState();
}

class _HistoryCalendarViewState extends State<HistoryCalendarView> {

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

  int _firstWeekdayOffset() => _firstOfMonth().weekday % 7;

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  bool _isSaved(DateTime d) {
    final x = _dateOnly(d);
    return savedDays.any((e) => _sameDay(e, x));
  }

  int _savesThisMonth() {
    return savedDays.where((d) => d.year == year && d.month == month).length;
  }

  int _totalAmountThisMonth() {
    return _savesThisMonth() * 15;
  }

  void _onTapDay(DateTime d) {
    setState(() {
      if (rangeStart == null || (rangeStart != null && rangeEnd != null)) {
        rangeStart = d;
        rangeEnd = null;
        return;
      }

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
        year--;
      } else {
        month--;
      }
      rangeStart = null;
      rangeEnd = null;
    });
  }

  void _nextMonth() {
    setState(() {
      if (month == 12) {
        month = 1;
        year++;
      } else {
        month++;
      }
      rangeStart = null;
      rangeEnd = null;
    });
  }

  @override
  Widget build(BuildContext context) {

    final daysInMonth = _daysInMonth();
    final offset = _firstWeekdayOffset();
    final totalCells = offset + daysInMonth;
    final rows = (totalCells / 7).ceil();

    final saves = _savesThisMonth();
    final amount = _totalAmountThisMonth();

    return Scaffold(
      backgroundColor: bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
        child: Column(
          children: [

            /// Calendar Card
            Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cardBorder),
              ),
              child: Column(
                children: [

                  Row(
                    children: [
                      _HeaderIconBtn(icon: Icons.chevron_left_rounded, onTap: _prevMonth),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Center(
                          child: Text(
                            "${_months[month - 1]} $year",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _HeaderIconBtn(icon: Icons.chevron_right_rounded, onTap: _nextMonth),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: List.generate(7, (i) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            _week[i],
                            style: const TextStyle(
                              fontSize: 12,
                              color: subText,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 8),

                  Column(
                    children: List.generate(rows, (r) {
                      return Row(
                        children: List.generate(7, (c) {

                          final cellIndex = r * 7 + c;
                          final dayNum = cellIndex - offset + 1;

                          if (dayNum < 1 || dayNum > daysInMonth) {
                            return const Expanded(child: SizedBox(height: 40));
                          }

                          final date = DateTime(year, month, dayNum);
                          final saved = _isSaved(date);

                          return Expanded(
                            child: GestureDetector(
                              onTap: () => _onTapDay(date),
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [

                                      if (saved)
                                        Container(
                                          width: 34,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: purple,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),

                                      Text(
                                        '$dayNum',
                                        style: TextStyle(
                                          color: saved ? Colors.white : text,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );

                        }),
                      );
                    }),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 14),

            /// SAVES CARD
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
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
                    child: const Icon(Icons.star_rounded, color: purple),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$saves saves",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text(
                          "this month",
                          style: TextStyle(
                            fontSize: 12,
                            color: subText,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$$amount",
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        "Amount",
                        style: TextStyle(
                          fontSize: 12,
                          color: subText,
                        ),
                      ),
                    ],
                  )

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

class _HeaderIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE7E2DC)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon),
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