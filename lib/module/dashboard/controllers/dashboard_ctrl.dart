import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wcc_emodule/module/emodule/bindings/emodule_binding.dart';
import 'package:wcc_emodule/module/emodule/views/emodule.dart';
import 'package:wcc_emodule/module/home/bindings/home_binding.dart';
import 'package:wcc_emodule/module/home/views/home.dart';
import 'package:wcc_emodule/module/quiz/bindings/quiz_binding.dart';
import 'package:wcc_emodule/module/quiz/views/quiz.dart';
import 'package:wcc_emodule/module/settings/bindings/settings_binding.dart';
import 'package:wcc_emodule/module/settings/views/settings.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();

  var showBNavBar = true.obs;
  var currentIndex = 0.obs;
  var currentPage = ''.obs;
  var hasBooking = false.obs;
  var hasSocial = false.obs;
  var hasNotification = false.obs;

  final pages = <String>[
    '/home', 
    '/emodule', 
    '/quiz',   
    '/settings',
  ];

  void changePage(int index) {
    currentIndex.value = index;
    Get.offNamed(pages[index], id: 1);
  } 
  
  void reloadApiData(page) async {
    if(page=='/home' || page=='/notifications') {
    }
  }

  
  Route? onGenerateRoute(RouteSettings settings) {
    currentPage.value = settings.name!;
    reloadApiData(settings.name);

    if (settings.name == '/home') {
      return GetPageRoute(
        settings: settings,
        page: () => const HomePage(),
        binding: HomeBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 600),
      );
    }

    if (settings.name == '/emodule') {
      return GetPageRoute(
        settings: settings,
        page: () => const EModulePage(),
        binding: EModuleBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 600),
      );
    }

    if (settings.name == '/quiz') {
      return GetPageRoute(
        settings: settings,
        page: () => const QuizPage(),
        binding: QuizBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 600),
      );
    }

    if (settings.name == '/settings') {
      return GetPageRoute(
        settings: settings,
        page: () => const SettingsPage(),
        binding: SettingsBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 600),
      );
    }

    return null;
  }
}
