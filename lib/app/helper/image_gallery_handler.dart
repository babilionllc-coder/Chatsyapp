import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ImageGalleryHandler {
  static const MethodChannel _channel = MethodChannel('com.aichatsy.app/image_gallery');

  static Future<bool> saveImageToGallery(Uint8List imageData) async {
    try {
      final bool result = await _channel.invokeMethod('saveImageToGallery', {
        'imageData': imageData,
      });
      return result;
    } on PlatformException catch (e) {
      debugPrint('Error saving image to gallery: ${e.message}');
      return false;
    }
  }
}
