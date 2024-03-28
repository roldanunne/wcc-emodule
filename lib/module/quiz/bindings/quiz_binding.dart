import 'package:get/get.dart';
import 'package:wcc_emodule/module/quiz/controllers/quiz_ctrl.dart'; 

class QuizBinding extends Bindings{
  @override
  void dependencies() { 
    Get.put(QuizController());
  }

}