import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wcc_emodule/module/main/controllers/main_ctrl.dart';
import 'package:wcc_emodule/module/emodule/models/emodule_model.dart';   

class EModuleController extends GetxController {

  final storage = GetStorage();
  late BuildContext context;

  MainController mainCtrl = Get.find(); 
 
  var isLoading = false.obs;
  var isBookmarked = false.obs;
  
  late EModuleModelList emoduleData; 
  late LessonList lessonData; 
   
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
  
  checkIfBookmarked(){ 
    if(storage.hasData('bookmarked_data') && storage.read('bookmarked_data').isNotEmpty) {
      RxList<LessonList> lessonDataList = <LessonList>[].obs; 
      lessonDataList.assignAll(lessonListFromJson(storage.read('bookmarked_data')));

      RxList<LessonList> matches = <LessonList>[].obs; 
      matches.addAll(lessonDataList);
      matches.retainWhere((s) => s.id==lessonData.id); 
      if(matches.isNotEmpty) {
        isBookmarked.value = true;
      } else {
        isBookmarked.value = false;
      }
    } else {
      isBookmarked.value = false;
    }
  }


  bookmarkLesson(data) async {  
    RxList<LessonList> lessonDataList = <LessonList>[].obs; 
    if(storage.hasData('bookmarked_data') && storage.read('bookmarked_data').isNotEmpty) { 
      lessonDataList.assignAll(lessonListFromJson(storage.read('bookmarked_data')));
    }
    lessonDataList.add(data);
    storage.write('bookmarked_data', lessonListToJson(lessonDataList));
    isBookmarked.value = true;
    checkIfBookmarked(); 
  }

  unbookmarkLesson(data) async {  
    RxList<LessonList> lessonDataList = <LessonList>[].obs; 
    if(storage.hasData('bookmarked_data') && storage.read('bookmarked_data').isNotEmpty) {
      lessonDataList.assignAll(lessonListFromJson(storage.read('bookmarked_data')));
      RxList<LessonList> matches = <LessonList>[].obs; 
      matches.addAll(lessonDataList);
      matches.retainWhere((s) => s.id!=data.id);

      lessonDataList.clear();
      lessonDataList.assignAll(matches);
      storage.write('bookmarked_data', lessonListToJson(matches)); 
      isBookmarked.value = false;
    } else {
      isBookmarked.value = false;
    } 
  }

  // List<LessonList> filterLesson(String query) {
  //   List<LessonList> matches = [];
  //   matches.addAll(sendgridAudienceList);
  //   matches.retainWhere((s) => s.name.toLowerCase().contains(query.toLowerCase()));
  //   return matches;
  // }
  // List<CampaignModel> filterEvents(type) {
  //   List<CampaignModel> matches = [];
  //   matches.addAll(campaignList);
  //   matches.retainWhere((s){
  //     return s.type == type;
  //   });
  //   return matches; 
  // }
}
