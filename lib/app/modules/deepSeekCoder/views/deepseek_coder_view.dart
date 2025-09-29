import 'package:flutter/material.dart';
import '../../../helper/all_imports.dart';
import '../controllers/deepseek_coder_controller.dart';

class DeepSeekCoderView extends StatelessWidget {
  const DeepSeekCoderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeepseekCoderController>(
      init: DeepseekCoderController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('🔬 DeepSeek Coder'),
            backgroundColor: AppColors().backgroundColor1,
          ),
          backgroundColor: AppColors().backgroundColor1,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCodeInput(controller),
                SizedBox(height: 16.px),
                _buildActionButtons(controller),
                SizedBox(height: 24.px),
                _buildResults(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCodeInput(DeepseekCoderController controller) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your code or description:',
              style: TextStyle(
                fontSize: 16.px,
                fontWeight: FontWeight.bold,
                color: AppColors().darkAndWhite,
              ),
            ),
            SizedBox(height: 12.px),
            TextField(
              controller: controller.codeController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Paste your code here or describe what you want to generate...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.px),
                ),
                filled: true,
                fillColor: AppColors().backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(DeepseekCoderController controller) {
    return Row(
      children: [
        Expanded(
          child: Obx(() => ElevatedButton(
            onPressed: controller.isLoading.value ? null : () {
              controller.generateCode(
                prompt: controller.codeController.text,
                language: controller.selectedLanguage.value,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(vertical: 12.px),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.px),
              ),
            ),
            child: Text('Generate Code'),
          )),
        ),
        SizedBox(width: 8.px),
        Expanded(
          child: Obx(() => ElevatedButton(
            onPressed: controller.isLoading.value ? null : () {
              controller.optimizeCode();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(vertical: 12.px),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.px),
              ),
            ),
            child: Text('Optimize Code'),
          )),
        ),
      ],
    );
  }

  Widget _buildResults(DeepseekCoderController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(16.px),
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16.px),
                Text('Processing your request...'),
              ],
            ),
          ),
        );
      }

      if (controller.generatedCode.value.isNotEmpty) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(16.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Generated Code:',
                  style: TextStyle(
                    fontSize: 16.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                SizedBox(height: 12.px),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.px),
                  decoration: BoxDecoration(
                    color: AppColors().backgroundColor,
                    borderRadius: BorderRadius.circular(8.px),
                    border: Border.all(color: AppColors().borderColor),
                  ),
                  child: SelectableText(
                    controller.generatedCode.value,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.px,
                      color: AppColors().darkAndWhite,
                    ),
                  ),
                ),
                SizedBox(height: 12.px),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Copy to clipboard
                      },
                      icon: Icon(Icons.copy),
                      label: Text('Copy'),
                    ),
                    SizedBox(width: 8.px),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Share code
                      },
                      icon: Icon(Icons.share),
                      label: Text('Share'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }

      return SizedBox.shrink();
    });
  }
}