import 'package:get/get.dart';

class SalaryController extends GetxController {
  String grossSalary = '';
  String tax = '';
  String selectedField = 'gross'; // 'gross' or 'tax'
  String taxAmount = '0';
  String netSalary = '0';

  void selectField(String field) {
    selectedField = field;
    update();
  }

  void input(String value) {
    if (value == 'AC') {
      grossSalary = '';
      tax = '';
      taxAmount = '0';
      netSalary = '0';
    } else if (value == '=') {
      calculate();
    } else {
      if (selectedField == 'gross') {
        grossSalary += value;
      } else {
        tax += value;
      }
    }
    update();
  }

  void calculate() {
    try {
      double gross = double.tryParse(grossSalary.replaceAll(',', '')) ?? 0;
      double taxRate = double.tryParse(tax) ?? 0;

      double taxAmt = gross * taxRate / 100;
      double net = gross - taxAmt;

      taxAmount = taxAmt.toStringAsFixed(0);
      netSalary = net.toStringAsFixed(0);
    } catch (_) {
      taxAmount = 'Error';
      netSalary = 'Error';
    }
    update();
  }
}
