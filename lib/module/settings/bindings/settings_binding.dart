import 'package:get/get.dart';
import 'package:wcc_emodule/module/settings/controllers/settings_ctrl.dart'; 

class SettingsBinding extends Bindings{
  @override
  void dependencies() { 
    Get.put(SettingsController());
  }

}