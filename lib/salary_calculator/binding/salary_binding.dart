import 'package:calling/salary_calculator/controller/salary_controller.dart';
import 'package:get/get.dart';

class SalaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalaryController>(() => SalaryController());
  }
}
