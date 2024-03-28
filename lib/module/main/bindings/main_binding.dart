import 'package:get/get.dart';
import 'package:wcc_emodule/module/global/api_service.dart';
import 'package:wcc_emodule/module/main/controllers/main_ctrl.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.put(MainController());
  }

}