import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/all_imports.dart';
import '../controllers/qa_agent_controller.dart';

class QaAgentView extends StatelessWidget {
  const QaAgentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QaAgentController());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('QA Agent'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
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
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.px),
                border: Border.all(color: Colors.blue),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bug_report, color: Colors.blue, size: 24.px),
                      SizedBox(width: 8.px),
                      Text(
                        'QA Testing Status',
                        style: TextStyle(
                          fontSize: 18.px,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.px),
                  Text(
                    'Ready to perform quality assurance testing',
                    style: TextStyle(
                      fontSize: 16.px,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 16.px),
            
            // Test Categories
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
                    'Test Categories',
                    style: TextStyle(
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.px),
                  _buildTestCategory(
                    'Functional Testing',
                    'Test app functionality and features',
                    Icons.settings,
                    () => controller.runFunctionalTests(),
                  ),
                  SizedBox(height: 12.px),
                  _buildTestCategory(
                    'Performance Testing',
                    'Test app performance and speed',
                    Icons.speed,
                    () => controller.runPerformanceTests(),
                  ),
                  SizedBox(height: 12.px),
                  _buildTestCategory(
                    'Security Testing',
                    'Test app security vulnerabilities',
                    Icons.security,
                    () => controller.runSecurityTests(),
                  ),
                  SizedBox(height: 12.px),
                  _buildTestCategory(
                    'UI/UX Testing',
                    'Test user interface and experience',
                    Icons.design_services,
                    () => controller.runUITests(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 16.px),
            
            // Test Results
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
                        'Test Results',
                        style: TextStyle(
                          fontSize: 18.px,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.clearResults();
                        },
                        child: const Text('Clear Results'),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.px),
                  Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.testResults.length,
                    itemBuilder: (context, index) {
                      final result = controller.testResults[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.px),
                        padding: EdgeInsets.all(12.px),
                        decoration: BoxDecoration(
                          color: _getStatusColor(result['status'])
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.px),
                          border: Border.all(
                            color: _getStatusColor(result['status']),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  result['testName'] ?? 'Unknown Test',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.px,
                                  ),
                                ),
                                Icon(
                                  _getStatusIcon(result['status']),
                                  color: _getStatusColor(result['status']),
                                  size: 16.px,
                                ),
                              ],
                            ),
                            SizedBox(height: 4.px),
                            Text(
                              'Status: ${result['status'] ?? 'Unknown'}',
                              style: TextStyle(
                                fontSize: 12.px,
                                color: Colors.grey[600],
                              ),
                            ),
                            if (result['details'] != null) ...[
                              SizedBox(height: 4.px),
                              Text(
                                result['details'],
                                style: TextStyle(fontSize: 12.px),
                              ),
                            ],
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
  
  Widget _buildTestCategory(
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.px),
      child: Container(
        padding: EdgeInsets.all(12.px),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8.px),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 24.px),
            SizedBox(width: 12.px),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.px,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.px,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.px),
          ],
        ),
      ),
    );
  }
  
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Passed':
        return Colors.green;
      case 'Failed':
        return Colors.red;
      case 'Running':
        return Colors.blue;
      case 'Skipped':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
  
  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'Passed':
        return Icons.check_circle;
      case 'Failed':
        return Icons.error;
      case 'Running':
        return Icons.hourglass_empty;
      case 'Skipped':
        return Icons.skip_next;
      default:
        return Icons.help;
    }
  }
}