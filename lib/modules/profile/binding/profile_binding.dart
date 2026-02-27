import 'package:get/get.dart';
import '../controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // lazy load (recommended)
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}