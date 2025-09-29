import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/all_imports.dart';

class AiAgentController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var selectedAgent = ''.obs;
  var agentList = <String>[].obs;
  var chatHistory = <Map<String, dynamic>>[].obs;
  var currentTask = ''.obs;
  var taskProgress = 0.0.obs;

  // Text controllers
  final taskInputController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _initializeAiAgent();
  }

  void _initializeAiAgent() {
    printAction("🤖 AI Agent: Initializing...");
    _loadAvailableAgents();
    _loadChatHistory();
    printAction("✅ AI Agent: Ready");
  }

  void _loadAvailableAgents() {
    agentList.value = [
      'General Assistant',
      'Code Helper',
      'Content Creator',
      'Data Analyst',
      'Problem Solver',
    ];
    selectedAgent.value = agentList.first;
  }

  void _loadChatHistory() {
    // Load previous chat history from storage
    chatHistory.clear();
  }

  void selectAgent(String agent) {
    selectedAgent.value = agent;
    addLog("Selected agent: $agent");
  }

  void startTask(String task) {
    if (task.isEmpty) return;
    
    currentTask.value = task;
    taskProgress.value = 0.0;
    isLoading.value = true;
    
    addLog("Starting task: $task");
    
    // Simulate task execution
    _executeTask(task);
  }

  void _executeTask(String task) async {
    try {
      // Simulate AI agent working on the task
      for (int i = 0; i <= 100; i += 10) {
        await Future.delayed(const Duration(milliseconds: 200));
        taskProgress.value = i / 100.0;
      }
      
      // Add completion message
      addMessage("AI Agent", "Task completed: $task");
      
    } catch (e) {
      addMessage("System", "Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void sendMessage(String message) {
    if (message.trim().isEmpty) return;
    
    addMessage("User", message);
    messageController.clear();
    
    // Simulate AI response
    _generateAiResponse(message);
  }

  void _generateAiResponse(String userMessage) async {
    isLoading.value = true;
    
    try {
      await Future.delayed(const Duration(seconds: 2));
      
      String response = "I understand your request: '$userMessage'. As your $selectedAgent, I'm here to help!";
      addMessage(selectedAgent.value, response);
      
    } catch (e) {
      addMessage("System", "Error generating response: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void addMessage(String sender, String message) {
    chatHistory.add({
      'sender': sender,
      'message': message,
      'timestamp': DateTime.now(),
    });
  }

  void addLog(String message) {
    printAction("🤖 AI Agent: $message");
  }

  void clearChat() {
    chatHistory.clear();
    addLog("Chat history cleared");
  }

  void resetTask() {
    currentTask.value = '';
    taskProgress.value = 0.0;
    addLog("Task reset");
  }

  @override
  void onClose() {
    taskInputController.dispose();
    messageController.dispose();
    super.onClose();
  }
}