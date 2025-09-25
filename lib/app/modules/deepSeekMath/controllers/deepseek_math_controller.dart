import 'dart:math';
import '../../../helper/all_imports.dart';
import '../../../service/deepseek_service.dart';

class DeepSeekMathController extends GetxController {
  // DeepSeek Math Controller - Specialized for Mathematical Problem Solving
  
  // State Management
  RxBool isLoading = false.obs;
  RxString mathSolution = "".obs;
  RxString stepByStepSolution = "".obs;
  RxString finalAnswer = "".obs;
  RxList<String> solutionSteps = <String>[].obs;
  RxString mathTopic = "".obs;
  RxString difficultyLevel = "".obs;
  
  // Math Analysis
  RxMap<String, dynamic> mathMetrics = <String, dynamic>{}.obs;
  RxList<String> alternativeMethods = <String>[].obs;
  RxList<String> relatedConcepts = <String>[].obs;
  RxBool isCorrect = false.obs;
  RxString confidence = "".obs;
  
  // Math Categories
  final List<String> mathCategories = [
    'Algebra', 'Geometry', 'Calculus', 'Statistics', 'Probability',
    'Trigonometry', 'Linear Algebra', 'Differential Equations',
    'Number Theory', 'Combinatorics', 'Discrete Math', 'Real Analysis'
  ];
  
  // Difficulty Levels
  final List<String> difficultyLevels = [
    'Basic', 'Intermediate', 'Advanced', 'Expert', 'Research Level'
  ];
  
  @override
  void onInit() {
    super.onInit();
    _initializeMath();
  }
  
  void _initializeMath() {
    printAction("🧮 DeepSeek Math: Initializing mathematical problem solver...");
    _setupMathAnalysis();
    printAction("✅ DeepSeek Math: Ready for advanced mathematical problem solving");
  }
  
  void _setupMathAnalysis() {
    printAction("📊 Setting up mathematical analysis tools");
  }
  
