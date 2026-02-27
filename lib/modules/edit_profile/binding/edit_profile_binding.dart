// modules/profile/bindings/edit_profile_binding.dart
import 'package:get/get.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditProfileController());
  }
}