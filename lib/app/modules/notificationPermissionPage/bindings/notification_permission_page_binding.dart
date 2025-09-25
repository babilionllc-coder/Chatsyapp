import 'package:get/get.dart';

import '../controllers/notification_permission_page_controller.dart';

class NotificationPermissionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationPermissionPageController>(
      () => NotificationPermissionPageController(),
    );
  }
}
