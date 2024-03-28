import 'package:get/get.dart';
import 'package:wcc_emodule/module/login/controllers/login_ctrl.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() { 
    Get.put(LoginController());
  }

}