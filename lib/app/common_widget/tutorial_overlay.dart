import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/all_imports.dart';
import '../modules/tutorial/controllers/tutorial_controller.dart';

class TutorialOverlay extends StatelessWidget {
  final Widget child;

  const TutorialOverlay({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<TutorialController>();
      
      if (controller.isTutorialActive.value) {
        return Stack(
          children: [
            child,
            // Tutorial overlay content can be added here
            Container(
              color: Colors.black54,
              child: Center(
                child: Text(
                  'Tutorial Active',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ],
        );
      }
      
      return child;
    });
  }
}