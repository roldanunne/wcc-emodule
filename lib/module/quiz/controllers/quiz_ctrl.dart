import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wcc_emodule/module/global/api_service.dart';
import 'package:wcc_emodule/module/global/gbl_fn.dart';
import 'package:wcc_emodule/module/main/controllers/main_ctrl.dart'; 
import 'package:wcc_emodule/module/quiz/models/quiz_model.dart';
import 'package:wcc_emodule/module/quiz/models/take_quiz_model.dart';
import 'package:wcc_emodule/module/quiz/views/question_data.dart';
import 'package:wcc_emodule/routes/app_routes.dart';   

class QuizController extends GetxController {

  final storage = GetStorage();
  late BuildContext context;

  var isLoading = false.obs;

  MainController mainCtrl = Get.find(); 
  ApiService apiService = Get.find(); 
  
  late QuizModel quizModel; 
  RxList<QuestionList> questionList = <QuestionList>[].obs; 
  List<QuestionData> questionItemList = []; 
  
  var questionLength = 1.obs;
  var questionNumber = 1.obs;
  var correctAnswer = 0.obs;

  var currentPage = 0.obs;
  var lastPage = false.obs; 

  RxList<String> questionAnswerlist = <String>[].obs; 
  RxList<String> correctAnswerList = <String>[].obs; 
  RxList<String> userAnswerList = <String>[].obs; 
  RxList<bool> isQuestionLocked = <bool>[].obs; 

  final PageController pageCtrl = PageController();

  @override
  Future<void> onInit() async { 
    loadInitialized();
    super.onInit();
  }
  
  @override
  Future<void> onClose() async {
    super.onClose();
  }

  loadInitialized() async {
  }
  
  // View Page Controller
  onPageChanged(int page) {
    currentPage.value = page;
    if (currentPage.value == questionLength.value - 1) {
      lastPage.value = true;
    } else {
      lastPage.value = false;
    }
  }
  nextPage() async {
    pageCtrl.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn
    );
  } 
  jumpPage(int page) async { 
    pageCtrl.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn
    );
  } 

  void loadQuestion() {
      questionList.shuffle();
      questionLength.value = questionList.length;
      correctAnswer.value = 0;
      questionNumber.value = 1;
      correctAnswer.value = 0;
      currentPage.value = 0;
      lastPage.value = false;
      
      List<QuestionData> list = []; 
      RxList<String> tempAnswer = <String>[].obs; 
      RxList<String> tempUserAnswerListr = <String>[].obs; 
      RxList<bool> tempLocked = <bool>[].obs; 
      var i=0;
      for (var v in questionList) {
        var item = QuestionData(
          index: i,
          question: v.question,
          a: v.answerA,
          b: v.answerB,
          c: v.answerC,
          d: v.answerD,
          answer: v.answer,
          explanation: v.explanation,
        );
        list.add(item);
        tempAnswer.add(v.answer);
        tempUserAnswerListr.add('');
        tempLocked.add(false);
        i++;
      }
      questionItemList.assignAll(list); 
      // questionItemList.shuffle();
      correctAnswerList.assignAll(tempAnswer);
      userAnswerList.assignAll(tempUserAnswerListr);
      isQuestionLocked.assignAll(tempLocked);
  }
  
  void submitAnswer() {
    var i = currentPage.value;
    if(userAnswerList[i]!=''){
      isQuestionLocked[i] = true;
      if(correctAnswerList[i]==userAnswerList[i]){
        correctAnswer++;
      }
    } else {
      GblFn.showSnackbar("Invalid!", "Please select your answer!",'error');
    }
    
  }

  void nextQuestion() {
    if(lastPage.value){
      Get.back();
      Get.toNamed(Routes.QUESTION_SUMMARY_PAGE);
    } else{
      nextPage();
    } 
  }

  exitSummaryPage() async {
    try {
      isLoading.value = true;
      var result = 'FAILED';
      if(correctAnswer.value==questionLength.value) {
        result = "PERFECT";
      } else if((correctAnswer.value!=questionLength.value)&&correctAnswer.value>(questionLength.value/2)){
        result = "PASSED";
      }
      var data =  {
        'user_id' : apiService.userModel.id,
        'quiz_id' : quizModel.id,
        'question' : questionLength.value,
        'score' : correctAnswer.value,
        'result' : result,
      };

      var res = await apiService.postData('/take_quiz',data);
      if (res.statusCode == 200) {  
        storage.write('takequizdata', res.data.toString());
        mainCtrl.takeQuizModelList.assignAll(takeQuizModelFromJson(storage.read('takequizdata')));
        mainCtrl.takeQuizModelList.refresh(); 
        Get.back();
      } else {      
        GblFn.showSnackbar("Error", "Your request cannot be process, please try again.",'error');
      }
    } catch (e) {
      GblFn.showSnackbar("Error", "Your request cannot be process, please try again.",'error');
    } finally {
      isLoading.value = false;
    }
  }           
 
}
