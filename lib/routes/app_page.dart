import 'package:get/get.dart';
import 'package:wcc_emodule/module/dashboard/bindings/dashboard_binding.dart';
import 'package:wcc_emodule/module/dashboard/views/dashboard.dart';
import 'package:wcc_emodule/module/emodule/bindings/emodule_binding.dart';
import 'package:wcc_emodule/module/emodule/views/lesson.dart';
import 'package:wcc_emodule/module/emodule/views/lesson_details.dart';
import 'package:wcc_emodule/module/home/bindings/home_binding.dart';
import 'package:wcc_emodule/module/home/bindings/info_binding.dart';
import 'package:wcc_emodule/module/home/views/bookmark_details.dart';
import 'package:wcc_emodule/module/home/views/info.dart';
import 'package:wcc_emodule/module/login/bindings/login_binding.dart';
import 'package:wcc_emodule/module/login/views/login.dart';
import 'package:wcc_emodule/module/login/views/password.dart';
import 'package:wcc_emodule/module/login/views/terms.dart';
import 'package:wcc_emodule/module/main/views/splash.dart';
import 'package:wcc_emodule/module/quiz/bindings/quiz_binding.dart';
import 'package:wcc_emodule/module/quiz/views/question.dart';
import 'package:wcc_emodule/module/quiz/views/question_summary.dart';
import 'package:wcc_emodule/module/settings/bindings/settings_binding.dart';
import 'package:wcc_emodule/module/settings/views/settings.dart';
import 'package:wcc_emodule/routes/app_routes.dart';

class AppPages {

  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),  
    GetPage(
      name: Routes.TERMS,
      page: () => const TermsPage(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.PASSWORD_CHANGE,
      page: () => const PasswordPage(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),  
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.LESSON_PAGE,
      page: () => const LessonPage(),
      binding: EModuleBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.LESSON_DETAILS,
      page: () => const LessonDetailsPage(),
      binding: EModuleBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.HOME_INFO,
      page: () => const InfoPage(),
      binding: InfoBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.BOOKMARK_DETAILS,
      page: () => const BookmarkDetailsPage(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.QUESTION_PAGE,
      page: () => const QuestionPage(),
      binding: QuizBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.QUESTION_SUMMARY_PAGE,
      page: () => const QuestionSummaryPage(),
      binding: QuizBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
  ];
}
