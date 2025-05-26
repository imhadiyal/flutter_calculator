import 'package:calling/calculator_view/widget/calculator_tile.dart';
import 'package:calling/routes/page_routes.dart';
import 'package:calling/utils/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final financialCalculators = [
      {'icon': AppAsset.gstIcon, 'label': 'GST/VAT Calculator'},
      {'icon': AppAsset.loanIcon, 'label': 'Loan Calculator'},
      {'icon': AppAsset.salaryIcon, 'label': 'Salary Calculator'},
      {'icon': AppAsset.savingIcon, 'label': 'Saving Calculator'},
      {'icon': AppAsset.tipIcon, 'label': 'Tip Calculator'},
      {'icon': AppAsset.percentageIcon, 'label': 'Percentage Calculator'},
      {'icon': AppAsset.sipIcon, 'label': 'SIP Calculator'},
    ];

    final otherCalculators = [
      {'icon': AppAsset.discountIcon, 'label': 'Discount Calculator'},
      {'icon': AppAsset.unitIcon, 'label': 'Unit Calculator'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Calculators'), centerTitle: true),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Get.height * 0.02,
          vertical: Get.height * 0.015,
        ),
        children: [
          sectionTitle("Financial Calculators"),
          ...financialCalculators.map(
            (calc) => CalculatorTile(
              icon: calc['icon'] as String,
              title: calc['label'] as String,
              onTap: () {
                navigateToCalculator(calc['label'] as String);
              },
            ),
          ),
          SizedBox(height: Get.height * 0.03),
          sectionTitle("Other Calculators"),
          ...otherCalculators.map(
            (calc) => CalculatorTile(
              icon: calc['icon'] as String,
              title: calc['label'] as String,
              onTap: () {
                navigateToCalculator(calc['label'] as String);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) => Padding(
    padding: EdgeInsets.only(bottom: Get.height * 0.015),
    child: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Get.height * 0.022,
      ),
    ),
  );

  void navigateToCalculator(String label) {
    switch (label) {
      case 'GST/VAT Calculator':
        Get.toNamed(AppRoutes.gstCalculator);
        break;
      // case 'Loan Calculator':
      //   Get.to(() => const LoanCalculatorView());
      //   break;
      // case 'Salary Calculator':
      //   Get.to(() => const SalaryCalculatorView());
      //   break;
      // case 'Saving Calculator':
      //   Get.to(() => const SavingCalculatorView());
      //   break;
      // case 'Tip Calculator':
      //   Get.to(() => const TipCalculatorView());
      //   break;
      // case 'Percentage Calculator':
      //   Get.to(() => const PercentageCalculatorView());
      //   break;
      // case 'SIP Calculator':
      //   Get.to(() => const SipCalculatorView());
      //   break;
      // case 'Discount Calculator':
      //   Get.to(() => const DiscountCalculatorView());
      //   break;
      // case 'Unit Calculator':
      //   Get.to(() => const UnitCalculatorView());
      //   break;
    }
  }
}
