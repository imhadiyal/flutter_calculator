import 'package:calling/calculator_view/view/calculators_view.dart';
import 'package:calling/home_page/views/calculator_view.dart';
import 'package:calling/setting_page/view/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  int currentIndex = 0;

  final List<Widget> pages = [HomeView(), CalculatorView(), SettingView()];

  Future<void> changeTab(int index) async {
    currentIndex = index;

    update();
  }
}
