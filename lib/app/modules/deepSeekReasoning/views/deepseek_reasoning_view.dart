import 'package:flutter/material.dart';
import '../controllers/deepseek_reasoning_controller.dart';
import '../../../helper/all_imports.dart';

class DeepSeekReasoningView extends StatelessWidget {
  const DeepSeekReasoningView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeepseekReasoningController>(
      init: DeepseekReasoningController(),
      builder: (controller) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('🧠 DeepSeek Reasoning'),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => controller.clearData(),
              tooltip: 'Clear Data',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReasoningInput(controller),
              SizedBox(height: 20.px),
              _buildReasoningOptions(controller),
              SizedBox(height: 20.px),
              _buildActionButtons(controller),
              SizedBox(height: 20.px),
              _buildReasoningResults(controller),
              SizedBox(height: 20.px),
              _buildReasoningMetrics(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReasoningInput(DeepseekReasoningController controller) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reasoning Problem',
              style: TextStyle(
                fontSize: 18.px,
                fontWeight: FontWeight.bold,
                color: Theme.of(Get.context!).primaryColor,
              ),
            ),
            SizedBox(height: 12.px),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter your reasoning problem, argument, or observation...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.px),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.px),
                  borderSide: BorderSide(
                    color: Theme.of(Get.context!).primaryColor,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) {
                // Store input for processing
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReasoningOptions(DeepseekReasoningController controller) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reasoning Options',
              style: TextStyle(
                fontSize: 18.px,
                fontWeight: FontWeight.bold,
                color: Theme.of(Get.context!).primaryColor,
              ),
            ),
            SizedBox(height: 12.px),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reasoning Type:', style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(height: 8.px),
                      DropdownButtonFormField<String>(
                        value: controller.reasoningType.value.isEmpty 
                            ? controller.reasoningTypes.first 
                            : controller.reasoningType.value,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.px),
                          ),
                        ),
                        items: controller.reasoningTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.reasoningType.value = newValue;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.px),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Complexity:', style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(height: 8.px),
                      DropdownButtonFormField<String>(
                        value: controller.complexityLevel.value.isEmpty 
                            ? controller.complexityLevels.first 
                            : controller.complexityLevel.value,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.px),
                          ),
                        ),
                        items: controller.complexityLevels.map((String level) {
                          return DropdownMenuItem<String>(
                            value: level,
                            child: Text(level),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.complexityLevel.value = newValue;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(DeepseekReasoningController controller) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: controller.isLoading.value ? null : () {
              controller.solveReasoningProblem(problem: "Sample reasoning problem");
            },
            icon: controller.isLoading.value 
                ? SizedBox(
                    width: 16.px,
                    height: 16.px,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Icon(Icons.psychology),
            label: Text('Solve Problem'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(Get.context!).primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12.px),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.px),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.px),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: controller.isLoading.value ? null : () {
              controller.analyzeArgument(argument: "Sample argument");
            },
            icon: Icon(Icons.analytics),
            label: Text('Analyze Argument'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12.px),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.px),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.px),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: controller.isLoading.value ? null : () {
              controller.generateHypothesis(observation: "Sample observation");
            },
            icon: Icon(Icons.science),
            label: Text('Generate Hypothesis'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12.px),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.px),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReasoningResults(DeepseekReasoningController controller) {
    if (controller.reasoningResult.value.isEmpty) {
      return Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16.px),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.psychology_outlined,
                  size: 64.px,
                  color: Colors.grey,
                ),
                SizedBox(height: 16.px),
                Text(
                  'Enter a reasoning problem to get started',
                  style: TextStyle(
                    fontSize: 16.px,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reasoning Results',
              style: TextStyle(
                fontSize: 18.px,
                fontWeight: FontWeight.bold,
                color: Theme.of(Get.context!).primaryColor,
              ),
            ),
            SizedBox(height: 12.px),
            if (controller.conclusion.value.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(12.px),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.px),
                  border: Border.all(color: Colors.green),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Conclusion:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    SizedBox(height: 4.px),
                    Text(controller.conclusion.value),
                  ],
                ),
              ),
              SizedBox(height: 12.px),
            ],
            if (controller.logicalSteps.value.isNotEmpty) ...[
              Text(
                'Logical Analysis:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.px,
                ),
              ),
              SizedBox(height: 8.px),
              Container(
                padding: EdgeInsets.all(12.px),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.px),
                ),
                child: Text(controller.logicalSteps.join('\n')),
              ),
              SizedBox(height: 12.px),
            ],
            if (controller.reasoningChain.isNotEmpty) ...[
              Text(
                'Reasoning Chain:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.px,
                ),
              ),
              SizedBox(height: 8.px),
              ...controller.reasoningChain.asMap().entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.px),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24.px,
                        height: 24.px,
                        decoration: BoxDecoration(
                          color: Theme.of(Get.context!).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${entry.key + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.px,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.px),
                      Expanded(
                        child: Text(entry.value),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
            if (controller.logicalFallacies.isNotEmpty) ...[
              SizedBox(height: 12.px),
              Text(
                'Logical Fallacies Detected:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.px,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 8.px),
              ...controller.logicalFallacies.map((fallacy) {
                return Container(
                  margin: EdgeInsets.only(bottom: 4.px),
                  padding: EdgeInsets.all(8.px),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4.px),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Text(fallacy),
                );
              }).toList(),
            ],
            if (controller.alternativeApproaches.isNotEmpty) ...[
              SizedBox(height: 12.px),
              Text(
                'Alternative Approaches:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.px,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 8.px),
              ...controller.alternativeApproaches.map((approach) {
                return Container(
                  margin: EdgeInsets.only(bottom: 4.px),
                  padding: EdgeInsets.all(8.px),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4.px),
                    border: Border.all(color: Colors.orange.withOpacity(0.3)),
                  ),
                  child: Text(approach),
                );
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReasoningMetrics(DeepseekReasoningController controller) {
    if (controller.reasoningMetrics.isEmpty) {
      return SizedBox.shrink();
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reasoning Quality Metrics',
              style: TextStyle(
                fontSize: 18.px,
                fontWeight: FontWeight.bold,
                color: Theme.of(Get.context!).primaryColor,
              ),
            ),
            SizedBox(height: 12.px),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    'Logical Coherence',
                    controller.reasoningMetrics['logical_coherence'] ?? 0.0,
                    Colors.blue,
                  ),
                ),
                SizedBox(width: 8.px),
                Expanded(
                  child: _buildMetricCard(
                    'Evidence Strength',
                    controller.reasoningMetrics['evidence_strength'] ?? 0.0,
                    Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.px),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    'Conclusion Validity',
                    controller.reasoningMetrics['conclusion_validity'] ?? 0.0,
                    Colors.purple,
                  ),
                ),
                SizedBox(width: 8.px),
                Expanded(
                  child: _buildMetricCard(
                    'Overall Quality',
                    controller.reasoningMetrics['reasoning_quality'] ?? 0.0,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            if (controller.reasoningQuality.value.isNotEmpty) ...[
              SizedBox(height: 12.px),
              Container(
                padding: EdgeInsets.all(12.px),
                decoration: BoxDecoration(
                  color: _getQualityColor(controller.reasoningQuality.value).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.px),
                  border: Border.all(color: _getQualityColor(controller.reasoningQuality.value)),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getQualityIcon(controller.reasoningQuality.value),
                      color: _getQualityColor(controller.reasoningQuality.value),
                    ),
                    SizedBox(width: 8.px),
                    Text(
                      'Reasoning Quality: ${controller.reasoningQuality.value}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getQualityColor(controller.reasoningQuality.value),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (controller.confidence.value > 0) ...[
              SizedBox(height: 8.px),
              Text(
                'Confidence: ${controller.confidence.value}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, double value, Color color) {
    return Container(
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.px,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.px),
          LinearProgressIndicator(
            value: value,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
          SizedBox(height: 4.px),
          Text(
            '${(value * 100).toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 12.px,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getQualityColor(String quality) {
    switch (quality.toLowerCase()) {
      case 'excellent':
        return Colors.green;
      case 'good':
        return Colors.blue;
      case 'fair':
        return Colors.orange;
      case 'poor':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getQualityIcon(String quality) {
    switch (quality.toLowerCase()) {
      case 'excellent':
        return Icons.star;
      case 'good':
        return Icons.check_circle;
      case 'fair':
        return Icons.warning;
      case 'poor':
        return Icons.error;
      default:
        return Icons.help;
    }
  }
}
