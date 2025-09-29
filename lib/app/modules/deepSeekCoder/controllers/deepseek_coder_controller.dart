import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/all_imports.dart';
import '../../../service/deepseek_service.dart';

class DeepseekCoderController extends GetxController {
  var isLoading = false.obs;
  var codeInputController = TextEditingController();
  var codeController = TextEditingController();
  var outputController = TextEditingController();
  var selectedLanguage = 'Dart'.obs;
  var languages = ['Dart', 'Python', 'JavaScript', 'Java', 'C++', 'Go', 'Rust'].obs;
  var generatedCode = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    printAction("💻 DeepSeek Coder: Initializing...");
  }

  Future<void> generateCode({required String prompt, required String language}) async {
    if (prompt.isEmpty) {
      Get.snackbar('Error', 'Please enter a code generation prompt.');
      return;
    }
    isLoading.value = true;
    outputController.text = 'Generating code...';
    try {
      final response = await DeepSeekService.chatWithTools(
        messages: [
          {'role': 'user', 'content': 'Generate $language code for: $prompt'}
        ],
        model: 'deepseek-coder',
        tools: [],
      );
      final code = response['choices'][0]['message']['content'] ?? 'Failed to generate code.';
      outputController.text = code;
      generatedCode.value = code;
      printAction("✅ DeepSeek Coder: Code generated successfully.");
    } catch (e) {
      outputController.text = 'Error: $e';
      printAction("❌ DeepSeek Coder: Error generating code - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> debugCode({required String code, required String language}) async {
    if (code.isEmpty) {
      Get.snackbar('Error', 'Please enter code to debug.');
      return;
    }
    isLoading.value = true;
    outputController.text = 'Debugging code...';
    try {
      final response = await DeepSeekService.chatWithTools(
        messages: [
          {'role': 'user', 'content': 'Debug this $language code and explain any issues: $code'}
        ],
        model: 'deepseek-coder',
        tools: [],
      );
      outputController.text = response['choices'][0]['message']['content'] ?? 'Failed to debug code.';
      printAction("✅ DeepSeek Coder: Code debugged successfully.");
    } catch (e) {
      outputController.text = 'Error: $e';
      printAction("❌ DeepSeek Coder: Error debugging code - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> refactorCode({required String code, required String language}) async {
    if (code.isEmpty) {
      Get.snackbar('Error', 'Please enter code to refactor.');
      return;
    }
      isLoading.value = true;
    outputController.text = 'Refactoring code...';
    try {
      final response = await DeepSeekService.chatWithTools(
        messages: [
          {'role': 'user', 'content': 'Refactor this $language code for better readability and performance: $code'}
        ],
        model: 'deepseek-coder',
        tools: [],
      );
      outputController.text = response['choices'][0]['message']['content'] ?? 'Failed to refactor code.';
      printAction("✅ DeepSeek Coder: Code refactored successfully.");
    } catch (e) {
      outputController.text = 'Error: $e';
      printAction("❌ DeepSeek Coder: Error refactoring code - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> optimizeCode() async {
    if (codeController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter code to optimize.');
      return;
    }
    isLoading.value = true;
    outputController.text = 'Optimizing code...';
    try {
      final response = await DeepSeekService.chatWithTools(
        messages: [
          {'role': 'user', 'content': 'Optimize this code for better performance and readability: ${codeController.text}'}
        ],
        model: 'deepseek-coder',
        tools: [],
      );
      final code = response['choices'][0]['message']['content'] ?? 'Failed to optimize code.';
      outputController.text = code;
      generatedCode.value = code;
      printAction("✅ DeepSeek Coder: Code optimized successfully.");
    } catch (e) {
      outputController.text = 'Error: $e';
      printAction("❌ DeepSeek Coder: Error optimizing code - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  @override
  void onClose() {
    codeInputController.dispose();
    codeController.dispose();
    outputController.dispose();
    super.onClose();
  }
}