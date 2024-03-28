import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wcc_emodule/module/main/controllers/main_ctrl.dart';
import 'package:wcc_emodule/module/dashboard/controllers/dashboard_ctrl.dart';
import 'package:wcc_emodule/module/global/app_theme.dart';
import 'package:wcc_emodule/module/global/gbl_fn.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainCtrl = Get.find();
    mainCtrl.context = context;
    
    return PopScope(
      canPop: true,
      onPopInvoked : (didPop) async => false,
      child: Scaffold(
        extendBody: false,
        body: Navigator(
          key: Get.nestedKey(1),
          initialRoute: '/home',
          onGenerateRoute: controller.onGenerateRoute,
        ),
        bottomNavigationBar: Obx(() => Container( 
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              backgroundColor: AppTheme.white, 
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.currentIndex.value,
              selectedItemColor:AppTheme.primary,
              selectedLabelStyle: AppTheme.dynamicStyle( size:14.0, weight: FontWeight.w600),
              unselectedItemColor:AppTheme.primary,
              unselectedLabelStyle: AppTheme.dynamicStyle( size:12.0, weight: FontWeight.normal),
              elevation: 2.0,
              onTap: controller.changePage,
              items: [
                GblFn.bottomNavigationBarItem(
                  Icons.home,
                  Icons.home_outlined,
                  "Home",
                  false,
                ),
                GblFn.bottomNavigationBarItem(
                  Icons.newspaper,
                  Icons.newspaper_outlined,
                  "Module",
                  false,
                ),
                GblFn.bottomNavigationBarItem(
                  Icons.tips_and_updates,
                  Icons.tips_and_updates_outlined,
                  "Quiz",
                  controller.hasBooking.value,
                ),
                GblFn.bottomNavigationBarItem(
                  Icons.info,
                  Icons.info_outlined,
                  "About",
                  controller.hasNotification.value,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
