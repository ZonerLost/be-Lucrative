import 'package:get/get.dart';
import '../controller/name_setup_controller.dart';

class NameSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NameSetupController());
  }
}