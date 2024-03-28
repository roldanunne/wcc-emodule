import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:wcc_emodule/module/global/app_theme.dart'; 
import 'package:wcc_emodule/module/main/controllers/main_ctrl.dart';
import 'package:wcc_emodule/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
    MainController mainCtrl = Get.find();
  
    void navigatePage() async {
      if(mainCtrl.isAuthenticated.value) {
        Get.offNamed(Routes.DASHBOARD); 
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    }
    
    startTime() async {
      var duration = const Duration(milliseconds: 3500);
      return Timer(duration, navigatePage);
    }

    startTime();

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FadeIn(
              duration: const Duration(milliseconds: 3000),
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/logo-dark.png",
                  fit: BoxFit.fill,
                  width: 200,
                ),
              ),
            ),
          ] 
        ),
      ),
    );
  }

}
