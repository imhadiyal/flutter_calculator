import 'package:calling/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:calling/home_page/controllers/calculator_controller.dart';
import 'package:get/get.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarController>(() => BottomBarController());
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
