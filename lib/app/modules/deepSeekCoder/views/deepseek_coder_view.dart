import '../../../helper/all_imports.dart';
import '../controllers/deepseek_coder_controller.dart';

class DeepSeekCoderView extends StatelessWidget {
  const DeepSeekCoderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeepSeekCoderController>(
      init: DeepSeekCoderController(),
      builder: (controller) {
        return CommonScreen(
          title: '🔬 DeepSeek Coder',
          backgroundColor: AppColors().backgroundColor1,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCodeInput(controller),
                SizedBox(height: 16.px),
                _buildLanguageSelection(controller),
                SizedBox(height: 16.px),
                _buildCodeActions(controller),
                SizedBox(height: 16.px),
                _buildGeneratedCode(controller),
                SizedBox(height: 16.px),
                _buildCodeAnalysis(controller),
                SizedBox(height: 16.px),
                _buildCodeSuggestions(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCodeInput(DeepSeekCoderController controller) {
    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: AppColors.primary, size: 24.px),
              SizedBox(width: 8.px),
              AppText(
                'Code Generation & Analysis',
                fontSize: 18.px,
                fontWeight: FontWeight.bold,
                color: AppColors().lightTextColor,
              ),
            ],
          ),
          SizedBox(height: 16.px),
          
          // Code Input
          Container(
            padding: EdgeInsets.all(12.px),
            decoration: BoxDecoration(
              color: AppColors().conColor,
              borderRadius: BorderRadius.circular(12.px),
              border: Border.all(
                color: AppColors().borderColor2,
                width: 1,
              ),
            ),
            child: TextField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Describe what code you want to generate...\nExample: Create a Flutter widget for a login form',
                hintStyle: TextStyle(
                  color: AppColors().lightTextColor.withOpacity(0.6),
                  fontSize: 14.px,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(
                color: AppColors().lightTextColor,
                fontSize: 14.px,
                fontFamily: 'monospace',
              ),
              onChanged: (value) {
                // Handle input change
              },
            ),
          ),
          
          SizedBox(height: 16.px),
          
          // Loading Indicator
          Obx(() => controller.isLoading.value
              ? Row(
                  children: [
                    SizedBox(
                      width: 16.px,
                      height: 16.px,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.px,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                    SizedBox(width: 8.px),
                    AppText(
                      'Generating code...',
                      fontSize: 14.px,
                      color: AppColors().lightTextColor.withOpacity(0.7),
                    ),
                  ],
                )
              : SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildLanguageSelection(DeepSeekCoderController controller) {
    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.language, color: AppColors.info, size: 24.px),
              SizedBox(width: 8.px),
              AppText(
                'Programming Languages',
                fontSize: 18.px,
                fontWeight: FontWeight.bold,
                color: AppColors().lightTextColor,
              ),
            ],
          ),
          SizedBox(height: 16.px),
          
          Wrap(
            spacing: 8.px,
            runSpacing: 8.px,
            children: controller.supportedLanguages.map((language) {
              return GestureDetector(
                onTap: () {
                  controller.selectedLanguage.value = language;
                },
                child: Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 8.px),
                  decoration: BoxDecoration(
                    color: controller.selectedLanguage.value == language 
                        ? AppColors.primary 
                        : AppColors().conColor,
                    borderRadius: BorderRadius.circular(20.px),
                    border: Border.all(
                      color: controller.selectedLanguage.value == language 
                          ? AppColors.primary 
                          : AppColors().borderColor2,
                    ),
                  ),
                  child: AppText(
                    language.toUpperCase(),
                    fontSize: 12.px,
                    color: controller.selectedLanguage.value == language 
                        ? AppColors.white 
                        : AppColors().lightTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeActions(DeepSeekCoderController controller) {
    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Code Actions',
            fontSize: 18.px,
            fontWeight: FontWeight.bold,
            color: AppColors().lightTextColor,
          ),
          SizedBox(height: 16.px),
          
          Row(
            children: [
              Expanded(
                child: Obx(() => CommonButton(
                  onTap: controller.isLoading.value ? null : () {
                    // Generate code
                  },
                  title: 'Generate Code',
                  buttonColor: AppColors.primary,
                  textColor: AppColors.white,
                  borderRadius: 10.px,
                  verticalPadding: 12.px,
                )),
              ),
              SizedBox(width: 8.px),
              Expanded(
                child: Obx(() => CommonButton(
                  onTap: controller.isLoading.value ? null : () {
                    // Debug code
                  },
                  title: 'Debug Code',
                  buttonColor: AppColors.warning,
                  textColor: AppColors.white,
                  borderRadius: 10.px,
                  verticalPadding: 12.px,
                )),
              ),
            ],
          ),
          
          SizedBox(height: 8.px),
          
          Row(
            children: [
              Expanded(
                child: Obx(() => CommonButton(
                  onTap: controller.isLoading.value ? null : () {
                    // Optimize code
                  },
                  title: 'Optimize',
                  buttonColor: AppColors.success,
                  textColor: AppColors.white,
                  borderRadius: 10.px,
                  verticalPadding: 12.px,
                )),
              ),
              SizedBox(width: 8.px),
              Expanded(
                child: Obx(() => CommonButton(
                  onTap: controller.isLoading.value ? null : () {
                    // Explain code
                  },
                  title: 'Explain',
                  buttonColor: AppColors.accent,
                  textColor: AppColors.white,
                  borderRadius: 10.px,
                  verticalPadding: 12.px,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratedCode(DeepSeekCoderController controller) {
    return Obx(() => controller.generatedCode.value.isNotEmpty
        ? ModernCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.code_off, color: AppColors.success, size: 24.px),
                    SizedBox(width: 8.px),
                    AppText(
                      'Generated Code',
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold,
                      color: AppColors().lightTextColor,
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.copy, color: AppColors.primary, size: 20.px),
                      onPressed: () => controller.copyCodeToClipboard(),
                    ),
                  ],
                ),
                SizedBox(height: 16.px),
                
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.px),
                  decoration: BoxDecoration(
                    color: AppColors().conColor,
                    borderRadius: BorderRadius.circular(12.px),
                    border: Border.all(
                      color: AppColors().borderColor2,
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: AppText(
                      controller.generatedCode.value,
                      fontSize: 12.px,
                      color: AppColors().lightTextColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          )
        : SizedBox.shrink());
  }

  Widget _buildCodeAnalysis(DeepSeekMathController controller) {
    return Obx(() => controller.codeMetrics.isNotEmpty
        ? ModernCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.analytics, color: AppColors.info, size: 24.px),
                    SizedBox(width: 8.px),
                    AppText(
                      'Code Analysis',
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold,
                      color: AppColors().lightTextColor,
                    ),
                  ],
                ),
                SizedBox(height: 16.px),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        'Lines of Code',
                        '${controller.codeMetrics['totalLines'] ?? 0}',
                        Icons.code,
                        AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 12.px),
                    Expanded(
                      child: _buildMetricCard(
                        'Complexity',
                        '${controller.codeMetrics['complexity'] ?? 0}',
                        Icons.trending_up,
                        AppColors.warning,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 12.px),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        'Language',
                        '${controller.codeMetrics['language'] ?? 'N/A'}',
                        Icons.language,
                        AppColors.accent,
                      ),
                    ),
                    SizedBox(width: 12.px),
                    Expanded(
                      child: _buildMetricCard(
                        'Quality',
                        '${controller.codeQuality.value}',
                        Icons.star,
                        AppColors.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : SizedBox.shrink());
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        color: AppColors().conColor,
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(
          color: AppColors().borderColor2,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20.px),
          SizedBox(height: 8.px),
          AppText(
            value,
            fontSize: 16.px,
            fontWeight: FontWeight.bold,
            color: AppColors().lightTextColor,
          ),
          SizedBox(height: 4.px),
          AppText(
            title,
            fontSize: 12.px,
            color: AppColors().lightTextColor.withOpacity(0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeSuggestions(DeepSeekCoderController controller) {
    return Obx(() => controller.codeSuggestions.isNotEmpty
        ? ModernCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: AppColors.accent, size: 24.px),
                    SizedBox(width: 8.px),
                    AppText(
                      'Code Suggestions',
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold,
                      color: AppColors().lightTextColor,
                    ),
                  ],
                ),
                SizedBox(height: 16.px),
                
                ...controller.codeSuggestions.map((suggestion) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.px),
                    padding: EdgeInsets.all(12.px),
                    decoration: BoxDecoration(
                      color: AppColors().conColor,
                      borderRadius: BorderRadius.circular(8.px),
                      border: Border.all(
                        color: AppColors().borderColor2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.tips_and_updates, color: AppColors.accent, size: 16.px),
                        SizedBox(width: 8.px),
                        Expanded(
                          child: AppText(
                            suggestion,
                            fontSize: 14.px,
                            color: AppColors().lightTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          )
        : SizedBox.shrink());
  }
}
