import 'package:get/get.dart';
import '../controller/help_faq_controller.dart';

class HelpFaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HelpFaqController());
  }
}