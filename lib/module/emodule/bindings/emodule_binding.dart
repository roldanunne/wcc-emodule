import 'package:get/get.dart';
import 'package:wcc_emodule/module/emodule/controllers/emodule_ctrl.dart'; 

class EModuleBinding extends Bindings{
  @override
  void dependencies() { 
    Get.put(EModuleController());
  }

}