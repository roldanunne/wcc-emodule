import 'dart:async';
import 'dart:developer'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wcc_emodule/module/global/api_service.dart'; 
import 'package:wcc_emodule/module/main/controllers/main_ctrl.dart';
import 'package:wcc_emodule/module/settings/models/settings_model.dart'; 

class SettingsController extends GetxController {

  final storage = GetStorage();
  late BuildContext context;

  ApiService apiService = Get.find();
  MainController mainCtrl = Get.find();
 
  var isLoading = false.obs;
   
  late SettingModel settingsData; 

  @override
  Future<void> onInit() async {
    debugPrint("==> HomeController");
    loadInitialized();
    super.onInit();
  }
  
  @override
  Future<void> onClose() async {
    super.onClose();
  }

  loadInitialized() async {
    getSettingsData();
  }
 
  getSettingsData() async { 
    if(storage.hasData('settingsdata') && storage.read('settingsdata').isNotEmpty) {
      settingsData = settingModelFromJson(storage.read('settingsdata')); 
    }
  } 

}
