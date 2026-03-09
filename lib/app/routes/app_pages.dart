import 'package:get/get.dart';
import '../../modules/Help & FAQ/binding/help_faq_binding.dart';
import '../../modules/Help & FAQ/view/help_faq_view.dart';
import '../../modules/Notifications/binding/notifications_binding.dart';
import '../../modules/Notifications/view/notifications_view.dart';
import '../../modules/Privacy & Security/Binding/privacy_security_binding.dart';
import '../../modules/Privacy & Security/view/privacy_security_view.dart';
import '../../modules/Saving Frequency/binding/saving_frequency_binding.dart';
import '../../modules/Saving Frequency/view/saving_frequency_view.dart';
import '../../modules/buddy_selection/view/buddy_view.dart';
import '../../modules/edit_profile/binding/edit_profile_binding.dart';
import '../../modules/edit_profile/view/edit_profile_view.dart';
import '../../modules/history/binding/history_binding.dart';
import '../../modules/history/view/history_view.dart';
import '../../modules/home_shell/binding/home_shell_binding.dart';
import '../../modules/home_shell/view/home_shell_view.dart';
import '../../modules/join_app/binding/join_app_binding.dart';
import '../../modules/join_app/view/join_app_view.dart';
import '../../modules/login/binding/login_binding.dart';
import '../../modules/login/view/login_view.dart';
import '../../modules/name/binding/name_setup_binding.dart';
import '../../modules/name/view/name_setup_view.dart';
import '../../modules/profile/binding/profile_binding.dart';
import '../../modules/profile/view/profile_view.dart';
import '../../modules/saving_rhythm/View/saving_rhythm_view.dart';
import '../../modules/saving_rhythm/binding/saving_rhythm_binding.dart';
import 'app_routes.dart';

import '../../modules/splash/view/SplashView.dart';
import '../../modules/splash/binding/splash_binding.dart';
import '../../modules/buddy_selection/binding/buddy_binding.dart';

class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () =>  SplashView(),
      binding: SplashBinding(), // ✅ THIS MUST BE HERE
    ),
    GetPage(
      name: AppRoutes.buddySelection,
      page: () =>  BuddyView(),
      binding: BuddyBinding(),
    ),
    GetPage(
      name: AppRoutes.savingRhythm,
      page: () =>  SavingRhythmView(),
      binding: SavingRhythmBinding(), // ✅ THIS LINE FIXES IT
    ),
    GetPage(
      name: AppRoutes.nameSetup,
      page: () =>  NameSetupView(),
      binding: NameSetupBinding(),
    ),
  GetPage(
  name: AppRoutes.join,
  page: () =>  JoinAppView(),
  binding: JoinAppBinding(),
  ),
    GetPage(
      name: AppRoutes.login,
      page: () =>  LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.homeShell,
      page: () => HomeShellView(),
      binding: HomeShellBinding(),
    ),
    GetPage(
      name: AppRoutes.history,
      page: () =>  HistoryScreen(),
      binding: HistoryBinding(),
    ),

    GetPage(
      name: AppRoutes.profile,
      page: () =>  ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.savingFrequency,
      page: () =>  SavingFrequencyView(),
      binding: SavingFrequencyBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.notifications,
    //   page: () =>  NotificationsView(),
    //   binding: NotificationsBinding(),
    // ),
    GetPage(
      name: AppRoutes.privacySecurity,
      page: () =>  PrivacySecurityView(),
      binding: PrivacySecurityBinding(),
    ),
    GetPage(
      name: AppRoutes.helpFaq,
      page: () => HelpFaqView(),
      binding: HelpFaqBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
  ];
}
