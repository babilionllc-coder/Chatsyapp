import 'dart:developer';
import '../../../helper/all_imports.dart';
import '../../../service/deepseek_service.dart';

class DeepSeekMathController extends GetxController {
  // DeepSeek Math Controller for Advanced Mathematical Problem Solving
  
  // Observable variables
  RxBool isLoading = false.obs;
  RxString solution = "".obs;
  RxString stepByStepSolution = "".obs;
  RxString mathematicalExplanation = "".obs;
  RxList<String> alternativeSolutions = <String>[].obs;
  RxString errorMessage = "".obs;
  
  // Math problem categories
  RxString selectedCategory = "general".obs;
  RxBool showSteps = true.obs;
  RxBool showVerification = true.obs;
  RxBool showAlternativeMethods = false.obs;
  
  // Available math categories
  final List<Map<String, String>> mathCategories = [
    {'value': 'general', 'label': 'General Math'},
    {'value': 'algebra', 'label': 'Algebra'},
    {'value': 'geometry', 'label': 'Geometry'},
    {'value': 'calculus', 'label': 'Calculus'},
    {'value': 'statistics', 'label': 'Statistics'},
    {'value': 'trigonometry', 'label': 'Trigonometry'},
    {'value': 'linear_algebra', 'label': 'Linear Algebra'},
    {'value': 'differential_equations', 'label': 'Differential Equations'},
    {'value': 'probability', 'label': 'Probability'},
    {'value': 'discrete_math', 'label': 'Discrete Math'},
  ];
  
