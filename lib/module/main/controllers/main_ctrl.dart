import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wcc_emodule/module/global/api_service.dart';
import 'package:wcc_emodule/module/main/models/user_model.dart';
import 'package:wcc_emodule/module/emodule/models/emodule_model.dart';
import 'package:wcc_emodule/module/quiz/models/quiz_model.dart';
import 'package:wcc_emodule/module/quiz/models/take_quiz_model.dart'; 

class MainController extends GetxController {

  final storage = GetStorage();
  late BuildContext context;
  
  ApiService apiService = Get.find(); 
  
  var isAnimated = false.obs;
  var isAuthenticated = false.obs; 
  var pages = 0.obs;
  
  RxList<EModuleModelList> eModuleModelList = <EModuleModelList>[].obs; 
  RxList<QuizModel> quizModelList = <QuizModel>[].obs; 
  RxList<TakeQuizModel> takeQuizModelList = <TakeQuizModel>[].obs; 

  @override
  Future<void> onInit() async {
    super.onInit();
    debugPrint("==> MainController");
    loadInitialized();
  }

  loadInitialized() async { 
    getTermsData();
    checkLoginStatus();

  }
  
  checkLoginStatus() async {
    if(storage.hasData('userdata') && storage.read('userdata').isNotEmpty) {
      apiService.userModel = userModelFromJson(storage.read('userdata'));
      isAuthenticated.value = true;
      syncData();
    } else {
      isAuthenticated.value = false;
    }  
  } 

  syncData() async {
    getTermsData();
    getUserData();
    getSettingsData();
    getEModuleData();
    getQuizData();
    getTakeQuizData();
  }

  getTermsData() async { 
    try {
      var res = await apiService.getData('/terms_data'); 
      if (res.statusCode == 200) {   
        storage.write('termsdata', res.data.toString()); 
      } 
    } catch (e) {
      print(e.toString());
    } 
  } 

  getUserData() async {  
    try {
      final userModel = userModelFromJson(storage.read('userdata'));  
      var data =  {
        'id' : userModel.id,
      };

      var res = await apiService.postData('/user_data',data);
      if (res.statusCode == 200) {   
        storage.write('userdata', res.data.toString()); 
      } 
    } catch (e) {
      print(e.toString());
    } 
  } 
  
  getSettingsData() async { 
    try {
      var res = await apiService.getData('/settings_data'); 
      if (res.statusCode == 200) {   
        storage.write('settingsdata', res.data.toString()); 
      } 
    } catch (e) {
      print(e.toString());
    } 
  } 

  getEModuleData() async { 
    if(storage.hasData('emoduledata') && storage.read('emoduledata').isNotEmpty) {
      eModuleModelList.assignAll(eModuleModelListFromJson(storage.read('emoduledata')));
      eModuleModelList.refresh(); 
    }
    try {
      var res = await apiService.getData('/module_list'); 
      if (res.statusCode == 200) {   
        storage.write('emoduledata', res.data.toString());
        eModuleModelList.assignAll(eModuleModelListFromJson(storage.read('emoduledata')));
        eModuleModelList.refresh(); 
      } 
    } catch (e) {
      print(e.toString());
    } 
  } 

  getQuizData() async { 
    if(storage.hasData('quizdata') && storage.read('quizdata').isNotEmpty) {
      quizModelList.assignAll(quizModelFromJson(storage.read('quizdata')));
      quizModelList.refresh(); 
    }
    try {
      var res = await apiService.getData('/quiz_list'); 
      if (res.statusCode == 200) {   
        storage.write('quizdata', res.data.toString());
        quizModelList.assignAll(quizModelFromJson(storage.read('quizdata')));
        quizModelList.refresh(); 
      } 
    } catch (e) {
      print(e.toString());
    } 
  } 

  getTakeQuizData() async { 
    if(storage.hasData('takequizdata') && storage.read('takequizdata').isNotEmpty) {
      takeQuizModelList.assignAll(takeQuizModelFromJson(storage.read('takequizdata')));
      takeQuizModelList.refresh(); 
    }
    try {
      final userModel = userModelFromJson(storage.read('userdata')); 
      var data =  {
        'id' : userModel.id,
      };

      var res = await apiService.postData('/take_quiz_list',data);
      if (res.statusCode == 200) {   
        storage.write('takequizdata', res.data.toString());
        takeQuizModelList.assignAll(takeQuizModelFromJson(storage.read('takequizdata')));
        takeQuizModelList.refresh(); 
      } 
    } catch (e) {
      print(e.toString());
    } 
  } 

}
