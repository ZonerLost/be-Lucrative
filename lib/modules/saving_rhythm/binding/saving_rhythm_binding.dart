import 'package:get/get.dart';
import '../Controller/saving_rhythm_controller.dart';

class SavingRhythmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavingRhythmController>(() => SavingRhythmController());
  }
}