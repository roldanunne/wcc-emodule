import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wcc_emodule/module/global/app_theme.dart';
import 'package:wcc_emodule/module/home/controllers/home_ctrl.dart';  

class BookmarkDetailsPage extends StatelessWidget {
  const BookmarkDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    HomeController ctrl = Get.find();

    ctrl.context = context;  
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text(
          "Lesson Details",
          style: AppTheme.dynamicStyle(color: AppTheme.primary, size:18.0, weight:FontWeight.w700)
        ),
        backgroundColor: AppTheme.background,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () { 
                  ctrl.unbookmarkLesson(ctrl.lessonData); 
              },
              child: const Icon(
                Icons.bookmark_remove,
                size: 26.0,
              ),
            )
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      backgroundColor: AppTheme.white,
      body: LoadingOverlay(
        isLoading: ctrl.isLoading.value,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: SingleChildScrollView(
          child: Container(
            color: AppTheme.white,
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[   
                Text(
                  ctrl.lessonData.title,
                  style: AppTheme.dynamicStyle(color:AppTheme.black, size:18.0, weight: FontWeight.w600)
                ),
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
        )
      )
    ));

  }

}
