import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeController extends GetxController {
  String input = '';
  String result = '';
  bool isDegreeMode = true;
  bool isAdvanced = false;
  List<String> history = [];

  final List<String> basicButtons = [
    'AC',
    '⌫',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    '00',
    '=',
  ];
  final List<String> advancedButtons = [
    'DEG',
    'sin',
    'cos',
    'tan',
    'INV',
    'e',
    'ln',
    'log',
    '(',
    ')',
  ];
  final List<String> advancedButtonsTop = ['√', 'π', '^', '!'];

  void toggleDegreeMode() {
    isDegreeMode = !isDegreeMode;
    update();
  }

  void toggleAdvanced() {
    isAdvanced = !isAdvanced;
    update();
  }

  void appendValue(String value) {
    input += value;
    update();
  }

  void clearInput() {
    input = '';
    result = '';
    update();
  }

  void deleteLast() {
    if (input.isNotEmpty) {
      input = input.substring(0, input.length - 1);
      update();
    }
  }

  void clearHistory() {
    history.clear();
    update();
  }

  void evaluate() {
    try {
      String finalInput = input
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', '3.1415926535897932')
          .replaceAll('√', 'sqrt')
          .replaceAll('%', '*0.01')
          .replaceAll('^', '^')
          .replaceAll('e', '2.718281828459045');

      finalInput = replaceFactorial(finalInput);

      finalInput = finalInput.replaceAllMapped(
        RegExp(r'log\(([^()]+)\)'),
        (match) => '(log(${match[1]}) / log(10))',
      );

      if (isDegreeMode) {
        finalInput = convertTrigToRadians(finalInput);
      }

      Parser p = Parser();
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();

      double eval = exp.evaluate(EvaluationType.REAL, cm);

      result = eval
          .toStringAsFixed(8)
          .replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');

      history.add('$input = $result');
    } catch (e) {
      result = 'Error';
    }
    update();
  }

  String convertTrigToRadians(String input) {
    input = input.replaceAllMapped(
      RegExp(r'sin\(([^()]+)\)'),
      (match) => 'sin((${match[1]} * 3.1415926535897932 / 180))',
    );
    input = input.replaceAllMapped(
      RegExp(r'cos\(([^()]+)\)'),
      (match) => 'cos((${match[1]} * 3.1415926535897932 / 180))',
    );
    input = input.replaceAllMapped(
      RegExp(r'tan\(([^()]+)\)'),
      (match) => 'tan((${match[1]} * 3.1415926535897932 / 180))',
    );
    return input;
  }

  String replaceFactorial(String input) {
    return input.replaceAllMapped(RegExp(r'(\d+)!'), (match) {
      int num = int.parse(match.group(1)!);
      return factorial(num).toString();
    });
  }

  int factorial(int n) {
    if (n < 0) return 0;
    if (n == 0) return 1;
    int fact = 1;
    for (int i = 1; i <= n; i++) {
      fact *= i;
    }
    return fact;
  }

  void handleButtonPress(String btn) {
    switch (btn) {
      case 'AC':
        clearInput();
        break;
      case '⌫':
        deleteLast();
        break;
      case '=':
        evaluate();
        break;
      case 'sin':
      case 'cos':
      case 'tan':
      case 'log':
      case 'ln':
      case '√':
        appendValue('$btn(');
        break;
      case 'π':
        appendValue('π');
        break;
      case 'e':
        appendValue('e');
        break;
      case 'DEG':
        toggleDegreeMode();
        break;
      case '(':
      case ')':
        appendValue(btn);
        break;
      default:
        appendValue(btn);
    }
  }
}
