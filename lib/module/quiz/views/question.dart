import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart'; 
import 'package:wcc_emodule/module/global/app_theme.dart'; 
import 'package:wcc_emodule/module/quiz/controllers/quiz_ctrl.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    QuizController ctrl = Get.find();

    ctrl.context = context;

    return Obx(() => Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        toolbarHeight: 90, // Set this height
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
                    'Quiz',
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
        elevation: 3.0,
        leading: null,
        systemOverlayStyle: SystemUiOverlayStyle.dark, 
      ),
      // appBar: AppBar(
      //   title: AutoSizeText(
      //     ctrl.quizModel.title,
      //     style: AppTheme.dynamicStyle(color: AppTheme.primary, size:18.0, weight:FontWeight.w700),
      //     maxLines: 2,
      //   ),
      //   backgroundColor: AppTheme.background,
      //   elevation: 0.0, 
      //   systemOverlayStyle: SystemUiOverlayStyle.dark,
      // ),
      backgroundColor: AppTheme.white,
      body: LoadingOverlay(
        isLoading: ctrl.isLoading.value,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[ 
               AutoSizeText(
                ctrl.quizModel.title,
                style: AppTheme.dynamicStyle(color: AppTheme.primary, size:22.0, weight:FontWeight.w700),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Question ${ctrl.currentPage.value+1}/${ctrl.questionLength.value}", 
                    style: AppTheme.dynamicStyle(color: AppTheme.black, size:20.0, weight:FontWeight.w600),
                  ),
                  Text(
                    "Score: ${ctrl.correctAnswer.value}", 
                    style: AppTheme.dynamicStyle(color: AppTheme.black, size:20.0, weight:FontWeight.w600),
                  ),
                ],
              ),
              const Divider(color: AppTheme.black, height:1, thickness:1),
              const SizedBox(height: 30),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: ctrl.pageCtrl,
                  onPageChanged: ctrl.onPageChanged,
                  children: ctrl.questionItemList,
                ),
              ),
              const SizedBox(height: 20),
              if(!ctrl.isQuestionLocked[ctrl.currentPage.value])
              ElevatedButton( 
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.maxFinite, 50),
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
                onPressed: () async {
                  ctrl.submitAnswer();
                }, 
                child: Text(
                  "Submit Answer",
                  style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0, weight:FontWeight.w700)
                ), 
              ), 
              if(ctrl.isQuestionLocked[ctrl.currentPage.value])
              ElevatedButton( 
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.maxFinite, 50),
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
                onPressed: () async {
                  ctrl.nextQuestion();
                }, 
                child: Text(
                  ctrl.lastPage.value ? "Summary":"Next Question",
                  style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0, weight:FontWeight.w700)
                ), 
              ), 
              const SizedBox(height: 10), 
            ]
          ),
        ))
      )
    );

  }

}
