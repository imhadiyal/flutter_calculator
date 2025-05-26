import 'package:get/get.dart';

import '../controller/gst_controller.dart';

class GstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GstController>(() => GstController());
  }
}
