import 'package:calling/routes/page_routes.dart';
import 'package:calling/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.bottomBar,
      getPages: AppPages.pages,
    );
  }
}
