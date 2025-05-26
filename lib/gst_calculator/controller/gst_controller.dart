import 'package:get/get.dart';

class GstController extends GetxController {
  String amount = '';
  double gstRate = 18.0;
  bool addGST = true;

  double get grossAmount {
    double val = double.tryParse(amount) ?? 0;
    return addGST ? val * (1 + gstRate / 100) : val / (1 + gstRate / 100);
  }

  double get gstAmount => grossAmount - (double.tryParse(amount) ?? 0);
  double get sgst => gstAmount / 2;
  double get cgst => gstAmount / 2;

  void updateAmount(String value) {
    amount += value;
    update();
  }

  void backspace() {
    if (amount.isNotEmpty) {
      amount = amount.substring(0, amount.length - 1);
      update();
    }
  }

  void clear() {
    amount = '';
    update();
  }

  void setGST(double rate) {
    gstRate = rate;
    update();
  }

  void toggleAddRemove(bool value) {
    addGST = value;
    update();
  }
}
