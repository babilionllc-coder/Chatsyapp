import '../../../helper/all_imports.dart';
import '../controllers/deepseek_math_controller.dart';

class DeepSeekMathView extends StatelessWidget {
  const DeepSeekMathView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeepseekMathController>(
      init: DeepseekMathController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('🧮 DeepSeek Math'),
            backgroundColor: AppColors().backgroundColor1,
          ),
          backgroundColor: AppColors().backgroundColor1,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMathProblemInput(controller),
                SizedBox(height: 16.px),
                _buildMathCategories(controller),
                SizedBox(height: 16.px),
                _buildMathSolution(controller),
                SizedBox(height: 16.px),
                _buildSolutionSteps(controller),
                SizedBox(height: 16.px),
                _buildAlternativeMethods(controller),
                SizedBox(height: 16.px),
                _buildRelatedConcepts(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMathProblemInput(DeepseekMathController controller) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calculate, color: AppColors.primary, size: 24.px),
              SizedBox(width: 8.px),
              AppText(
                'Mathematical Problem Solver',
                fontSize: 18.px,
                fontWeight: FontWeight.bold,
                color: AppColors().lightTextColor,
              ),
            ],
          ),
          SizedBox(height: 16.px),
          
          // Problem Input
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
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter your mathematical problem here...\nExample: Solve x² + 5x + 6 = 0',
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
              ),
              onChanged: (value) {
                // Handle input change
              },
            ),
          ),
          
          SizedBox(height: 16.px),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : () {
                    controller.solveMathProblem(problem: controller.problemInputController.text);
                  },
                  child: Text('Solve Problem'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.px)),
                    padding: EdgeInsets.symmetric(vertical: 12.px),
                  ),
                )),
              ),
              SizedBox(width: 12.px),
              Expanded(
                child: Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : () {
                    controller.calculateExpression(expression: controller.expressionInputController.text);
                  },
                  child: Text('Calculate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.px)),
                    padding: EdgeInsets.symmetric(vertical: 12.px),
                  ),
                )),
              ),
            ],
          ),
          
          SizedBox(height: 12.px),
          
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
                      'Solving mathematical problem...',
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

  Widget _buildMathCategories(DeepseekMathController controller) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.category, color: AppColors.info, size: 24.px),
              SizedBox(width: 8.px),
              AppText(
                'Math Categories',
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
            children: controller.mathCategories.map((category) {
              return GestureDetector(
                onTap: () {
                  controller.mathTopic.value = category;
                },
                child: Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 8.px),
                  decoration: BoxDecoration(
                    color: controller.mathTopic.value == category 
                        ? AppColors.primary 
                        : AppColors().conColor,
                    borderRadius: BorderRadius.circular(20.px),
                    border: Border.all(
                      color: controller.mathTopic.value == category 
                          ? AppColors.primary 
                          : AppColors().borderColor2,
                    ),
                  ),
                  child: AppText(
                    category,
                    fontSize: 12.px,
                    color: controller.mathTopic.value == category 
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

  Widget _buildMathSolution(DeepseekMathController controller) {
    return Obx(() => controller.mathSolution.value.isNotEmpty
        ? Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.science, color: AppColors.success, size: 24.px),
                    SizedBox(width: 8.px),
                    AppText(
                      'Mathematical Solution',
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold,
                      color: AppColors().lightTextColor,
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.copy, color: AppColors.primary, size: 20.px),
                      onPressed: () => controller.copySolutionToClipboard(),
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
                  child: AppText(
                    controller.mathSolution.value,
                    fontSize: 14.px,
                    color: AppColors().lightTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                
                if (controller.finalAnswer.value.isNotEmpty) ...[
                  SizedBox(height: 16.px),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.px),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.px),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Final Answer:',
                          fontSize: 14.px,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 8.px),
                        AppText(
                          controller.finalAnswer.value,
                          fontSize: 16.px,
                          fontWeight: FontWeight.w600,
                          color: AppColors().lightTextColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          )
        : SizedBox.shrink());
  }

  Widget _buildSolutionSteps(DeepseekMathController controller) {
    return Obx(() => controller.solutionSteps.isNotEmpty
        ? Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.format_list_numbered, color: AppColors.warning, size: 24.px),
                    SizedBox(width: 8.px),
                    AppText(
                      'Step-by-Step Solution',
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold,
                      color: AppColors().lightTextColor,
                    ),
                  ],
                ),
                SizedBox(height: 16.px),
                
                ...controller.solutionSteps.asMap().entries.map((entry) {
                  int index = entry.key;
                  String step = entry.value;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.px),
                    padding: EdgeInsets.all(12.px),
                    decoration: BoxDecoration(
                      color: AppColors().conColor,
                      borderRadius: BorderRadius.circular(8.px),
                      border: Border.all(
                        color: AppColors().borderColor2,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24.px,
                          height: 24.px,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12.px),
                          ),
                          child: Center(
                            child: AppText(
                              '${index + 1}',
                              fontSize: 12.px,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.px),
                        Expanded(
                          child: AppText(
                            step,
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

  Widget _buildAlternativeMethods(DeepseekMathController controller) {
    return Obx(() => controller.alternativeMethods.isNotEmpty
        ? Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.alt_route, color: AppColors.accent, size: 24.px),
                    SizedBox(width: 8.px),
                    AppText(
                      'Alternative Methods',
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold,
                      color: AppColors().lightTextColor,
                    ),
                  ],
                ),
                SizedBox(height: 16.px),
                
                ...controller.alternativeMethods.map((method) {
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
                        Icon(Icons.lightbulb_outline, color: AppColors.accent, size: 16.px),
                        SizedBox(width: 8.px),
                        Expanded(
                          child: AppText(
                            method,
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

  Widget _buildRelatedConcepts(DeepseekMathController controller) {
    return Obx(() => controller.relatedConcepts.isNotEmpty
        ? Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.link, color: AppColors.info, size: 24.px),
                    SizedBox(width: 8.px),
                    AppText(
                      'Related Concepts',
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
                  children: controller.relatedConcepts.map((concept) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 6.px),
                      decoration: BoxDecoration(
                        color: AppColors.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16.px),
                        border: Border.all(
                          color: AppColors.info.withOpacity(0.3),
                        ),
                      ),
                      child: AppText(
                        concept,
                        fontSize: 12.px,
                        color: AppColors.info,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        : SizedBox.shrink());
  }
}
