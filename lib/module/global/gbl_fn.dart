import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

import 'app_theme.dart';


class GblFn {
  GblFn._();
  
  static pushReplacement(BuildContext context, var page) {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

  static pushScreen(BuildContext context, var page) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static pop(BuildContext context) {
    return Navigator.pop(context);
  }

  
  static showSnackbar(title, message,[var type = 'normal']){
    var bg = const Color(0xFFe2e3e5);
    var tc = const Color(0xFF41464b);
    if(type == 'success'){
      bg = const Color(0xFFd4edda);
      tc = const Color(0xFF0f5132);
    } else if(type == 'warning'){
      bg = const Color(0xFFfff3cd);
      tc = const Color(0xFF664d03);
    } else if(type == 'error'){
      bg = const Color(0xFFf8d7da);
      tc = const Color(0xFF842029);
    } else if(type == 'info'){
      bg = const Color(0xFFcff4fc);
      tc = const Color(0xFF055160);
    }
    Get.snackbar(
      title,
      message,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 80 ),
      colorText: tc,
      backgroundColor: bg,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static Future<dynamic> bottomSheet(var bottomsheet) {
    return Get.bottomSheet(
      bottomsheet,
      elevation: 20.0,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFf9f9fb),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        )
      ) 
    );        
  }

  static showDialogView({var content}) async {
    return await Get.defaultDialog( 
      radius: 10,
      title: "",
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.fromLTRB(20,0,20,10), 
      barrierDismissible: false,
      content: WillPopScope(
        onWillPop: () async => false,
        child: content
      ) 
    );
  }   

  static showDefaultDialog({String type="", String title="", String btnYesLabel="Yes", String btnNoLabel="No", var content}) async {
    return await Get.defaultDialog( 
      title: '',
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.fromLTRB(20,0,20,20), 
      content: WillPopScope(
        onWillPop: () async => false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (type=="success")?const Icon(Icons.check, size: 90.0, color: AppTheme.primary):const Icon(Icons.error, size: 90.0, color: AppTheme.red),
            Text(title, style: AppTheme.dynamicStyle(color: AppTheme.primary, size:20.0, weight:FontWeight.w600)),
            const SizedBox(height: 15),
            content,
            const SizedBox(height: 15),
            if(btnYesLabel!='') ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(180, 45),
                primary: AppTheme.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onPressed: () {
                Get.back(result: true);
              },
              child: Text(btnYesLabel, style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0)),
            ),
            if(btnNoLabel!='') const SizedBox(height: 12),
            if(btnNoLabel!='')
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(180, 45),
                primary: AppTheme.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onPressed: () {
                Get.back(result: false);
              },
              child: Text(btnNoLabel, style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0)),
            ),
          ],
        )
      ) 
    );
  }
  
  static bottomNavigationBarItem(activeIcon, icon, label, hasNotif) {
    return BottomNavigationBarItem(
      activeIcon: Icon(activeIcon, size:32, color:AppTheme.primary),
      icon: Icon(icon, size:32, color:AppTheme.primary),
      label: label,
    ); 
  }
 
  static bool isValidEmail(String value) {
      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (value.isEmpty || !regExp.hasMatch(value)) {
        return false;
      }
      return true;
  }  
}
