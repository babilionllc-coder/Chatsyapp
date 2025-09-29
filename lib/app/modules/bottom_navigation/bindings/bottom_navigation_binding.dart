import 'package:chatsy/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
  }
}
