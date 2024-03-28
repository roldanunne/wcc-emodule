import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wcc_emodule/module/global/app_theme.dart';
import 'package:wcc_emodule/module/emodule/controllers/emodule_ctrl.dart'; 

class LessonDetailsPage extends StatelessWidget {
  const LessonDetailsPage({Key? key}) : super(key: key);

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
        actions: <Widget>[ 
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                if(ctrl.isBookmarked.value){
                  ctrl.unbookmarkLesson(ctrl.lessonData);
                } else {
                  ctrl.bookmarkLesson(ctrl.lessonData);
                }
              },
              child: Icon(
                (ctrl.isBookmarked.value)?Icons.bookmark_added:Icons.bookmark_add_outlined,
                size: 26.0,
              ),
            )
          ),

        ],
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
              children: [ 
                const SizedBox(height: 10), 
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  decoration: AppTheme.containerBoxDecoration(borderRadius: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[   
                      Text(
                        ctrl.lessonData.title,
                        style: AppTheme.dynamicStyle(color:AppTheme.black, size:18.0, weight: FontWeight.w600)
                      ),
                      const SizedBox(height: 10), 
                      SelectionArea(
                        child: HtmlWidget(
                          ctrl.lessonData.content,
                        ),
                      ),
                      const SizedBox(height: 20), 
                      HtmlWidget(
                        ctrl.lessonData.reference,
                      ),
                      const SizedBox(height: 20), 
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
              ],
            ),
          ),
        )
      )
    ));

  }

}