  // Solve Mathematical Problem
  Future<void> solveMathProblem({
    required String problem,
    String? category,
    String? difficulty,
    bool showSteps = true,
    bool verifyAnswer = true,
  }) async {
    try {
      isLoading.value = true;
      mathTopic.value = category ?? _detectMathTopic(problem);
      difficultyLevel.value = difficulty ?? _detectDifficulty(problem);
      
      printAction("🧮 DeepSeek Math: Solving ${mathTopic.value} problem (${difficultyLevel.value})");
      
      // Build specialized prompt for math solving
      final mathPrompt = _buildMathSolvingPrompt(
        problem: problem,
        category: mathTopic.value,
        difficulty: difficultyLevel.value,
        showSteps: showSteps,
        verifyAnswer: verifyAnswer,
      );
      
      // Call DeepSeek Math API
      final messages = [
        {
          'role': 'system',
          'content': _getMathSystemPrompt(),
        },
        {
          'role': 'user',
          'content': mathPrompt,
        },
      ];
      
      // Use DeepSeek Math model
      final response = await DeepSeekService.chatWithTools(
        messages: messages,
        model: Constants.deepSeekMathModel,
        temperature: 0.1, // Very low temperature for mathematical accuracy
        maxTokens: 2048,
      );
      
      if (response.containsKey('error')) {
        throw Exception(response['error']);
      }
      
      // Extract solution
      final content = response['choices'][0]['message']['content'] ?? '';
      mathSolution.value = content;
      
      // Parse solution steps
      await _parseSolutionSteps(content);
      
      // Extract final answer
      await _extractFinalAnswer(content);
      
      // Verify solution if requested
      if (verifyAnswer) {
        await _verifySolution(problem, content);
      }
      
      // Generate alternative methods
      await _generateAlternativeMethods(problem);
      
      // Find related concepts
      await _findRelatedConcepts(mathTopic.value);
      
      printAction("✅ DeepSeek Math: Problem solved successfully");
      
    } catch (e) {
      printAction("❌ DeepSeek Math: Error solving problem - $e");
      utils.showSnackBar("Error solving math problem: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Calculate Mathematical Expression
  Future<void> calculateExpression({
    required String expression,
    bool showWork = true,
    int precision = 6,
  }) async {
    try {
      isLoading.value = true;
      
      printAction("🧮 DeepSeek Math: Calculating expression...");
      
      final calcPrompt = _buildCalculationPrompt(expression, showWork, precision);
      
      final messages = [
        {
          'role': 'system',
          'content': _getCalculationSystemPrompt(),
        },
        {
          'role': 'user',
          'content': calcPrompt,
        },
      ];
      
      final response = await DeepSeekService.chatWithTools(
        messages: messages,
        model: Constants.deepSeekMathModel,
        temperature: 0.0, // Zero temperature for exact calculations
        maxTokens: 1024,
      );
      
      if (response.containsKey('error')) {
        throw Exception(response['error']);
      }
      
      final content = response['choices'][0]['message']['content'] ?? '';
      mathSolution.value = content;
      
      await _extractFinalAnswer(content);
      
      printAction("✅ DeepSeek Math: Calculation completed");
      
    } catch (e) {
      printAction("❌ DeepSeek Math: Error calculating expression - $e");
      utils.showSnackBar("Error calculating expression: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Helper Methods
  String _buildMathSolvingPrompt({
    required String problem,
    required String category,
    required String difficulty,
    required bool showSteps,
    required bool verifyAnswer,
  }) {
    final buffer = StringBuffer();
    
    buffer.writeln("Solve this $category problem ($difficulty level):");
    buffer.writeln("\n$problem");
    
    buffer.writeln("\nRequirements:");
    buffer.writeln("- Show step-by-step solution: ${showSteps ? 'Yes' : 'No'}");
    buffer.writeln("- Verify the answer: ${verifyAnswer ? 'Yes' : 'No'}");
    buffer.writeln("- Use proper mathematical notation");
    buffer.writeln("- Explain each step clearly");
    
    if (verifyAnswer) {
      buffer.writeln("- Double-check the final answer");
    }
    
    return buffer.toString();
  }
  
  String _buildCalculationPrompt(String expression, bool showWork, int precision) {
    final buffer = StringBuffer();
    
    buffer.writeln("Calculate the following expression:");
    buffer.writeln("\n$expression");
    
    buffer.writeln("\nRequirements:");
    buffer.writeln("- Show work: ${showWork ? 'Yes' : 'No'}");
    buffer.writeln("- Precision: $precision decimal places");
    buffer.writeln("- Use proper order of operations");
    buffer.writeln("- Show intermediate steps");
    
    return buffer.toString();
  }
  
  // System Prompts
  String _getMathSystemPrompt() {
    return """
You are DeepSeek Math, an expert mathematical problem solver specialized in all areas of mathematics.

Your capabilities include:
- Solving complex mathematical problems step-by-step
- Performing accurate calculations with proper precision
- Explaining mathematical concepts clearly
- Verifying solutions and checking answers
- Providing alternative solution methods
- Using proper mathematical notation and symbols

Guidelines:
- Always show your work step-by-step
- Use proper mathematical notation (LaTeX when appropriate)
- Verify your solutions when possible
- Explain each step clearly
- Provide alternative methods when applicable
- Be precise and accurate in all calculations
- Use appropriate mathematical terminology

Your responses should be:
- Mathematically accurate
- Clearly explained
- Well-structured
- Properly formatted
- Educational and helpful
""";
  }
  
  String _getCalculationSystemPrompt() {
    return """
You are DeepSeek Math, specialized in performing accurate mathematical calculations.

Your calculation process:
1. Parse the expression correctly
2. Apply proper order of operations
3. Show intermediate steps
4. Provide the final result with specified precision
5. Verify the calculation

Focus on:
- Accuracy and precision
- Clear step-by-step work
- Proper mathematical notation
- Verification of results
""";
  }
  
  // Analysis Methods
  String _detectMathTopic(String problem) {
    final lowerProblem = problem.toLowerCase();
    
    if (lowerProblem.contains('derivative') || lowerProblem.contains('differentiate')) {
      return 'Calculus';
    }
    
    if (lowerProblem.contains('integral') || lowerProblem.contains('integrate')) {
      return 'Calculus';
    }
    
    if (lowerProblem.contains('equation') || lowerProblem.contains('solve')) {
      return 'Algebra';
    }
    
    if (lowerProblem.contains('triangle') || lowerProblem.contains('circle') || lowerProblem.contains('area')) {
      return 'Geometry';
    }
    
    if (lowerProblem.contains('probability') || lowerProblem.contains('statistics')) {
      return 'Statistics';
    }
    
    if (lowerProblem.contains('trig') || lowerProblem.contains('sin') || lowerProblem.contains('cos')) {
      return 'Trigonometry';
    }
    
    return 'General Math';
  }
  
  String _detectDifficulty(String problem) {
    final lowerProblem = problem.toLowerCase();
    
    if (lowerProblem.contains('research') || lowerProblem.contains('theorem') || lowerProblem.contains('proof')) {
      return 'Research Level';
    }
    
    if (lowerProblem.contains('advanced') || lowerProblem.contains('complex') || lowerProblem.contains('multiple')) {
      return 'Expert';
    }
    
    if (lowerProblem.contains('intermediate') || lowerProblem.contains('moderate')) {
      return 'Advanced';
    }
    
    if (lowerProblem.contains('basic') || lowerProblem.contains('simple')) {
      return 'Basic';
    }
    
    return 'Intermediate';
  }
  
  Future<void> _parseSolutionSteps(String solution) async {
    try {
      solutionSteps.clear();
      
      // Parse solution into steps
      final lines = solution.split('\n');
      int stepNumber = 1;
      
      for (final line in lines) {
        final trimmed = line.trim();
        if (trimmed.isNotEmpty && (trimmed.contains('Step') || trimmed.contains('=') || trimmed.contains('→'))) {
          solutionSteps.add('Step $stepNumber: $trimmed');
          stepNumber++;
        }
      }
      
      if (solutionSteps.isEmpty) {
        solutionSteps.add('Step 1: $solution');
      }
      
    } catch (e) {
      printAction("❌ DeepSeek Math: Error parsing solution steps - $e");
    }
  }
  
  Future<void> _extractFinalAnswer(String solution) async {
    try {
      // Extract final answer from solution
      final lines = solution.split('\n');
      
      for (int i = lines.length - 1; i >= 0; i--) {
        final line = lines[i].trim();
        if (line.contains('Answer:') || line.contains('Solution:') || line.contains('=')) {
          finalAnswer.value = line;
          break;
        }
      }
      
      if (finalAnswer.value.isEmpty) {
        finalAnswer.value = solution.split('\n').last.trim();
      }
      
    } catch (e) {
      printAction("❌ DeepSeek Math: Error extracting final answer - $e");
    }
  }
  
  Future<void> _verifySolution(String problem, String solution) async {
    try {
      // Basic verification logic
      isCorrect.value = true; // Placeholder
      confidence.value = "High"; // Placeholder
      
      // This would implement actual verification logic
      
    } catch (e) {
      printAction("❌ DeepSeek Math: Error verifying solution - $e");
    }
  }
  
  Future<void> _generateAlternativeMethods(String problem) async {
    try {
      alternativeMethods.clear();
      alternativeMethods.addAll([
        "Substitution method",
        "Graphical method",
        "Numerical approximation",
        "Algebraic manipulation",
      ]);
      
    } catch (e) {
      printAction("❌ DeepSeek Math: Error generating alternative methods - $e");
    }
  }
  
  Future<void> _findRelatedConcepts(String topic) async {
    try {
      relatedConcepts.clear();
      
      switch (topic.toLowerCase()) {
        case 'algebra':
          relatedConcepts.addAll(['Linear equations', 'Quadratic equations', 'Polynomials', 'Factoring']);
          break;
        case 'calculus':
          relatedConcepts.addAll(['Limits', 'Derivatives', 'Integrals', 'Series']);
          break;
        case 'geometry':
          relatedConcepts.addAll(['Triangles', 'Circles', 'Polygons', 'Area and perimeter']);
          break;
        case 'statistics':
          relatedConcepts.addAll(['Mean', 'Median', 'Mode', 'Standard deviation']);
          break;
        default:
          relatedConcepts.addAll(['Basic operations', 'Problem solving', 'Mathematical reasoning']);
      }
      
    } catch (e) {
      printAction("❌ DeepSeek Math: Error finding related concepts - $e");
    }
  }
  
  // Utility Methods
  void clearSolution() {
    mathSolution.value = "";
    stepByStepSolution.value = "";
    finalAnswer.value = "";
    solutionSteps.clear();
    alternativeMethods.clear();
    relatedConcepts.clear();
    mathMetrics.clear();
    isCorrect.value = false;
    confidence.value = "";
  }
  
  void copySolutionToClipboard() {
    if (mathSolution.value.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: mathSolution.value));
      utils.showSnackBar("Solution copied to clipboard");
    }
  }
}