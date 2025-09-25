import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class UserProfileController extends GetxController {
  final count = 0.obs;
  PermissionStatus? statusNotification;

  permissionNotification() async {
    statusNotification = await Permission.notification.status;
    update();
  }

  @override
  void onInit() {
    permissionNotification();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
