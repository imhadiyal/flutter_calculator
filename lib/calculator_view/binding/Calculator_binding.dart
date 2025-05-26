import 'package:calling/calculator_view/controller/Calculator_controller.dart';
import 'package:get/get.dart';

class CalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalculatorsController>(() => CalculatorsController());
    Get.lazyPut<CalculatorsController>(() => CalculatorsController());
  }
}
