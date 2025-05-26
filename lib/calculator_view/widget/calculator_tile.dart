import 'package:calling/utils/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const CalculatorTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: Get.height * 0.015),
          leading: Image.asset(
            icon,
            height: Get.height * 0.035,
            color: Colors.black,
          ),
          title: Text(title, style: TextStyle(fontSize: Get.height * 0.02)),
          trailing: Image.asset(AppAsset.rightArrow, height: Get.height * 0.02),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }
}
