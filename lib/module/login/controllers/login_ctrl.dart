import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wcc_emodule/module/global/api_service.dart';
import 'package:wcc_emodule/module/global/app_config.dart';
import 'package:wcc_emodule/module/global/gbl_fn.dart';
import 'package:wcc_emodule/module/main/controllers/main_ctrl.dart';
import 'package:wcc_emodule/module/main/models/user_model.dart';
import 'package:wcc_emodule/module/settings/models/settings_model.dart';
import 'package:wcc_emodule/routes/app_routes.dart';

class LoginController extends GetxController {

  final storage = GetStorage();

  ApiService apiService = Get.find();
  MainController mainCtrl = Get.find(); 

  var isLoading = false.obs;
  var isObscure = true.obs;
  var isObscure1 = true.obs;
  var isAgreed = false.obs;
  var termsdata = ''.obs;

  TextEditingController studIdCtrl = TextEditingController(text:AppConfig.appState=='live'?'':'administrator');
  TextEditingController passwordCtrl = TextEditingController(text:AppConfig.appState=='live'?'':'administrator');

  TextEditingController studIdCtrlEdit = TextEditingController();
  TextEditingController passwordCtrlEdit = TextEditingController();
  TextEditingController repasswordCtrlEdit = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    loadInitialized();
  }

  loadInitialized() async {
    if(storage.hasData('termsdata') && storage.read('termsdata').isNotEmpty) {
      final terms = settingModelFromJson(storage.read('termsdata')); 
      termsdata.value = terms.details;
    }
  } 
    
  // Login Page
  submitLogin() async {  
    try {
      isLoading.value = true;
      var data =  {
        'username' : studIdCtrl.text,
        'password' : passwordCtrl.text
      };

      var res = await apiService.postData('/authenticate',data);
      if (res.statusCode == 200) {  
        log(res.data.toString());
        storage.write('userdata', res.data.toString());
        apiService.userModel = userModelFromJson(storage.read('userdata')); 
        if(apiService.userModel.passwordUpdate==1){
          await mainCtrl.checkLoginStatus();
          if(mainCtrl.isAuthenticated.value){ 
            Get.offNamed(Routes.DASHBOARD);
          } else {      
            GblFn.showSnackbar("Login failed", "Your email or password is incorrect.",'error');
          }
        } else {
          studIdCtrlEdit.text = apiService.userModel.idNo.toString();
          Get.offNamed(Routes.PASSWORD_CHANGE);
        }
      } else {      
        GblFn.showSnackbar("Login failed", "Your email or password is incorrect.",'error');
      }
    } catch (e) {
      GblFn.showSnackbar("Login failed", "Your request cannot be process, please try again.",'error');
    } finally {
      isLoading.value = false;
    }
    
  }
 
  submitPassword() async {  
    try {
      if(passwordCtrlEdit.text == repasswordCtrlEdit.text){
        final userModel = userModelFromJson(storage.read('userdata'));  
        isLoading.value = true;
        var data =  {
          'id' : userModel.id,
          'password' : passwordCtrlEdit.text
        };

        var res = await apiService.postData('/update_password',data);
        if (res.statusCode == 200) {  
          storage.write('userdata', res.data.toString());
          await mainCtrl.checkLoginStatus();
          if(mainCtrl.isAuthenticated.value){ 
            Get.offNamed(Routes.DASHBOARD);
          } else {      
            GblFn.showSnackbar("Password Change", "Your password is incorrect.",'error');
          }
        } else {      
          GblFn.showSnackbar("Password Change", "Your password is incorrect.",'error');
        }
      }
    } catch (e) {
      GblFn.showSnackbar("Password Change", "Your request cannot be process, please try again.",'error');
    } finally {
      isLoading.value = false;
    } 
    
  }
}
