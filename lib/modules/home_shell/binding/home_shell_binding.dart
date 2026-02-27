import 'package:get/get.dart';
import '../../  progress/controller/progress_controller.dart';
import '../controller/home_shell_controller.dart';

class HomeShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeShellController>(() => HomeShellController());

    // ✅ ADD THIS (Progress Controller register)
    Get.lazyPut<ProgressController>(() => ProgressController(), fenix: true);
  }
}