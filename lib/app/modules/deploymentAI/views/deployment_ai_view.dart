import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/all_imports.dart';
import '../controllers/deployment_ai_controller.dart';

class DeploymentAiView extends StatelessWidget {
  const DeploymentAiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeploymentAiController());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deployment AI'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.checkApiKeys(),
          ),
        ],
      ),
      body: Obx(() => SingleChildScrollView(
        padding: EdgeInsets.all(16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.px),
              decoration: BoxDecoration(
                color: controller.allKeysConfigured.value
                    ? Colors.green.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.px),
                border: Border.all(
                  color: controller.allKeysConfigured.value
                      ? Colors.green
                      : Colors.orange,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        controller.allKeysConfigured.value
                            ? Icons.check_circle
                            : Icons.warning,
                        color: controller.allKeysConfigured.value
                            ? Colors.green
                            : Colors.orange,
                        size: 24.px,
                      ),
                      SizedBox(width: 8.px),
                      Text(
                        'Deployment Status',
                        style: TextStyle(
                          fontSize: 18.px,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.px),
                  Text(
                    controller.deploymentStatus.value,
                    style: TextStyle(
                      fontSize: 16.px,
                      color: controller.allKeysConfigured.value
                          ? Colors.green[700]
                          : Colors.orange[700],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 16.px),
            
            // API Keys Status
            Container(
              width: double.infinity,
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
                    'API Keys Status',
                    style: TextStyle(
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.px),
                  Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.apiKeyStatus.length,
                    itemBuilder: (context, index) {
                      final key = controller.apiKeyStatus.keys.elementAt(index);
                      final isConfigured = controller.apiKeyStatus[key] ?? false;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.px),
                        child: Row(
                          children: [
                            Icon(
                              isConfigured ? Icons.check_circle : Icons.error,
                              color: isConfigured ? Colors.green : Colors.red,
                              size: 16.px,
                            ),
                            SizedBox(width: 8.px),
                            Text(
                              key.toUpperCase(),
                              style: TextStyle(fontSize: 14.px),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
                ],
              ),
            ),
            
            SizedBox(height: 16.px),
            
            // Deployment Form
            Container(
              width: double.infinity,
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
                  Row(
                    children: [
                      Icon(Icons.build, color: AppColors.warning, size: 24.px),
                      SizedBox(width: 8.px),
                      Text(
                        'Deployment Options',
                        style: TextStyle(
                          fontSize: 18.px,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.px),
                  TextField(
                    controller: controller.deploymentNameController,
                    decoration: InputDecoration(
                      labelText: 'Deployment Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.px),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.px),
                  TextField(
                    controller: controller.environmentController,
                    decoration: InputDecoration(
                      labelText: 'Environment (dev/staging/prod)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.px),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.px),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  controller.startDeployment(
                                    controller.deploymentNameController.text,
                                    controller.environmentController.text,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12.px),
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('Deploy'),
                        ),
                      ),
                      SizedBox(width: 12.px),
                      if (controller.currentDeployment.isNotEmpty)
                        ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  controller.cancelDeployment();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12.px),
                          ),
                          child: const Text('Cancel'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 16.px),
            
            // Deployment History
            Container(
              width: double.infinity,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Deployment History',
                        style: TextStyle(
                          fontSize: 18.px,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.clearHistory();
                        },
                        child: const Text('Clear History'),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.px),
                  Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.deploymentHistory.length,
                    itemBuilder: (context, index) {
                      final deployment = controller.deploymentHistory[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.px),
                        padding: EdgeInsets.all(12.px),
                        decoration: BoxDecoration(
                          color: _getStatusColor(deployment['status'])
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.px),
                          border: Border.all(
                            color: _getStatusColor(deployment['status']),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  deployment['name'] ?? 'Unknown',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.px,
                                  ),
                                ),
                                Text(
                                  '${deployment['environment'] ?? 'Unknown'} - ${deployment['status'] ?? 'Unknown'}',
                                  style: TextStyle(
                                    fontSize: 12.px,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            if (deployment['status'] == 'Completed')
                              TextButton(
                                onPressed: () {
                                  controller.rollbackDeployment(
                                    deployment['id'],
                                  );
                                },
                                child: const Text('Rollback'),
                              ),
                          ],
                        ),
                      );
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
  
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Failed':
        return Colors.red;
      case 'In Progress':
        return Colors.blue;
      case 'Cancelled':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}