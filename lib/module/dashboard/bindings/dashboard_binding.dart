import 'package:get/get.dart';
import 'package:wcc_emodule/module/dashboard/controllers/dashboard_ctrl.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}
