import 'dart:io';

import 'package:camera/camera.dart';

import '/extension.dart';
import '../../../../main.dart';
import '../../../helper/all_imports.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';

class CameraCustomController extends GetxController {
  //TODO: Implement CameraCustomController

  // Ensure that camera is initialized before starting the app

  CameraDescription? activeCamera;

  void setCamera(CameraDescription camera) {
    activeCamera = camera;
    update();
  }

  File? imageFile;
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;
  RxString imagePath = "".obs;

  Future<void> initializeCamera() async {
    try {
      setCamera(cameras[0]);
      cameraController = CameraController(activeCamera!, ResolutionPreset.high);
      await cameraController.initialize();
      await cameraController.setFlashMode(FlashMode.off);
      await cameraController.lockCaptureOrientation(DeviceOrientation.portraitUp);

      update();
    } catch (e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    }
  }

  @override
  Future<void> onInit() async {
    initializeCamera();
    super.onInit();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    // Dispose the camera controller when the widget is disposed
    cameraController.dispose();
    super.dispose();
  }

  Future<void> takePicture() async {
    final CameraController cameraController1 = cameraController;
    if (!cameraController1.value.isInitialized) {
      // showInSnackBar('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return;
    }

    try {
      XFile? image = await cameraController.takePicture();
      imagePath.value = image.path;
      imageFile = await cropImageProcess(imagePath: imagePath.value);
      if (imageFile != null) {
        Get.back(result: imageFile?.path);
      } else {
        Get.back();
      }
      debugPrint("Image saved successfully at: $imagePath");
    } on CameraException catch (e) {
      e.log;
      // _showCameraException(e);
      return;
    }
  }
}
