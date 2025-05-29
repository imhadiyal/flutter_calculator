import 'package:calling/salary_calculator/controller/salary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalaryView extends StatelessWidget {
  final controller = Get.put(SalaryController());

  SalaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salary Calculator'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: GetBuilder<SalaryController>(
        builder:
            (_) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _inputField('Gross Salary', controller.grossSalary, 'gross'),
                  SizedBox(height: 12),
                  _inputField('Tax', controller.tax, 'tax'),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount', style: TextStyle(fontSize: 16)),
                      Text(
                        controller.netSalary,
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax Amount', style: TextStyle(fontSize: 16)),
                      Text(
                        controller.taxAmount,
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomKeypad(onTap: controller.input),
                ],
              ),
            ),
      ),
    );
  }

  Widget _inputField(String label, String value, String fieldKey) {
    return GestureDetector(
      onTap: () => controller.selectField(fieldKey),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(label, style: TextStyle(fontSize: 16)),
            Spacer(),
            Text(value, style: TextStyle(fontSize: 18, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}

class CustomKeypad extends StatelessWidget {
  final Function(String) onTap;
  CustomKeypad({super.key, required this.onTap});

  final List<String> keys = [
    '7',
    '8',
    '9',
    'AC',
    '4',
    '5',
    '6',
    '×',
    '1',
    '2',
    '3',
    '⌫',
    '.',
    '0',
    '00',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: keys.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final key = keys[index];
        return ElevatedButton(
          onPressed: () => onTap(key == '⌫' ? '' : key),
          style: ElevatedButton.styleFrom(
            backgroundColor: key == 'AC' ? Colors.grey[300] : Colors.blue[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(0),
          ),
          child: Text(key, style: TextStyle(fontSize: 20, color: Colors.black)),
        );
      },
    );
  }
}
