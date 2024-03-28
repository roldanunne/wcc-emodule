import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wcc_emodule/module/global/app_theme.dart';
import 'package:wcc_emodule/module/main/controllers/main_ctrl.dart'; 
import 'package:wcc_emodule/module/quiz/controllers/quiz_ctrl.dart';
import 'package:wcc_emodule/routes/app_routes.dart'; 

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainController mainCtrl = Get.find();
    QuizController ctrl = Get.find();

    ctrl.context = context;

    return Scaffold(
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
      body: Obx(() => LoadingOverlay(
        isLoading: ctrl.isLoading.value,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: mainCtrl.quizModelList.length,
            padding: const EdgeInsets.only(top:0, bottom: 50),
            itemBuilder: (_, i){
              var v = mainCtrl.quizModelList[i];  
                 
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  decoration: AppTheme.containerBoxDecoration(borderRadius: 12.0),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        v.title,
                        style: AppTheme.dynamicStyle(color:AppTheme.black, size:16.0, weight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis
                      ), 
                      Text(
                        v.moduleTitle,
                        style: AppTheme.dynamicStyle(color:AppTheme.black, size:12.0, weight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis
                      ),
                    ],
                  ),
                ),
                onTap: () async { 
                  ctrl.quizModel = v; 
                  ctrl.questionList.assignAll(v.questionList);
                  ctrl.loadQuestion();
                  Get.toNamed(Routes.QUESTION_PAGE);
                },
              );
            }
          ),
        ))
      )
    );

  }

}
