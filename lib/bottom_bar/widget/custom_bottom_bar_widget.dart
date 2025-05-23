import 'package:calling/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customBottomBar({
  required int index,
  required IconData selectIcon,
  required Icon unSelectIcon,
}) {
  return Expanded(
    child: GetBuilder<BottomBarController>(
      // id: AppConstant.idBottomChangeTab,
      builder: (logic) {
        final bool isSelected = logic.currentIndex == index;
        return GestureDetector(
          onTap: () => logic.changeTab(index),
          child: Container(
            alignment: Alignment.center,
            color: isSelected ? Colors.white : Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  (isSelected ? selectIcon : unSelectIcon) as IconData?,
                  // width: 35,
                  // height: 35,
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    ),
  );
}
