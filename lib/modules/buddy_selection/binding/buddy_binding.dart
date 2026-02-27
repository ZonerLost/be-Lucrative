import 'package:get/get.dart';
import '../controller/buddy_controller.dart';

class BuddyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuddyController>(() => BuddyController());
  }
}
