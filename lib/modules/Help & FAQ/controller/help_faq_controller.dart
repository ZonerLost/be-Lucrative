import 'package:get/get.dart';
import '../model/help_faq_model.dart';

class HelpFaqController extends GetxController {
  // which tile is expanded
  final expandedIndex = (-1).obs;

  // dummy data (screenshot style)
  final faqs = const <FaqItem>[
    FaqItem(
      question: "How do streaks work?",
      answer:
      "Streaks track consecutive saves based on your chosen frequency. "
          "If you save daily, you need to check in every day. Weekly means once per week, and so on. "
          "Missing a period resets your streak, but your total XP is always preserved.",
    ),
    FaqItem(
      question: "How does my avatar evolve?",
      answer:
      "Your avatar evolves as you earn XP and maintain consistency. "
          "Completing streaks and saving regularly helps you level up faster.",
    ),
    FaqItem(
      question: "What happens if I miss a day?",
      answer:
      "If you miss your required check-in window, your current streak resets. "
          "Your total XP and history remain محفوظ.",
    ),
    FaqItem(
      question: "Can I change my saving frequency",
      answer:
      "Yes. You can switch between daily/weekly/bi-weekly/monthly from profile settings. "
          "Changing frequency resets the current streak.",
    ),
    FaqItem(
      question: "How is XP calculated?",
      answer:
      "XP is awarded based on successful check-ins and streak milestones. "
          "Longer consistency = more XP rewards.",
    ),
  ].obs;

  void toggle(int index) {
    expandedIndex.value = (expandedIndex.value == index) ? -1 : index;
  }

  void contactSupport() {
    // TODO: open email
    Get.snackbar('Email Support', 'Email support flow will be added.');
  }
}