import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; 
import 'package:wcc_emodule/module/dashboard/controllers/dashboard_ctrl.dart';
import 'package:wcc_emodule/module/global/api_service.dart'; 
import 'package:wcc_emodule/module/main/controllers/main_ctrl.dart';

class InfoController extends GetxController {

  final storage = GetStorage();
  late BuildContext context;

  MainController mainCtrl = Get.find();
  DashboardController dashCtrl = Get.find();
  ApiService apiService = Get.find();
 
  var isLoading = false.obs;
  var tabFlag = false.obs;
  var isObscure = true.obs;
    

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
    
}
