import 'package:get/get.dart';
import 'package:wcc_emodule/module/home/controllers/home_ctrl.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() { 
    Get.put(HomeController());
  }

}