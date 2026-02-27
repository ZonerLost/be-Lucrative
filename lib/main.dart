import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'core/constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeLucrative',

      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBg,
        fontFamily: 'InterTight',
        useMaterial3: true,
        // colorScheme: ColorScheme.fromSeed(
        //   //seedColor: AppColors.primary,
        //   brightness: Brightness.light,
        // ),
      ),

      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}
