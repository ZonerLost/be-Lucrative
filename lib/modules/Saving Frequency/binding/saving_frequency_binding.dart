import 'package:get/get.dart';
import '../controller/saving_frequency_controller.dart';

class SavingFrequencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavingFrequencyController());
  }
}