import 'package:flutter/material.dart';
import '../../../helper/all_imports.dart';
import '../controllers/ai_agent_controller.dart';

class AIAgentView extends StatelessWidget {
  const AIAgentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AIAgentController>(
      init: AIAgentController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors().backgroundColor,
          appBar: AppBar(
            title: Text(
              '🤖 AI Agent Monitor',
              style: TextStyle(
                fontSize: 20.px,
                fontWeight: FontWeight.bold,
                color: AppColors().darkAndWhite,
              ),
            ),
            backgroundColor: AppColors().backgroundColor,
            elevation: 0,
            actions: [
              Obx(() => IconButton(
                icon: Icon(
                  controller.isMonitoring.value ? Icons.stop : Icons.play_arrow,
                  color: controller.isMonitoring.value ? Colors.red : Colors.green,
                ),
                onPressed: () {
                  if (controller.isMonitoring.value) {
                    controller.stopMonitoring();
                  } else {
                    controller.startMonitoring();
                  }
                },
              )),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSystemHealthCard(controller),
                SizedBox(height: 16.px),
                _buildServiceStatusCard(controller),
                SizedBox(height: 16.px),
                _buildFeatureTestsCard(controller),
                SizedBox(height: 16.px),
                _buildPerformanceCard(controller),
                SizedBox(height: 16.px),
                _buildHealthReportCard(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSystemHealthCard(AIAgentController controller) {
    return Obx(() {
      double healthScore = controller.getSystemHealthScore();
      Color healthColor = healthScore >= 80 ? Colors.green : 
                         healthScore >= 60 ? Colors.orange : Colors.red;
      
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
        child: Padding(
          padding: EdgeInsets.all(16.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.health_and_safety, color: healthColor, size: 24.px),
                  SizedBox(width: 8.px),
                  Text(
                    'System Health',
                    style: TextStyle(
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold,
                      color: AppColors().darkAndWhite,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.px),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: healthScore / 100,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(healthColor),
                    ),
                  ),
                  SizedBox(width: 12.px),
                  Text(
                    '${healthScore.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 16.px,
                      fontWeight: FontWeight.bold,
                      color: healthColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.px),
              Text(
                _getHealthStatusText(healthScore),
                style: TextStyle(
                  fontSize: 14.px,
                  color: AppColors().darkAndWhite.changeOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildServiceStatusCard(AIAgentController controller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
      child: Padding(
        padding: EdgeInsets.all(16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.cloud_done, color: AppColors.primary, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Service Status',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            Obx(() => Column(
              children: controller.serviceStatus.entries.map((entry) {
                String service = entry.key;
                ServiceStatus status = entry.value;
                Color statusColor = status.status == ServiceStatusType.healthy 
                    ? Colors.green : Colors.red;
                IconData statusIcon = status.status == ServiceStatusType.healthy 
                    ? Icons.check_circle : Icons.error;
                
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.px),
                  child: Row(
                    children: [
                      Icon(statusIcon, color: statusColor, size: 20.px),
                      SizedBox(width: 8.px),
                      Expanded(
                        child: Text(
                          status.name,
                          style: TextStyle(
                            fontSize: 14.px,
                            color: AppColors().darkAndWhite,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 2.px),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.px),
                        ),
                        child: Text(
                          status.status.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12.px,
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTestsCard(AIAgentController controller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
      child: Padding(
        padding: EdgeInsets.all(16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.science, color: AppColors.accent, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Feature Tests',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            Obx(() => Column(
              children: controller.featureTests.entries.map((entry) {
                String feature = entry.key;
                FeatureTestResult result = entry.value;
                Color statusColor = result.status == TestStatus.passed 
                    ? Colors.green : Colors.red;
                IconData statusIcon = result.status == TestStatus.passed 
                    ? Icons.check_circle : Icons.error;
                
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.px),
                  child: Row(
                    children: [
                      Icon(statusIcon, color: statusColor, size: 20.px),
                      SizedBox(width: 8.px),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              result.featureName,
                              style: TextStyle(
                                fontSize: 14.px,
                                color: AppColors().darkAndWhite,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${result.responseTime}ms',
                              style: TextStyle(
                                fontSize: 12.px,
                                color: AppColors().darkAndWhite.changeOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 2.px),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.px),
                        ),
                        child: Text(
                          result.status.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12.px,
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceCard(AIAgentController controller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
      child: Padding(
        padding: EdgeInsets.all(16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.speed, color: AppColors.info, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Performance Metrics',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            Obx(() => Row(
              children: [
                Expanded(
                  child: _buildMetricItem(
                    'Total Requests',
                    '${controller.totalRequests.value}',
                    Icons.request_page,
                    AppColors.primary,
                  ),
                ),
                Expanded(
                  child: _buildMetricItem(
                    'Successful',
                    '${controller.successfulRequests.value}',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildMetricItem(
                    'Failed',
                    '${controller.failedRequests.value}',
                    Icons.error,
                    Colors.red,
                  ),
                ),
              ],
            )),
            SizedBox(height: 16.px),
            Obx(() {
              double successRate = controller.totalRequests.value > 0 
                  ? (controller.successfulRequests.value / controller.totalRequests.value * 100)
                  : 0;
              
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      'Success Rate',
                      style: TextStyle(
                        fontSize: 14.px,
                        color: AppColors().darkAndWhite.changeOpacity(0.7),
                      ),
                    ),
                  ),
                  Text(
                    '${successRate.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 16.px,
                      fontWeight: FontWeight.bold,
                      color: successRate >= 90 ? Colors.green : 
                             successRate >= 70 ? Colors.orange : Colors.red,
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24.px),
        SizedBox(height: 4.px),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.px,
            fontWeight: FontWeight.bold,
            color: AppColors().darkAndWhite,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.px,
            color: AppColors().darkAndWhite.changeOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthReportCard(AIAgentController controller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
      child: Padding(
        padding: EdgeInsets.all(16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.assessment, color: AppColors.warning, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Health Report',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            Obx(() => Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.px),
              decoration: BoxDecoration(
                color: AppColors().darkAndWhite.changeOpacity(0.05),
                borderRadius: BorderRadius.circular(8.px),
                border: Border.all(
                  color: AppColors().darkAndWhite.changeOpacity(0.1),
                ),
              ),
              child: Text(
                controller.lastHealthReport.value.isEmpty 
                    ? 'Generating health report...' 
                    : controller.lastHealthReport.value,
                style: TextStyle(
                  fontSize: 12.px,
                  color: AppColors().darkAndWhite.changeOpacity(0.8),
                  fontFamily: 'monospace',
                ),
              ),
            )),
            SizedBox(height: 16.px),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      controller._generateHealthReport();
                    },
                    icon: Icon(Icons.refresh, size: 16.px),
                    label: Text('Refresh Report'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8.px),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      controller.testFeature('deepseek');
                    },
                    icon: Icon(Icons.play_arrow, size: 16.px),
                    label: Text('Test DeepSeek'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getHealthStatusText(double score) {
    if (score >= 90) return 'Excellent - All systems operational';
    if (score >= 80) return 'Good - Minor issues detected';
    if (score >= 60) return 'Fair - Some services need attention';
    if (score >= 40) return 'Poor - Multiple issues detected';
    return 'Critical - System requires immediate attention';
  }
}
