import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    // 2 sec splash then go next
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.buddySelection);
    });
  }
}
