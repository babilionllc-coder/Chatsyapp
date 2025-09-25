import 'package:flutter/material.dart';
import '../../../helper/all_imports.dart';
import '../controllers/qa_agent_controller.dart';

class QAAgentView extends StatelessWidget {
  const QAAgentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QAAgentController>(
      init: QAAgentController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors().backgroundColor,
          appBar: AppBar(
            title: Text(
              '🔍 AI QA Agent',
              style: TextStyle(
                fontSize: 20.px,
                fontWeight: FontWeight.bold,
                color: AppColors().darkAndWhite,
              ),
            ),
            backgroundColor: AppColors().backgroundColor,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.refresh, color: AppColors().darkAndWhite),
                onPressed: () => controller.resetTesting(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQualityScoreCard(controller),
                SizedBox(height: 16.px),
                _buildTestStatusCard(controller),
                SizedBox(height: 16.px),
                _buildTestCategoriesCard(controller),
                SizedBox(height: 16.px),
                _buildTestResultsCard(controller),
                SizedBox(height: 16.px),
                _buildLogsCard(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQualityScoreCard(QAAgentController controller) {
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
                Icon(Icons.analytics, color: AppColors.primary, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Quality Score',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                Spacer(),
                Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
                  decoration: BoxDecoration(
                    color: controller.isStoreReady.value ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(12.px),
                  ),
                  child: Text(
                    controller.isStoreReady.value ? 'STORE READY' : 'NEEDS WORK',
                    style: TextStyle(
                      fontSize: 12.px,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
              ],
            ),
            SizedBox(height: 16.px),
            Obx(() => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: controller.qualityScore.value / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          controller.qualityScore.value >= 90 ? Colors.green :
                          controller.qualityScore.value >= 70 ? Colors.orange : Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.px),
                    Text(
                      '${controller.qualityScore.value.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 16.px,
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
                      child: _buildScoreItem(
                        'Tests Passed',
                        '${controller.passedTests.value}',
                        Icons.check_circle,
                        Colors.green,
                      ),
                    ),
                    Expanded(
                      child: _buildScoreItem(
                        'Tests Failed',
                        '${controller.failedTests.value}',
                        Icons.error,
                        Colors.red,
                      ),
                    ),
                    Expanded(
                      child: _buildScoreItem(
                        'Critical Issues',
                        '${controller.criticalIssues.value}',
                        Icons.warning,
                        Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreItem(String label, String value, IconData icon, Color color) {
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

  Widget _buildTestStatusCard(QAAgentController controller) {
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
                Icon(Icons.play_circle_filled, color: AppColors.accent, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Testing Status',
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
              children: [
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: controller.testingProgress.value,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          controller.isTesting.value ? AppColors.primary : Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.px),
                    Text(
                      '${(controller.testingProgress.value * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 16.px,
                        fontWeight: FontWeight.bold,
                        color: AppColors().darkAndWhite,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.px),
                Text(
                  controller.testingStatus.value,
                  style: TextStyle(
                    fontSize: 14.px,
                    color: AppColors().darkAndWhite.changeOpacity(0.7),
                  ),
                ),
              ],
            )),
            SizedBox(height: 16.px),
            Row(
              children: [
                Expanded(
                  child: Obx(() => ElevatedButton.icon(
                    onPressed: controller.isTesting.value ? null : () => controller.runCompleteQATesting(),
                    icon: Icon(Icons.play_arrow, size: 16.px),
                    label: Text('Run All Tests'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  )),
                ),
                SizedBox(width: 8.px),
                Expanded(
                  child: Obx(() => ElevatedButton.icon(
                    onPressed: controller.isTesting.value ? () => controller.resetTesting() : null,
                    icon: Icon(Icons.stop, size: 16.px),
                    label: Text('Stop Tests'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestCategoriesCard(QAAgentController controller) {
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
                Icon(Icons.category, color: AppColors.info, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Test Categories',
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
              children: controller.testCategories.map((category) {
                return _buildCategoryItem(controller, category);
              }).toList(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(QAAgentController controller, TestCategory category) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.px),
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        color: AppColors().darkAndWhite.changeOpacity(0.05),
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(
          color: AppColors().darkAndWhite.changeOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            category.critical ? Icons.priority_high : Icons.info_outline,
            color: category.critical ? Colors.red : Colors.blue,
            size: 20.px,
          ),
          SizedBox(width: 8.px),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                Text(
                  category.description,
                  style: TextStyle(
                    fontSize: 12.px,
                    color: AppColors().darkAndWhite.changeOpacity(0.6),
                  ),
                ),
                Text(
                  '${category.tests.length} tests',
                  style: TextStyle(
                    fontSize: 12.px,
                    color: AppColors().darkAndWhite.changeOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => ElevatedButton(
            onPressed: controller.isTesting.value ? null : () => controller.runCategoryTesting(category.name),
            child: Text('Test'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              minimumSize: Size(60.px, 32.px),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTestResultsCard(QAAgentController controller) {
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
                Icon(Icons.assignment_turned_in, color: AppColors.success, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Test Results',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            Obx(() => controller.testResults.isEmpty
                ? Center(
                    child: Text(
                      'No test results yet. Run tests to see results here.',
                      style: TextStyle(
                        fontSize: 14.px,
                        color: AppColors().darkAndWhite.changeOpacity(0.6),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.testResults.length,
                    itemBuilder: (context, index) {
                      final entry = controller.testResults.entries.elementAt(index);
                      return _buildTestResultItem(entry.value);
                    },
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildTestResultItem(TestResult result) {
    Color statusColor = result.status == TestStatus.passed ? Colors.green : Colors.red;
    IconData statusIcon = result.status == TestStatus.passed ? Icons.check_circle : Icons.error;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.px),
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        color: AppColors().darkAndWhite.changeOpacity(0.05),
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(
          color: AppColors().darkAndWhite.changeOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 20.px),
          SizedBox(width: 8.px),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.testName,
                  style: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                Text(
                  result.message,
                  style: TextStyle(
                    fontSize: 12.px,
                    color: AppColors().darkAndWhite.changeOpacity(0.7),
                  ),
                ),
                Text(
                  '${result.duration}ms',
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
  }

  Widget _buildLogsCard(QAAgentController controller) {
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
                Icon(Icons.list_alt, color: AppColors.warning, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Testing Logs',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.clear, size: 20.px),
                  onPressed: () => controller.clearLogs(),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            Obx(() => Container(
              height: 200.px,
              width: double.infinity,
              padding: EdgeInsets.all(12.px),
              decoration: BoxDecoration(
                color: AppColors().darkAndWhite.changeOpacity(0.05),
                borderRadius: BorderRadius.circular(8.px),
                border: Border.all(
                  color: AppColors().darkAndWhite.changeOpacity(0.1),
                ),
              ),
              child: controller.testingLogs.isEmpty
                  ? Center(
                      child: Text(
                        'No logs yet. Start testing to see logs here.',
                        style: TextStyle(
                          fontSize: 14.px,
                          color: AppColors().darkAndWhite.changeOpacity(0.6),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.testingLogs.length,
                      itemBuilder: (context, index) {
                        final log = controller.testingLogs[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.px),
                          child: Text(
                            log,
                            style: TextStyle(
                              fontSize: 12.px,
                              color: AppColors().darkAndWhite.changeOpacity(0.8),
                              fontFamily: 'monospace',
                            ),
                          ),
                        );
                      },
                    ),
            )),
          ],
        ),
      ),
    );
  }
}
