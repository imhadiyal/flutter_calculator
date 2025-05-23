import 'package:calling/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomViewUi extends StatelessWidget {
  const BottomViewUi({super.key});

  Widget _buildTab({
    required int index,
    required IconData icon,
    required BottomBarController controller,
  }) {
    final bool isSelected = controller.currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
              const SizedBox(height: 5),
              Text(
                index == 0
                    ? "Home"
                    : index == 1
                    ? "Calculator"
                    : "Settings",
                style: TextStyle(color: isSelected ? Colors.blue : Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      builder: (controller) {
        return SizedBox(
          height: 50,
          width: Get.width,
          child: Row(
            children: [
              _buildTab(index: 0, icon: Icons.home, controller: controller),
              _buildTab(
                index: 1,
                icon: Icons.calculate,
                controller: controller,
              ),
              _buildTab(index: 2, icon: Icons.settings, controller: controller),
            ],
          ),
        );
      },
    );
  }
}
