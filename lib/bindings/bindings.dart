import 'package:get/get.dart';
import 'package:yahoo_finances/controllers/chart_controller.dart';
import 'package:yahoo_finances/controllers/home_controller.dart';

class BaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ChartController());
  }
}
