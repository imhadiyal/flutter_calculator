import 'package:calling/bottom_bar/binding/bottom_bar_binding.dart';
import 'package:calling/bottom_bar/view/bottom_bar_view.dart';
import 'package:calling/gst_calculator/binding/gst_binding.dart';
import 'package:calling/gst_calculator/view/gst_calculator_view.dart';
import 'package:calling/home_page/binding/home_binding.dart';
import 'package:calling/home_page/views/calculator_view.dart';
import 'package:calling/routes/page_routes.dart';
import 'package:calling/setting_page/binding/setting_binding.dart';
import 'package:get/get.dart';

import '../setting_page/view/setting_view.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.bottomBar,
      page: () => BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRoutes.gstCalculator,
      page: () => GstCalculatorView(),
      binding: GstBinding(),
    ),
  ];
}
