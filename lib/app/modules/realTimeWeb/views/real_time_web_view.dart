import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/real_time_web_controller.dart';

class RealTimeWebView extends GetView<RealTimeWebController> {
  const RealTimeWebView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RealTimeWebView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RealTimeWebView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
