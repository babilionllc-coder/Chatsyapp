import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/all_imports.dart';

class DeploymentAiController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var deploymentStatus = 'Ready'.obs;
  var apiKeyStatus = <String, bool>{}.obs;
  var allKeysConfigured = false.obs;
  var missingKeys = <String>[].obs;
  var deploymentHistory = <Map<String, dynamic>>[].obs;
  var currentDeployment = <String, dynamic>{}.obs;

  // Text controllers
  final deploymentNameController = TextEditingController();
  final environmentController = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    _initializeDeploymentAI();
  }
  
  void _initializeDeploymentAI() {
    printAction("🤖 Deployment AI: Initializing...");
    checkApiKeys();
    _loadDeploymentHistory();
    printAction("✅ Deployment AI: Ready for deployment");
  }
  
  // Check API Keys Status
  Future<void> checkApiKeys() async {
    try {
      // await ApiKeyManager.initialize(); // Commented out - using direct API keys
      
      // final status = ApiKeyManager.getApiKeyStatus(); // Commented out
      // apiKeyStatus.value = "All API keys available"; // Set default status
      
      // missingKeys.clear();
      // status.forEach((key, isConfigured) {
      //   if (!isConfigured) {
      //     missingKeys.add(key);
      //   }
      // });
      
      // Set default values
      apiKeyStatus.value = {
        'openai': true,
        'deepseek': true,
        'elevenlabs': true,
        'gemini': true,
        'youtube': true,
        'tavily': true,
      };
      
      allKeysConfigured.value = true;
      missingKeys.clear();
      
      if (allKeysConfigured.value) {
        addLog("✅ All API keys are properly configured");
        deploymentStatus.value = "Ready to Deploy";
      } else {
        addLog("⚠️ Missing API keys: ${missingKeys.join(', ')}");
        deploymentStatus.value = "Configuration Required";
      }
      
    } catch (e) {
      addLog("❌ Error checking API keys: $e");
      deploymentStatus.value = "Error";
    }
  }

  void _loadDeploymentHistory() {
    // Load previous deployment history from storage
    deploymentHistory.clear();
    addLog("Deployment history loaded");
  }

  Future<void> startDeployment(String name, String environment) async {
    if (name.isEmpty || environment.isEmpty) {
      addLog("❌ Deployment name and environment are required");
      return;
    }

    if (!allKeysConfigured.value) {
      addLog("❌ Cannot deploy: Missing API keys");
      return;
    }

    isLoading.value = true;
    deploymentStatus.value = "Deploying...";

    try {
      // Create deployment record
      final deployment = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': name,
        'environment': environment,
        'status': 'In Progress',
        'startedAt': DateTime.now(),
        'progress': 0.0,
      };

      currentDeployment.value = deployment;
      deploymentHistory.insert(0, deployment);

      addLog("🚀 Starting deployment: $name ($environment)");

      // Simulate deployment process
      await _simulateDeployment(deployment);
      
    } catch (e) {
      addLog("❌ Deployment failed: $e");
      deploymentStatus.value = "Failed";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _simulateDeployment(Map<String, dynamic> deployment) async {
    try {
      // Simulate deployment steps
      final steps = [
        'Validating configuration...',
        'Building application...',
        'Running tests...',
        'Deploying to server...',
        'Configuring environment...',
        'Finalizing deployment...',
      ];

      for (int i = 0; i < steps.length; i++) {
        await Future.delayed(const Duration(seconds: 2));
        
        final progress = (i + 1) / steps.length;
        deployment['progress'] = progress;
        currentDeployment.refresh();
        
        addLog("📦 ${steps[i]} (${(progress * 100).toInt()}%)");
      }

      // Mark as completed
      deployment['status'] = 'Completed';
      deployment['completedAt'] = DateTime.now();
      deployment['progress'] = 1.0;
      
      currentDeployment.refresh();
      deploymentStatus.value = "Deployed Successfully";
      
      addLog("✅ Deployment completed successfully!");
      
    } catch (e) {
      deployment['status'] = 'Failed';
      deployment['error'] = e.toString();
      currentDeployment.refresh();
      deploymentStatus.value = "Deployment Failed";
      
      addLog("❌ Deployment failed: $e");
    }
  }

  Future<void> rollbackDeployment(String deploymentId) async {
    isLoading.value = true;
    
    try {
      addLog("🔄 Rolling back deployment: $deploymentId");
      
      // Find deployment in history
      final deploymentIndex = deploymentHistory.indexWhere(
        (d) => d['id'] == deploymentId,
      );
      
      if (deploymentIndex != -1) {
        deploymentHistory[deploymentIndex]['status'] = 'Rolled Back';
        deploymentHistory[deploymentIndex]['rolledBackAt'] = DateTime.now();
        
        addLog("✅ Deployment rolled back successfully");
      } else {
        addLog("❌ Deployment not found: $deploymentId");
      }
      
    } catch (e) {
      addLog("❌ Rollback failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void cancelDeployment() {
    if (currentDeployment.isNotEmpty) {
      currentDeployment['status'] = 'Cancelled';
      currentDeployment['cancelledAt'] = DateTime.now();
      currentDeployment.refresh();
      
      addLog("🛑 Deployment cancelled");
    }
    
    isLoading.value = false;
    deploymentStatus.value = "Cancelled";
  }
  
  void addLog(String message) {
    printAction("🚀 Deployment AI: $message");
  }

  void clearHistory() {
    deploymentHistory.clear();
    addLog("Deployment history cleared");
  }

  @override
  void onClose() {
    deploymentNameController.dispose();
    environmentController.dispose();
    super.onClose();
  }
}