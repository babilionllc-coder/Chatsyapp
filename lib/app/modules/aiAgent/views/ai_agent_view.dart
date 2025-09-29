import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/all_imports.dart';
import '../controllers/ai_agent_controller.dart';

class AiAgentView extends StatelessWidget {
  const AiAgentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AiAgentController());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Agent'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(() => Column(
        children: [
          // Agent Selection
          Container(
            margin: EdgeInsets.all(16.px),
            padding: EdgeInsets.all(16.px),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.px),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select AI Agent',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.px),
                Obx(() => DropdownButtonFormField<String>(
                  value: controller.selectedAgent.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.px),
                    ),
                  ),
                  items: controller.agentList.map((agent) {
                    return DropdownMenuItem(
                      value: agent,
                      child: Text(agent),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectAgent(value);
                    }
                  },
                )),
              ],
            ),
          ),
          
          // Task Input
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.px),
            padding: EdgeInsets.all(16.px),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.px),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Task',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.px),
                TextField(
                  controller: controller.taskInputController,
                  decoration: InputDecoration(
                    hintText: 'Describe what you want the AI agent to do...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.px),
                    ),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 12.px),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : () {
                      controller.startTask(controller.taskInputController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.px),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Start Task'),
                  ),
                ),
              ],
            ),
          ),
          
          // Progress Indicator
          if (controller.isLoading.value) ...[
            SizedBox(height: 16.px),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.px),
              padding: EdgeInsets.all(16.px),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.px),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Task Progress',
                    style: TextStyle(
                      fontSize: 16.px,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.px),
                  Obx(() => LinearProgressIndicator(
                    value: controller.taskProgress.value,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  )),
                  SizedBox(height: 8.px),
                  Obx(() => Text(
                    '${(controller.taskProgress.value * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 14.px,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ],
              ),
            ),
          ],
          
          // Chat History
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16.px),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.px),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.px),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chat History',
                          style: TextStyle(
                            fontSize: 18.px,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.clearChat();
                          },
                          child: const Text('Clear'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Obx(() => ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.px),
                      itemCount: controller.chatHistory.length,
                      itemBuilder: (context, index) {
                        final message = controller.chatHistory[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 12.px),
                          padding: EdgeInsets.all(12.px),
                          decoration: BoxDecoration(
                            color: message['sender'] == 'User'
                                ? AppColors.primary.withOpacity(0.1)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(8.px),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['sender'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.px,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(height: 4.px),
                              Text(
                                message['message'],
                                style: TextStyle(fontSize: 14.px),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}