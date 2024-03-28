import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wcc_emodule/module/global/app_theme.dart'; 
import 'package:wcc_emodule/module/emodule/controllers/emodule_ctrl.dart';
import 'package:wcc_emodule/routes/app_routes.dart'; 

class LessonPage extends StatelessWidget {
  const LessonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    EModuleController ctrl = Get.find();

    ctrl.context = context;

    return Obx(() => Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        toolbarHeight: 100, // Set this height
        flexibleSpace: Container( 
          color: Colors.transparent,
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
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: AppTheme.white,
        shadowColor: AppTheme.grey,
        elevation: 3.0,
        leading: null,
        systemOverlayStyle: SystemUiOverlayStyle.dark, 
      ),
      backgroundColor: AppTheme.white,
      body: LoadingOverlay(
        isLoading: ctrl.isLoading.value,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[  
                const SizedBox(height: 10), 
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  decoration: AppTheme.containerBoxDecoration(borderRadius: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ctrl.emoduleData.title,
                        style: AppTheme.dynamicStyle(color:AppTheme.black, size:18.0, weight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis
                      ),
                      const SizedBox(height: 10), 
                      HtmlWidget(
                        ctrl.emoduleData.details,
                      ),
                      const SizedBox(height: 20), 
                      const Divider(color: AppTheme.greyLight, thickness: 0.5), 
                      if(ctrl.emoduleData.lesson.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ctrl.emoduleData.lesson.length,
                        padding: const EdgeInsets.only(top:0, bottom: 20),
                        itemBuilder: (_, i){
                          var v = ctrl.emoduleData.lesson[i]; 
                        
                          var title = v.title; 
                            
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              color: AppTheme.blueSmoke,
                              margin: const EdgeInsets.symmetric(vertical: 3.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    title,
                                    style: AppTheme.dynamicStyle(color:AppTheme.black, size:18.0, weight: FontWeight.w600),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                  Text(
                                    formatDate(v.createdAt, [MM, ' ', d, ' ', yy]),
                                    style: AppTheme.dynamicStyle(color:AppTheme.grey, size:14.0, weight: FontWeight.w500)
                                  ), 
                                ], 
                              ),
                            ),
                            onTap: () async { 
                              ctrl.lessonData = v; 
                              ctrl.checkIfBookmarked(); 
                              Get.toNamed(Routes.LESSON_DETAILS);
                            },
                          );
                        }
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 15), 
                ElevatedButton( 
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 50),
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  ),
                  onPressed: () async {
                      Get.back();
                  }, 
                  child: Text(
                    "Back",
                    style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0, weight:FontWeight.w700)
                  ), 
                ), 
              ]
            ),
          ),
        ))
      )
    );

  }

}
