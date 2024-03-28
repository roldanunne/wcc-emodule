import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wcc_emodule/module/global/app_theme.dart'; 
import 'package:wcc_emodule/module/settings/controllers/settings_ctrl.dart';  

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    SettingsController ctrl = Get.find();

    ctrl.context = context;

    return  Obx(() => LoadingOverlay(
      isLoading: ctrl.isLoading.value,
      opacity: 0.5,
      progressIndicator: const CircularProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          toolbarHeight: 100, // Set this height
          flexibleSpace: Container( 
            padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 28), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 50.0,
                    ),
                    const SizedBox(width: 5), 
                    AutoSizeText(
                      'NAVIGATIONAL TRAINING',
                      style: AppTheme.dynamicStyle(
                        color: AppTheme.primary, 
                        size:20.0, 
                        weight: FontWeight.w700, 
                        shadow: [ 
                          const Shadow(
                            color: Colors.grey,      // Choose the color of the shadow
                            blurRadius: 3.0,          // Adjust the blur radius for the shadow effect
                            offset: Offset(0.5, 1.0), // Set the horizontal and vertical offset for the shadow
                          ),
                        ]),
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: AppTheme.white,
          shadowColor: AppTheme.grey,
          elevation: 2.0,
          leading: null,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        backgroundColor: AppTheme.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[ 
                const SizedBox(height: 20), 
                HtmlWidget(
                  ctrl.settingsData.details,
                ),
                const SizedBox(height: 20),   
              ]
            ),
          ),
        ))
      )
    );

  }

}
