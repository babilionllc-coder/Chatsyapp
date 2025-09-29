import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/all_imports.dart';
import '../../../service/deepseek_service.dart';

class DeepseekMathController extends GetxController {
  var isLoading = false.obs;
  var problemInputController = TextEditingController();
  var expressionInputController = TextEditingController();
  var resultController = TextEditingController();
  var mathCategories = ['Algebra', 'Geometry', 'Calculus', 'Statistics'].obs;
  var mathTopic = 'Algebra'.obs;
  var mathSolution = ''.obs;
  var finalAnswer = ''.obs;
  var solutionSteps = <String>[].obs;
  var alternativeMethods = <String>[].obs;
  var relatedConcepts = <String>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    printAction("🧮 DeepSeek Math: Initializing...");
  }

  Future<void> solveMathProblem({required String problem}) async {
    if (problem.isEmpty) {
      Get.snackbar('Error', 'Please enter a math problem.');
      return;
    }
    isLoading.value = true;
    resultController.text = 'Solving math problem...';
    try {
      final response = await DeepSeekService.chatWithTools(
        messages: [
          {'role': 'user', 'content': 'Solve this math problem step by step: $problem'}
        ],
        model: 'deepseek-math',
        tools: [],
      );
      resultController.text = response['choices'][0]['message']['content'] ?? 'Failed to solve problem.';
      printAction("✅ DeepSeek Math: Problem solved successfully.");
    } catch (e) {
      resultController.text = 'Error: $e';
      printAction("❌ DeepSeek Math: Error solving problem - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> calculateExpression({required String expression}) async {
    if (expression.isEmpty) {
      Get.snackbar('Error', 'Please enter a mathematical expression.');
      return;
    }
    isLoading.value = true;
    resultController.text = 'Calculating expression...';
    try {
      final response = await DeepSeekService.chatWithTools(
        messages: [
          {'role': 'user', 'content': 'Calculate this mathematical expression: $expression'}
        ],
        model: 'deepseek-math',
        tools: [],
      );
      resultController.text = response['choices'][0]['message']['content'] ?? 'Failed to calculate expression.';
      printAction("✅ DeepSeek Math: Expression calculated successfully.");
    } catch (e) {
      resultController.text = 'Error: $e';
      printAction("❌ DeepSeek Math: Error calculating expression - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  void copySolutionToClipboard() {
    // This would copy the solution to clipboard
    printAction("📋 DeepSeek Math: Solution copied to clipboard");
  }

  @override
  void onClose() {
    problemInputController.dispose();
    expressionInputController.dispose();
    resultController.dispose();
    super.onClose();
  }
}