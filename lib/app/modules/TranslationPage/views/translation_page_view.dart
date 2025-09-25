import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/translation_page_controller.dart';

class TranslationPageView extends GetView<TranslationPageController> {
  const TranslationPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TranslationPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TranslationPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
