import 'package:calling/gst_calculator/controller/gst_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class GstCalculatorView extends StatelessWidget {
  final List<double> gstRates = [5, 12, 18, 28, 32];

  GstCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GstController>(
      builder:
          (controller) => Scaffold(
            appBar: AppBar(
              title: const Text("GST/VAT Calculator"),
              leading: const BackButton(),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400),
                        color: Colors.grey.shade100,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        controller.amount,
                        style: TextStyle(
                          fontSize: Get.height * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // GST Radio Toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio<bool>(
                              value: true,
                              groupValue: controller.addGST,
                              onChanged:
                                  (val) => controller.toggleAddRemove(true),
                            ),
                            const Text("Add GST"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<bool>(
                              value: false,
                              groupValue: controller.addGST,
                              onChanged:
                                  (val) => controller.toggleAddRemove(false),
                            ),
                            const Text("Remove GST"),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // GST Rate Buttons container with reduced padding
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children:
                            gstRates.map((rate) {
                              bool isSelected = controller.gstRate == rate;
                              return GestureDetector(
                                onTap: () => controller.setGST(rate),
                                child: Container(
                                  width: 100,
                                  padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.015,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          isSelected
                                              ? Colors.blue
                                              : Colors.transparent,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        isSelected
                                            ? Colors.blue.shade100
                                            : Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("${rate.toInt()}%"),
                                ),
                              );
                            }).toList(),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Results
                    buildRow("Gross Amount", controller.grossAmount),
                    buildRow("GST Amount", controller.gstAmount),
                    buildRow("SGST", controller.sgst),
                    buildRow("CGST", controller.cgst),
                    SizedBox(height: 10),
                    StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      children: List.generate(keys.length, (index) {
                        final val = keys[index];

                        if (val == '') return const SizedBox.shrink();

                        int mainAxisCount = (val == 'AC' || val == '⌫') ? 2 : 1;

                        return StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: mainAxisCount,
                          child: buildButton(controller, val),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  final List<String> keys = [
    '7',
    '8',
    '9',
    'AC',
    '4',
    '5',
    '6',
    '1',
    '2',
    '3',
    '⌫',
    '.',
    '0',
    '00',
  ];

  // Display result rows
  Widget buildRow(String title, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$title :", style: TextStyle(fontSize: Get.height * 0.02)),
        Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            color: Colors.blue,
            fontSize: Get.height * 0.022,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Keypad button builder with reduced margin
  Widget buildButton(GstController controller, String value) {
    bool isSpecial = value == 'AC' || value == '⌫';

    return GestureDetector(
      onTap:
          value == ''
              ? null
              : () {
                if (value == 'AC') {
                  controller.clear();
                } else if (value == '⌫') {
                  controller.backspace();
                } else {
                  controller.updateAmount(value);
                }
              },
      child: Container(
        height: 60, // reduced from 200 to 60
        margin: const EdgeInsets.all(6), // reduced from 10 to 6
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              value == ''
                  ? Colors.transparent
                  : isSpecial
                  ? Colors.grey.shade300
                  : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
        ),
        child:
            value == '⌫'
                ? Icon(Icons.backspace_outlined, size: Get.height * 0.03)
                : Text(
                  value,
                  style: TextStyle(
                    fontSize: Get.height * 0.025,
                    fontWeight: FontWeight.w600,
                  ),
                ),
      ),
    );
  }
}