  // Sample problems for each category
  final Map<String, List<String>> sampleProblems = {
    'general': [
      'Solve: 2x + 5 = 13',
      'What is 15% of 240?',
      'Find the area of a circle with radius 7 cm',
    ],
    'algebra': [
      'Solve: x² - 5x + 6 = 0',
      'Factor: 2x² + 7x + 3',
      'Solve the system: x + y = 5, 2x - y = 1',
    ],
    'geometry': [
      'Find the volume of a cylinder with radius 4 cm and height 10 cm',
      'Calculate the area of a triangle with sides 3, 4, 5',
      'Find the angle between two vectors: (1,2) and (3,4)',
    ],
    'calculus': [
      'Find the derivative of f(x) = x³ + 2x² - 5x + 1',
      'Evaluate the integral: ∫(2x + 3)dx from 0 to 2',
      'Find the limit: lim(x→0) sin(x)/x',
    ],
    'statistics': [
      'Calculate the mean, median, and mode of: 2, 4, 6, 8, 10',
      'Find the standard deviation of: 1, 3, 5, 7, 9',
      'What is the probability of rolling two sixes with two dice?',
    ],
  };
  
  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }
  
  void _initializeController() {
    printAction("🧮 DeepSeek Math: Controller initialized");
  }
  
  // Solve mathematical problem
  Future<void> solveProblem({
    required String problem,
    String? category,
    bool? showSteps,
    bool? showVerification,
    bool? showAlternativeMethods,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      
      // Use provided parameters or defaults
      final selectedCat = category ?? selectedCategory.value;
      final withSteps = showSteps ?? this.showSteps.value;
      final withVerification = showVerification ?? this.showVerification.value;
      final withAlternatives = showAlternativeMethods ?? this.showAlternativeMethods.value;
      
      printAction("🧮 DeepSeek Math: Solving $selectedCat problem...");
      
      // Build enhanced prompt
      String enhancedPrompt = _buildEnhancedPrompt(
        problem,
        selectedCat,
        withSteps,
        withVerification,
        withAlternatives,
      );
      
      // Solve problem using DeepSeek Math
      final mathSolution = await DeepSeekService.solveMath(
        problem: enhancedPrompt,
        model: Constants.deepSeekMathModel,
        temperature: 0.1, // Low temperature for accurate math
        maxTokens: 1024,
      );
      
      if (mathSolution.contains('Error:')) {
        errorMessage.value = mathSolution;
        solution.value = "";
      } else {
        solution.value = mathSolution;
        await _generateStepByStepSolution(problem, selectedCat);
        await _generateMathematicalExplanation(problem, mathSolution);
        
        if (withAlternatives) {
          await _generateAlternativeSolutions(problem, selectedCat);
        }
      }
      
      printAction("✅ DeepSeek Math: Problem solved");
      
    } catch (e) {
      errorMessage.value = "Error solving problem: $e";
      printAction("❌ DeepSeek Math: Error - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Build enhanced prompt for math solving
  String _buildEnhancedPrompt(
    String problem,
    String category,
    bool showSteps,
    bool showVerification,
    bool showAlternativeMethods,
  ) {
    StringBuffer enhancedPrompt = StringBuffer();
    
    enhancedPrompt.writeln("Solve this $category problem:");
    enhancedPrompt.writeln(problem);
    enhancedPrompt.writeln();
    
    enhancedPrompt.writeln("Requirements:");
    if (showSteps) {
      enhancedPrompt.writeln("- Show step-by-step solution with clear explanations");
    }
    if (showVerification) {
      enhancedPrompt.writeln("- Verify the answer and show the verification process");
    }
    if (showAlternativeMethods) {
      enhancedPrompt.writeln("- Provide alternative solution methods if applicable");
    }
    
    enhancedPrompt.writeln("- Use proper mathematical notation and formatting");
    enhancedPrompt.writeln("- Explain each step clearly and concisely");
    enhancedPrompt.writeln("- Include units and final answer");
    
    return enhancedPrompt.toString();
  }
  
  // Generate step-by-step solution
  Future<void> _generateStepByStepSolution(String problem, String category) async {
    try {
      printAction("📝 DeepSeek Math: Generating step-by-step solution...");
      
      final stepSolution = await DeepSeekService.solveMath(
        problem: "Provide a detailed step-by-step solution for this $category problem:\n\n$problem\n\nBreak down each step clearly.",
        model: Constants.deepSeekMathModel,
        temperature: 0.1,
        maxTokens: 1024,
      );
      
      if (!stepSolution.contains('Error:')) {
        stepByStepSolution.value = stepSolution;
      }
      
    } catch (e) {
      printAction("❌ DeepSeek Math: Step solution error - $e");
    }
  }
  
  // Generate mathematical explanation
  Future<void> _generateMathematicalExplanation(String problem, String solution) async {
    try {
      printAction("📚 DeepSeek Math: Generating mathematical explanation...");
      
      final explanation = await DeepSeekService.solveMath(
        problem: "Explain the mathematical concepts and principles used in solving this problem:\n\nProblem: $problem\n\nSolution: $solution",
        model: Constants.deepSeekMathModel,
        temperature: 0.3,
        maxTokens: 512,
      );
      
      if (!explanation.contains('Error:')) {
        mathematicalExplanation.value = explanation;
      }
      
    } catch (e) {
      printAction("❌ DeepSeek Math: Explanation error - $e");
    }
  }
  
  // Generate alternative solutions
  Future<void> _generateAlternativeSolutions(String problem, String category) async {
    try {
      printAction("🔄 DeepSeek Math: Generating alternative solutions...");
      
      final alternatives = await DeepSeekService.solveMath(
        problem: "Provide alternative methods to solve this $category problem:\n\n$problem\n\nShow different approaches and explain when each method is most appropriate.",
        model: Constants.deepSeekMathModel,
        temperature: 0.3,
        maxTokens: 1024,
      );
      
      if (!alternatives.contains('Error:')) {
        // Parse alternatives into list
        List<String> alternativeList = alternatives
            .split('\n')
            .where((line) => line.trim().isNotEmpty)
            .map((line) => line.trim())
            .toList();
        
        alternativeSolutions.value = alternativeList;
      }
      
    } catch (e) {
      printAction("❌ DeepSeek Math: Alternatives error - $e");
    }
  }
  
  // Calculate with advanced functions
  Future<void> calculateAdvanced({
    required String expression,
    String operation = 'evaluate',
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      
      printAction("🔢 DeepSeek Math: Advanced calculation...");
      
      String prompt = "";
      switch (operation.toLowerCase()) {
        case 'evaluate':
          prompt = "Evaluate this mathematical expression: $expression";
          break;
        case 'simplify':
          prompt = "Simplify this mathematical expression: $expression";
          break;
        case 'factor':
          prompt = "Factor this expression: $expression";
          break;
        case 'expand':
          prompt = "Expand this expression: $expression";
          break;
        case 'solve':
          prompt = "Solve this equation: $expression";
          break;
        default:
          prompt = "Calculate: $expression";
      }
      
      final result = await DeepSeekService.solveMath(
        problem: prompt,
        model: Constants.deepSeekMathModel,
        temperature: 0.1,
        maxTokens: 512,
      );
      
      if (result.contains('Error:')) {
        errorMessage.value = result;
      } else {
        solution.value = result;
      }
      
    } catch (e) {
      errorMessage.value = "Error in calculation: $e";
      printAction("❌ DeepSeek Math: Calculation error - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Graph analysis
  Future<void> analyzeGraph(String graphDescription) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      
      printAction("📈 DeepSeek Math: Analyzing graph...");
      
      final analysis = await DeepSeekService.solveMath(
        problem: "Analyze this graph and provide mathematical insights:\n\n$graphDescription\n\nInclude: domain, range, intercepts, asymptotes, critical points, and behavior.",
        model: Constants.deepSeekMathModel,
        temperature: 0.2,
        maxTokens: 1024,
      );
      
      if (analysis.contains('Error:')) {
        errorMessage.value = analysis;
      } else {
        solution.value = analysis;
      }
      
    } catch (e) {
      errorMessage.value = "Error analyzing graph: $e";
      printAction("❌ DeepSeek Math: Graph analysis error - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Get sample problems for category
  List<String> getSampleProblems(String category) {
    return sampleProblems[category] ?? sampleProblems['general']!;
  }
  
  // Load sample problem
  void loadSampleProblem(String problem) {
    // This would typically be called from the UI
    solveProblem(problem: problem);
  }
  
  // Clear all data
  void clearData() {
    solution.value = "";
    stepByStepSolution.value = "";
    mathematicalExplanation.value = "";
    alternativeSolutions.clear();
    errorMessage.value = "";
  }
  
  // Update category selection
  void updateCategory(String category) {
    selectedCategory.value = category;
    printAction("🧮 DeepSeek Math: Category updated to $category");
  }
  
  // Toggle options
  void toggleSteps() => showSteps.value = !showSteps.value;
  void toggleVerification() => showVerification.value = !showVerification.value;
  void toggleAlternatives() => showAlternativeMethods.value = !showAlternativeMethods.value;
}
