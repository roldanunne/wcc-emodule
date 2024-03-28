import 'package:get/get.dart';
import 'package:wcc_emodule/module/home/controllers/info_ctrl.dart'; 

class InfoBinding extends Bindings{
  @override
  void dependencies() { 
    Get.put(InfoController());
  }

}