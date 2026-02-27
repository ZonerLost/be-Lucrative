import 'package:get/get.dart';
import '../controller/join_app_controller.dart';

class JoinAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinAppController>(() => JoinAppController());
  }
}