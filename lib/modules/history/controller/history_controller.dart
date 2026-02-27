import 'package:get/get.dart';
import '../model/history_model.dart';

class HistoryController extends GetxController {
  /// 0 = Timeline, 1 = Calendar
  final RxInt tabIndex = 0.obs;

  /// Calendar visible month/year
  final RxInt month = DateTime.now().month.obs;
  final RxInt year = DateTime.now().year.obs;

  /// Calendar selected date
  final Rxn<DateTime> selectedDay = Rxn<DateTime>();

  /// Timeline entries
  final RxList<HistoryEntryModel> entries = <HistoryEntryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _seedDemo(); // remove when API connected
  }

  void setTab(int i) => tabIndex.value = i;

  void prevMonth() {
    final current = DateTime(year.value, month.value, 1);
    final prev = DateTime(current.year, current.month - 1, 1);
    year.value = prev.year;
    month.value = prev.month;
  }

  void nextMonth() {
    final current = DateTime(year.value, month.value, 1);
    final next = DateTime(current.year, current.month + 1, 1);
    year.value = next.year;
    month.value = next.month;
  }

  void pickDay(DateTime d) => selectedDay.value = d;

  int get savesThisMonth {
    final m = month.value;
    final y = year.value;
    return entries.where((e) => e.date.month == m && e.date.year == y).length;
  }

  Set<DateTime> get highlightDates {
    final set = <DateTime>{};
    for (final e in entries) {
      set.add(DateTime(e.date.year, e.date.month, e.date.day));
    }
    return set;
  }

  void _seedDemo() {
    final now = DateTime.now();
    final base = DateTime(now.year, now.month, 3);

    entries.assignAll(List.generate(12, (i) {
      final d = base.add(Duration(days: i));
      return HistoryEntryModel(
        date: d,
        xp: 15,
        day: 15,
        note: 'Saved from lunch money!',
        isStreak: true,
      );
    }));

    year.value = entries.first.date.year;
    month.value = entries.first.date.month;
  }
}