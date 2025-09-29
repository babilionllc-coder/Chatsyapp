import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/all_imports.dart';
import '../../../service/deepseek_service.dart';

class DeepseekReasoningController extends GetxController {
  var isLoading = false.obs;
  var problemInputController = TextEditingController();
  var argumentInputController = TextEditingController();
  var observationInputController = TextEditingController();
  var resultController = TextEditingController();
  var reasoningType = 'Logical'.obs;
  var reasoningTypes = ['Logical', 'Analytical', 'Creative', 'Critical'].obs;
  var complexityLevel = 'Medium'.obs;
  var complexityLevels = ['Easy', 'Medium', 'Hard', 'Expert'].obs;
  var reasoningResult = ''.obs;
  var conclusion = ''.obs;
  var logicalSteps = <String>[].obs;
  var reasoningChain = <String>[].obs;
  var logicalFallacies = <String>[].obs;
  var alternativeApproaches = <String>[].obs;
  var reasoningMetrics = <String, dynamic>{}.obs;
  var reasoningQuality = 'Good'.obs;
  var confidence = 0.8.obs;

  @override
  void onInit() {
    super.onInit();
    printAction("🧠 DeepSeek Reasoning: Initializing...");
  }

  Future<void> solveReasoningProblem({required String problem}) async {
    if (problem.isEmpty) {
      Get.snackbar('Error', 'Please enter a reasoning problem.');
      return;
    }
    isLoading.value = true;
    resultController.text = 'Analyzing reasoning problem...';
    try {
      final response = await DeepSeekService.chatWithTools(
        messages: [
          {'role': 'user', 'content': 'Solve this reasoning problem step by step: $problem'}
        ],
        model: 'deepseek-reasoning',
        tools: [],
      );
      resultController.text = response['choices'][0]['message']['content'] ?? 'Failed to solve reasoning problem.';
      printAction("✅ DeepSeek Reasoning: Problem solved successfully.");
    } catch (e) {
      resultController.text = 'Error: $e';
      printAction("❌ DeepSeek Reasoning: Error solving problem - $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> analyzeArgument({required String argument}) async {
    if (argument.isEmpty) {
      Get.snackbar('Error', 'Please enter an argument to analyze.');
      return;
    }
    isLoading.value = true;
    resultController.text = 'Analyzing argument...';
    try {
      final response = await DeepSeekService.chatWithTools(
        messages: [
          {'role': 'user', 'content': 'Analyze this argument for logical structure and validity: $argument'}
        ],
        model: 'deepseek-reasoning',
        tools: [],
      );
      resultController.text = response['choices'][0]['message']['content'] ?? 'Failed to analyze argument.';
      printAction("✅ DeepSeek Reasoning: Argument analyzed successfully.");
    } catch (e) {
      resultController.text = 'Error: $e';
      printAction("❌ DeepSeek Reasoning: Error analyzing argument - $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> generateHypothesis({required String observation}) async {
    if (observation.isEmpty) {
      Get.snackbar('Error', 'Please enter an observation.');
      return;
    }
    isLoading.value = true;
    resultController.text = 'Generating hypothesis...';
    try {
      final response = await DeepSeekService.chatWithTools(
        messages: [
          {'role': 'user', 'content': 'Generate a hypothesis based on this observation: $observation'}
        ],
        model: 'deepseek-reasoning',
        tools: [],
      );
      resultController.text = response['choices'][0]['message']['content'] ?? 'Failed to generate hypothesis.';
      printAction("✅ DeepSeek Reasoning: Hypothesis generated successfully.");
    } catch (e) {
      resultController.text = 'Error: $e';
      printAction("❌ DeepSeek Reasoning: Error generating hypothesis - $e");
    } finally {
      isLoading.value = false;
    }
  }

  void clearData() {
    problemInputController.clear();
    argumentInputController.clear();
    observationInputController.clear();
    resultController.clear();
    printAction("🧠 DeepSeek Reasoning: Data cleared");
  }

  @override
  void onClose() {
    problemInputController.dispose();
    argumentInputController.dispose();
    observationInputController.dispose();
    resultController.dispose();
    super.onClose();
  }
}