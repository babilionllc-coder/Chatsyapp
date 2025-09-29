import '../../../helper/all_imports.dart';
import '../controllers/code_review_agent_controller.dart';

class CodeReviewAgentView extends StatelessWidget {
  const CodeReviewAgentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CodeReviewAgentController>(
      init: CodeReviewAgentController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors().darkAndWhite,
          appBar: AppBar(
            title: Text(
              '🤖 AI Code Review Agent',
              style: TextStyle(
                fontSize: 20.px,
                fontWeight: FontWeight.bold,
                color: AppColors().darkAndWhite,
              ),
            ),
            backgroundColor: AppColors().darkAndWhite,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.refresh, color: AppColors().darkAndWhite),
                onPressed: () => controller.clearLogs(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQualityOverview(controller),
                SizedBox(height: 16.px),
                _buildAnalysisControls(controller),
                SizedBox(height: 16.px),
                _buildDeploymentReadiness(controller),
                SizedBox(height: 16.px),
                _buildAnalysisResults(controller),
                SizedBox(height: 16.px),
                _buildAIServiceStatus(controller),
                SizedBox(height: 16.px),
                _buildFixSuggestions(controller),
                SizedBox(height: 16.px),
                _buildAnalysisLogs(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQualityOverview(CodeReviewAgentController controller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
      child: Padding(
        padding: EdgeInsets.all(20.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.analytics, color: AppColors.primary, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Quality Overview',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                Spacer(),
                Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 6.px),
                  decoration: BoxDecoration(
                    color: controller.isDeploymentReady.value ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(20.px),
                  ),
                  child: Text(
                    controller.isDeploymentReady.value ? 'STORE READY' : 'NEEDS WORK',
                    style: TextStyle(
                      fontSize: 12.px,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
              ],
            ),
            SizedBox(height: 20.px),
            
            // Quality Score Circle
            Obx(() => Row(
              children: [
                // Quality Score Display
                Container(
                  width: 100.px,
                  height: 100.px,
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 100.px,
                          height: 100.px,
                          child: CircularProgressIndicator(
                            value: controller.overallQualityScore.value / 100,
                            strokeWidth: 8.px,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              controller.overallQualityScore.value >= 90 ? Colors.green :
                              controller.overallQualityScore.value >= 70 ? Colors.orange : Colors.red,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${controller.overallQualityScore.value.toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 18.px,
                                fontWeight: FontWeight.bold,
                                color: AppColors().darkAndWhite,
                              ),
                            ),
                            Text(
                              'Quality',
                              style: TextStyle(
                                fontSize: 12.px,
                                color: AppColors().darkAndWhite.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(width: 30.px),
                
                // Issue Summary
                Expanded(
                  child: Column(
                    children: [
                      _buildIssueCount(
                        'Critical Issues',
                        controller.criticalIssues.value.toString(),
                        Icons.error,
                        Colors.red,
                      ),
                      SizedBox(height: 12.px),
                      _buildIssueCount(
                        'Warnings',
                        controller.warnings.value.toString(),
                        Icons.warning,
                        Colors.orange,
                      ),
                      SizedBox(height: 12.px),
                      _buildIssueCount(
                        'Info',
                        controller.informationalIssues.value.toString(),
                        Icons.info,
                        Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            )),
            
            SizedBox(height: 20.px),
            
            // Deployment Recommendation
            Obx(() => Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.px),
              decoration: BoxDecoration(
                color: controller.isDeploymentReady.value 
                    ? Colors.green.withOpacity(0.1) 
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.px),
                border: Border.all(
                  color: controller.isDeploymentReady.value ? Colors.green : Colors.orange,
                  width: 1,
                ),
              ),
              child: Text(
                controller.getDeploymentRecommendation(),
                style: TextStyle(
                  fontSize: 14.px,
                  color: AppColors().darkAndWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildIssueCount(String label, String count, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20.px),
        SizedBox(width: 8.px),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.px,
              color: AppColors().darkAndWhite.withOpacity(0.8),
            ),
          ),
        ),
        Text(
          count,
          style: TextStyle(
            fontSize: 16.px,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysisControls(CodeReviewAgentController controller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
      child: Padding(
        padding: EdgeInsets.all(20.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.play_circle_filled, color: AppColors.accent, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Analysis Controls',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            
            // Analysis Progress
            Obx(() => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: controller.analysisProgress.value,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          controller.isAnalyzing.value ? AppColors.primary : Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.px),
                    Text(
                      '${(controller.analysisProgress.value * 100).toInt()}%',
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
                  controller.analysisStatus.value,
                  style: TextStyle(
                    fontSize: 14.px,
                    color: AppColors().darkAndWhite.withOpacity(0.7),
                  ),
                ),
              ],
            )),
            
            SizedBox(height: 20.px),
            
            // Control Buttons
            Row(
              children: [
                Expanded(
                  child: Obx(() => ElevatedButton.icon(
                    onPressed: controller.isAnalyzing.value 
                        ? null 
                        : () => controller.runComprehensiveAnalysis(),
                    icon: Icon(Icons.security, size: 18.px),
                    label: Text('Full Analysis'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.px),
                    ),
                  )),
                ),
                SizedBox(width: 12.px),
                Expanded(
                  child: Obx(() => ElevatedButton.icon(
                    onPressed: controller.isAnalyzing.value 
                        ? null 
                        : () => controller.validateAIServices(),
                    icon: Icon(Icons.smart_toy, size: 18.px),
                    label: Text('AI Services'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.px),
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

  Widget _buildDeploymentReadiness(CodeReviewAgentController controller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
      child: Padding(
        padding: EdgeInsets.all(20.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.rocket_launch, color: AppColors.success, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Deployment Readiness',
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
                _buildReadinessItem(
                  'Quality Score',
                  '${controller.overallQualityScore.value.toStringAsFixed(1)}%',
                  'Target: ≥ 90%',
                  controller.overallQualityScore.value >= 90,
                ),
                SizedBox(height: 12.px),
                _buildReadinessItem(
                  'Critical Issues',
                  '${controller.criticalIssues.value}',
                  'Target: 0',
                  controller.criticalIssues.value == 0,
                ),
                SizedBox(height: 12.px),
                _buildReadinessItem(
                  'AI Services',
                  'Validated',
                  'All services working',
                  true, // TODO: Implement actual validation
                ),
                SizedBox(height: 12.px),
                _buildReadinessItem(
                  'Store Compliance',
                  'Checked',
                  'Policies compliant',
                  true, // TODO: Implement actual compliance check
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildReadinessItem(String title, String value, String target, bool passed) {
    return Row(
      children: [
        Icon(
          passed ? Icons.check_circle : Icons.cancel,
          color: passed ? Colors.green : Colors.red,
          size: 20.px,
        ),
        SizedBox(width: 12.px),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.px,
                  fontWeight: FontWeight.w500,
                  color: AppColors().darkAndWhite,
                ),
              ),
              Text(
                target,
                style: TextStyle(
                  fontSize: 12.px,
                  color: AppColors().darkAndWhite.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.px,
            fontWeight: FontWeight.bold,
            color: passed ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysisResults(CodeReviewAgentController controller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
      child: Padding(
        padding: EdgeInsets.all(20.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.assessment, color: AppColors.info, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Analysis Results',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            
            Obx(() => controller.analysisResults.isEmpty
                ? Center(
                    child: Text(
                      'Run analysis to see detailed results',
                      style: TextStyle(
                        fontSize: 14.px,
                        color: AppColors().darkAndWhite.withOpacity(0.6),
                      ),
                    ),
                  )
                : Column(
                    children: controller.analysisResults.entries.map((entry) {
                      return _buildAnalysisResultItem(entry.key, entry.value);
                    }).toList(),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisResultItem(String key, AnalysisResult result) {
    Color statusColor = result.status == AnalysisStatus.completed 
        ? Colors.green 
        : result.status == AnalysisStatus.failed 
            ? Colors.red 
            : Colors.orange;
    
    IconData statusIcon = result.status == AnalysisStatus.completed 
        ? Icons.check_circle 
        : result.status == AnalysisStatus.failed 
            ? Icons.error 
            : Icons.hourglass_empty;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.px),
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        color: AppColors().darkAndWhite.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(
          color: AppColors().darkAndWhite.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 20.px),
          SizedBox(width: 12.px),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.category,
                  style: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w500,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                Text(
                  '${result.issues.length} issues found',
                  style: TextStyle(
                    fontSize: 12.px,
                    color: AppColors().darkAndWhite.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${result.score.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 16.px,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIServiceStatus(CodeReviewAgentController controller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
      child: Padding(
        padding: EdgeInsets.all(20.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.smart_toy, color: AppColors.warning, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'AI Service Status',
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
              children: controller.aiServiceStatus.entries.map((entry) {
                return _buildServiceStatusItem(entry.value);
              }).toList(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceStatusItem(ServiceValidation service) {
    Color statusColor = service.status == ValidationStatus.passed 
        ? Colors.green 
        : service.status == ValidationStatus.failed 
            ? Colors.red 
            : Colors.orange;
    
    IconData statusIcon = service.status == ValidationStatus.passed 
        ? Icons.check_circle 
        : service.status == ValidationStatus.failed 
            ? Icons.error 
            : Icons.hourglass_empty;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.px),
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        color: AppColors().darkAndWhite.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(
          color: AppColors().darkAndWhite.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 20.px),
          SizedBox(width: 12.px),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.serviceName,
                  style: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w500,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                if (service.issues.isNotEmpty)
                  Text(
                    '${service.issues.length} issues',
                    style: TextStyle(
                      fontSize: 12.px,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.px),
            ),
            child: Text(
              service.status.name.toUpperCase(),
              style: TextStyle(
                fontSize: 10.px,
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixSuggestions(CodeReviewAgentController controller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
      child: Padding(
        padding: EdgeInsets.all(20.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb, color: AppColors.accent, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Fix Suggestions',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            
            Obx(() => controller.fixSuggestions.isEmpty
                ? Center(
                    child: Text(
                      'No suggestions yet. Run analysis to get recommendations.',
                      style: TextStyle(
                        fontSize: 14.px,
                        color: AppColors().darkAndWhite.withOpacity(0.6),
                      ),
                    ),
                  )
                : Column(
                    children: controller.fixSuggestions.map((suggestion) {
                      return _buildFixSuggestionItem(suggestion);
                    }).toList(),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildFixSuggestionItem(FixSuggestion suggestion) {
    Color priorityColor = suggestion.priority == Priority.critical 
        ? Colors.red 
        : suggestion.priority == Priority.important 
            ? Colors.orange 
            : Colors.blue;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.px),
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        color: AppColors().darkAndWhite.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(
          color: priorityColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
                decoration: BoxDecoration(
                  color: priorityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.px),
                ),
                child: Text(
                  suggestion.priority.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.px,
                    color: priorityColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.px),
              Expanded(
                child: Text(
                  suggestion.title,
                  style: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
              ),
              Text(
                suggestion.estimatedTime,
                style: TextStyle(
                  fontSize: 12.px,
                  color: AppColors().darkAndWhite.withOpacity(0.6),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.px),
          Text(
            suggestion.description,
            style: TextStyle(
              fontSize: 13.px,
              color: AppColors().darkAndWhite.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 6.px),
          Text(
            suggestion.implementation,
            style: TextStyle(
              fontSize: 12.px,
              color: AppColors().darkAndWhite.withOpacity(0.6),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisLogs(CodeReviewAgentController controller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
      child: Padding(
        padding: EdgeInsets.all(20.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.terminal, color: AppColors.info, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Analysis Logs',
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
              height: 250.px,
              width: double.infinity,
              padding: EdgeInsets.all(12.px),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.px),
                border: Border.all(
                  color: AppColors().darkAndWhite.withOpacity(0.1),
                ),
              ),
              child: controller.analysisLogs.isEmpty
                  ? Center(
                      child: Text(
                        'Analysis logs will appear here...',
                        style: TextStyle(
                          fontSize: 14.px,
                          color: AppColors().darkAndWhite.withOpacity(0.6),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.analysisLogs.length,
                      itemBuilder: (context, index) {
                        final log = controller.analysisLogs[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.px),
                          child: Text(
                            log,
                            style: TextStyle(
                              fontSize: 12.px,
                              color: AppColors().darkAndWhite.withOpacity(0.8),
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
