import 'package:flutter/material.dart';
import '../../../helper/all_imports.dart';
import '../controllers/deployment_ai_controller.dart';

class DeploymentAIView extends StatelessWidget {
  const DeploymentAIView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeploymentAIController>(
      init: DeploymentAIController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors().backgroundColor,
          appBar: AppBar(
            title: Text(
              '🤖 AI Deployment Assistant',
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
                onPressed: () => controller._checkApiKeys(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusCard(controller),
                SizedBox(height: 16.px),
                _buildApiKeysCard(controller),
                SizedBox(height: 16.px),
                _buildDeploymentCard(controller),
                SizedBox(height: 16.px),
                _buildLogsCard(controller),
                SizedBox(height: 16.px),
                _buildHistoryCard(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusCard(DeploymentAIController controller) {
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
                Icon(Icons.rocket_launch, color: AppColors.primary, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Deployment Status',
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
                        value: controller.deploymentProgress.value,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          controller.isDeploying.value ? AppColors.primary : Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.px),
                    Text(
                      '${(controller.deploymentProgress.value * 100).toInt()}%',
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
                  controller.deploymentStatus.value,
                  style: TextStyle(
                    fontSize: 14.px,
                    color: AppColors().darkAndWhite.changeOpacity(0.7),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildApiKeysCard(DeploymentAIController controller) {
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
                Icon(Icons.key, color: AppColors.accent, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'API Keys Status',
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
                    color: controller.allKeysConfigured.value ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(12.px),
                  ),
                  child: Text(
                    controller.allKeysConfigured.value ? 'READY' : 'SETUP NEEDED',
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
              children: controller.apiKeyStatus.entries.map((entry) {
                String service = entry.key;
                bool isConfigured = entry.value;
                Color statusColor = isConfigured ? Colors.green : Colors.red;
                IconData statusIcon = isConfigured ? Icons.check_circle : Icons.error;
                
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.px),
                  child: Row(
                    children: [
                      Icon(statusIcon, color: statusColor, size: 20.px),
                      SizedBox(width: 8.px),
                      Expanded(
                        child: Text(
                          service.toUpperCase(),
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
                          isConfigured ? 'CONFIGURED' : 'MISSING',
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
            SizedBox(height: 16.px),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showApiKeySetupDialog(controller),
                    icon: Icon(Icons.settings, size: 16.px),
                    label: Text('Setup API Keys'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8.px),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => controller._checkApiKeys(),
                    icon: Icon(Icons.refresh, size: 16.px),
                    label: Text('Refresh'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.info,
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

  Widget _buildDeploymentCard(DeploymentAIController controller) {
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
                Icon(Icons.deployment_unit, color: AppColors.warning, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Deployment Options',
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
                _buildDeploymentButton(
                  controller,
                  'Build Android App',
                  Icons.android,
                  AppColors.primary,
                  () => controller.buildApplication(platform: 'android'),
                ),
                SizedBox(height: 8.px),
                _buildDeploymentButton(
                  controller,
                  'Build iOS App',
                  Icons.phone_iphone,
                  AppColors.info,
                  () => controller.buildApplication(platform: 'ios'),
                ),
                SizedBox(height: 8.px),
                _buildDeploymentButton(
                  controller,
                  'Deploy to Google Play',
                  Icons.store,
                  Colors.green,
                  () => controller.deployToGooglePlay(),
                ),
                SizedBox(height: 8.px),
                _buildDeploymentButton(
                  controller,
                  'Deploy to Apple Store',
                  Icons.apple,
                  Colors.grey[800]!,
                  () => controller.deployToAppleStore(),
                ),
                SizedBox(height: 8.px),
                _buildDeploymentButton(
                  controller,
                  'Deploy to All Stores',
                  Icons.rocket_launch,
                  AppColors.accent,
                  () => controller.deployToAllStores(),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildDeploymentButton(
    DeploymentAIController controller,
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Obx(() => SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: controller.isDeploying.value ? null : onPressed,
        icon: Icon(icon, size: 16.px),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey,
        ),
      ),
    ));
  }

  Widget _buildLogsCard(DeploymentAIController controller) {
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
                Icon(Icons.list_alt, color: AppColors.success, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Deployment Logs',
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
              child: controller.deploymentLogs.isEmpty
                  ? Center(
                      child: Text(
                        'No logs yet. Start a deployment to see logs here.',
                        style: TextStyle(
                          fontSize: 14.px,
                          color: AppColors().darkAndWhite.changeOpacity(0.6),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.deploymentLogs.length,
                      itemBuilder: (context, index) {
                        final log = controller.deploymentLogs[index];
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

  Widget _buildHistoryCard(DeploymentAIController controller) {
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
                Icon(Icons.history, color: AppColors.info, size: 24.px),
                SizedBox(width: 8.px),
                Text(
                  'Deployment History',
                  style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            Obx(() => controller.deploymentHistory.isEmpty
                ? Center(
                    child: Text(
                      'No deployment history yet.',
                      style: TextStyle(
                        fontSize: 14.px,
                        color: AppColors().darkAndWhite.changeOpacity(0.6),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.deploymentHistory.length,
                    itemBuilder: (context, index) {
                      final record = controller.deploymentHistory[index];
                      return _buildHistoryItem(record);
                    },
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(DeploymentRecord record) {
    Color statusColor = record.status == 'completed' ? Colors.green : Colors.red;
    IconData statusIcon = record.status == 'completed' ? Icons.check_circle : Icons.error;
    
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
                  '${record.platform.toUpperCase()} - ${record.version}',
                  style: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                Text(
                  '${record.timestamp.toString().substring(0, 19)}',
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
              record.status.toUpperCase(),
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

  void _showApiKeySetupDialog(DeploymentAIController controller) {
    final openaiController = TextEditingController();
    final deepseekController = TextEditingController();
    final elevenlabsController = TextEditingController();
    final elevenlabsVoiceController = TextEditingController();
    final geminiController = TextEditingController();
    final youtubeController = TextEditingController();
    final weatherController = TextEditingController();
    final tavilyController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: Text('🔐 Setup API Keys'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildApiKeyField('OpenAI API Key', openaiController, 'sk-...'),
              _buildApiKeyField('DeepSeek API Key', deepseekController, 'sk-...'),
              _buildApiKeyField('ElevenLabs API Key', elevenlabsController, 'sk_...'),
              _buildApiKeyField('ElevenLabs Voice ID', elevenlabsVoiceController, 'voice_id'),
              _buildApiKeyField('Gemini API Key', geminiController, 'AI...'),
              _buildApiKeyField('YouTube API Key', youtubeController, 'AI...'),
              _buildApiKeyField('Weather API Key', weatherController, 'API key'),
              _buildApiKeyField('Tavily API Key', tavilyController, 'tvly-...'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.setupApiKeys(
                openaiKey: openaiController.text.isNotEmpty ? openaiController.text : null,
                deepseekKey: deepseekController.text.isNotEmpty ? deepseekController.text : null,
                elevenlabsKey: elevenlabsController.text.isNotEmpty ? elevenlabsController.text : null,
                elevenlabsVoiceId: elevenlabsVoiceController.text.isNotEmpty ? elevenlabsVoiceController.text : null,
                geminiKey: geminiController.text.isNotEmpty ? geminiController.text : null,
                youtubeKey: youtubeController.text.isNotEmpty ? youtubeController.text : null,
                weatherKey: weatherController.text.isNotEmpty ? weatherController.text : null,
                tavilyKey: tavilyController.text.isNotEmpty ? tavilyController.text : null,
              );
              Get.back();
            },
            child: Text('Setup Keys'),
          ),
        ],
      ),
    );
  }

  Widget _buildApiKeyField(String label, TextEditingController controller, String hint) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.px),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.px),
          ),
          isDense: true,
        ),
        obscureText: true,
      ),
    );
  }
}
