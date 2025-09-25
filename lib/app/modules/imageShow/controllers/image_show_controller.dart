import 'dart:io';

import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/image_gallery_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../../api_repository/loading.dart';

class ImageShowController extends GetxController {
  //TODO: Implement ImageShowController

  final count = 0.obs;
  RxString imageUrl = "".obs;
  RxString question = "".obs;
  RxString downloadStatus = "Idle".obs;
  RxString imagePath = "".obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      imageUrl.value = Get.arguments["imageUrl"];
      question.value = Get.arguments["question"];
    }
    super.onInit();
  }

  Future<void> downloadImage(bool isShare) async {
    try {
      // file.writeAsBytesSync(response.bodyBytes);
      printAction("Get.arguments[HttpUtil.imagePath] ${imageUrl.value}");
      Loading.show();
      var response = await Dio().get(
        imageUrl.value,
        options: Options(responseType: ResponseType.bytes),
      );
      // final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 100, name: imageUrl.value.split("/").last.split(".")[0]);

      if (Platform.isIOS) {
        await ImageGalleryHandler.saveImageToGallery(Uint8List.fromList(response.data));
        // const platform = MethodChannel('com.aichatsy.app/image');
        // await platform.invokeMethod('saveImageToGallery', Uint8List.fromList(response.data));
      } else {
        Directory? directory;

        if (Directory('/storage/emulated/0/Download').existsSync()) {
          directory = Directory('/storage/emulated/0/Download');
        } else {
          await Directory('/storage/emulated/0/Download').create();
          directory = Directory('/storage/emulated/0/Download');
        }
        String fullPath = '${directory.path}/${imageUrl.value.split("/").last}';
        File file = File(fullPath);

        if (file.existsSync()) {
          int count = 1;
          while (file.existsSync()) {
            fullPath =
                '${directory.path}/${imageUrl.value.split("/").last.split(".").first}($count).${imageUrl.value.split(".").last}';
            file = File(fullPath);
            count++;
          }
        }

        await file.writeAsBytes(response.data);

        debugPrint("-=-=-fullPath $fullPath");
      }

      Loading.dismiss();

      if (isShare) {
        final directory = await getTemporaryDirectory();
        final tempFile = File('${directory.path}/${imageUrl.value.split("/").last}');
        await tempFile.writeAsBytes(response.data);
        await Share.shareXFiles([XFile(tempFile.path)], text: 'Check out this image!');
      } else {
        utils.showToast(message: "Image downloaded successfully");
      }
    } catch (e) {
      Loading.dismiss();
      utils.showToast(message: "eorro is $e");
      printAction("eorro is $e");
    }
  }

  shareImage() {}

  void increment() => count.value++;
}
