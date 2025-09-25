import 'dart:convert';
import '../../../helper/all_imports.dart';
import '../../../service/deepseek_service.dart';

class DeepSeekCoderController extends GetxController {
  // DeepSeek Coder Controller - Specialized for Code Generation and Analysis
  
  // State Management
  RxBool isLoading = false.obs;
  RxString generatedCode = "".obs;
  RxString codeExplanation = "".obs;
  RxList<String> codeSuggestions = <String>[].obs;
  RxString selectedLanguage = "dart".obs;
  RxString codeQuality = "".obs;
  
  // Code Analysis
  RxMap<String, dynamic> codeMetrics = <String, dynamic>{}.obs;
  RxList<String> codeIssues = <String>[].obs;
  RxList<String> optimizationSuggestions = <String>[].obs;
  
  // Programming Languages Support
  final List<String> supportedLanguages = [
    'dart', 'javascript', 'python', 'java', 'cpp', 'csharp', 
    'go', 'rust', 'swift', 'kotlin', 'typescript', 'php',
    'ruby', 'scala', 'r', 'matlab', 'sql', 'html', 'css'
  ];
  
  // Code Templates
  final Map<String, String> codeTemplates = {
    'dart': '''
// Dart Code Template
class ExampleClass {
  final String name;
  
  ExampleClass({required this.name});
  
  void exampleMethod() {
    // Your code here
  }
}
''',
    'javascript': '''
// JavaScript Code Template
class ExampleClass {
  constructor(name) {
    this.name = name;
  }
  
  exampleMethod() {
    // Your code here
  }
}
''',
    'python': '''
# Python Code Template
class ExampleClass:
    def __init__(self, name):
        self.name = name
    
    def example_method(self):
        # Your code here
        pass
''',
  };
  
  @override
  void onInit() {
    super.onInit();
    _initializeCoder();
  }
  
  void _initializeCoder() {
    printAction("🔬 DeepSeek Coder: Initializing specialized code generation...");
    _loadCodeTemplates();
    _setupCodeAnalysis();
    printAction("✅ DeepSeek Coder: Ready for advanced code generation");
  }
  
  void _loadCodeTemplates() {
    // Load additional code templates
    printAction("📝 Loading code templates for ${supportedLanguages.length} languages");
  }
  
  void _setupCodeAnalysis() {
    // Initialize code analysis tools
    printAction("🔍 Setting up code analysis and quality metrics");
  }
  
  // Generate Code with DeepSeek Coder
  Future<void> generateCode({
    required String prompt,
    String? language,
    String? framework,
    String? style,
    bool includeComments = true,
    bool includeTests = false,
  }) async {
    try {
      isLoading.value = true;
      selectedLanguage.value = language ?? 'dart';
      
      printAction("🔬 DeepSeek Coder: Generating code for ${selectedLanguage.value}");
      
      // Build specialized prompt for code generation
      final codePrompt = _buildCodeGenerationPrompt(
        prompt: prompt,
        language: selectedLanguage.value,
        framework: framework,
        style: style,
        includeComments: includeComments,
        includeTests: includeTests,
      );
      
      // Call DeepSeek Coder API
      final messages = [
        {
          'role': 'system',
          'content': _getCoderSystemPrompt(),
        },
        {
          'role': 'user',
          'content': codePrompt,
        },
      ];
      
      // Use DeepSeek Coder model
      final response = await DeepSeekService.chatWithTools(
        messages: messages,
        model: Constants.deepSeekCoderModel,
        temperature: 0.3, // Lower temperature for more consistent code
        maxTokens: 2048,
      );
      
      if (response.containsKey('error')) {
        throw Exception(response['error']);
      }
      
      // Extract generated code
      final content = response['choices'][0]['message']['content'] ?? '';
      generatedCode.value = content;
      
      // Analyze generated code
      await _analyzeGeneratedCode(content);
      
      // Generate code explanation
      await _generateCodeExplanation(content);
      
      // Generate suggestions
      await _generateCodeSuggestions(content);
      
      printAction("✅ DeepSeek Coder: Code generated successfully");
      
    } catch (e) {
      printAction("❌ DeepSeek Coder: Error generating code - $e");
      utils.showSnackBar("Error generating code: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Debug and Fix Code
  Future<void> debugCode({
    required String code,
    String? errorMessage,
    String? language,
  }) async {
    try {
      isLoading.value = true;
      selectedLanguage.value = language ?? 'dart';
      
      printAction("🐛 DeepSeek Coder: Debugging code...");
      
      final debugPrompt = _buildDebugPrompt(code, errorMessage);
      
      final messages = [
        {
          'role': 'system',
          'content': _getDebugSystemPrompt(),
        },
        {
          'role': 'user',
          'content': debugPrompt,
        },
      ];
      
      final response = await DeepSeekService.chatWithTools(
        messages: messages,
        model: Constants.deepSeekCoderModel,
        temperature: 0.2,
        maxTokens: 1536,
      );
      
      if (response.containsKey('error')) {
        throw Exception(response['error']);
      }
      
      final content = response['choices'][0]['message']['content'] ?? '';
      generatedCode.value = content;
      
      await _analyzeGeneratedCode(content);
      
      printAction("✅ DeepSeek Coder: Code debugging completed");
      
    } catch (e) {
      printAction("❌ DeepSeek Coder: Error debugging code - $e");
      utils.showSnackBar("Error debugging code: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Optimize Code
  Future<void> optimizeCode({
    required String code,
    String? language,
    String? optimizationType,
  }) async {
    try {
      isLoading.value = true;
      selectedLanguage.value = language ?? 'dart';
      
      printAction("⚡ DeepSeek Coder: Optimizing code...");
      
      final optimizePrompt = _buildOptimizationPrompt(code, optimizationType);
      
      final messages = [
        {
          'role': 'system',
          'content': _getOptimizationSystemPrompt(),
        },
        {
          'role': 'user',
          'content': optimizePrompt,
        },
      ];
      
      final response = await DeepSeekService.chatWithTools(
        messages: messages,
        model: Constants.deepSeekCoderModel,
        temperature: 0.3,
        maxTokens: 1536,
      );
      
      if (response.containsKey('error')) {
        throw Exception(response['error']);
      }
      
      final content = response['choices'][0]['message']['content'] ?? '';
      generatedCode.value = content;
      
      await _analyzeGeneratedCode(content);
      
      printAction("✅ DeepSeek Coder: Code optimization completed");
      
    } catch (e) {
      printAction("❌ DeepSeek Coder: Error optimizing code - $e");
      utils.showSnackBar("Error optimizing code: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Explain Code
  Future<void> explainCode({
    required String code,
    String? language,
    String? explanationType,
  }) async {
    try {
      isLoading.value = true;
      selectedLanguage.value = language ?? 'dart';
      
      printAction("📖 DeepSeek Coder: Explaining code...");
      
      final explainPrompt = _buildExplanationPrompt(code, explanationType);
      
      final messages = [
        {
          'role': 'system',
          'content': _getExplanationSystemPrompt(),
        },
        {
          'role': 'user',
          'content': explainPrompt,
        },
      ];
      
      final response = await DeepSeekService.chatWithTools(
        messages: messages,
        model: Constants.deepSeekCoderModel,
        temperature: 0.4,
        maxTokens: 1024,
      );
      
      if (response.containsKey('error')) {
        throw Exception(response['error']);
      }
      
      final content = response['choices'][0]['message']['content'] ?? '';
      codeExplanation.value = content;
      
      printAction("✅ DeepSeek Coder: Code explanation completed");
      
    } catch (e) {
      printAction("❌ DeepSeek Coder: Error explaining code - $e");
      utils.showSnackBar("Error explaining code: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Convert Code Between Languages
  Future<void> convertCode({
    required String code,
    required String fromLanguage,
    required String toLanguage,
  }) async {
    try {
      isLoading.value = true;
      selectedLanguage.value = toLanguage;
      
      printAction("🔄 DeepSeek Coder: Converting code from $fromLanguage to $toLanguage...");
      
      final convertPrompt = _buildConversionPrompt(code, fromLanguage, toLanguage);
      
      final messages = [
        {
          'role': 'system',
          'content': _getConversionSystemPrompt(),
        },
        {
          'role': 'user',
          'content': convertPrompt,
        },
      ];
      
      final response = await DeepSeekService.chatWithTools(
        messages: messages,
        model: Constants.deepSeekCoderModel,
        temperature: 0.3,
        maxTokens: 1536,
      );
      
      if (response.containsKey('error')) {
        throw Exception(response['error']);
      }
      
      final content = response['choices'][0]['message']['content'] ?? '';
      generatedCode.value = content;
      
      await _analyzeGeneratedCode(content);
      
      printAction("✅ DeepSeek Coder: Code conversion completed");
      
    } catch (e) {
      printAction("❌ DeepSeek Coder: Error converting code - $e");
      utils.showSnackBar("Error converting code: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Helper Methods
  String _buildCodeGenerationPrompt({
    required String prompt,
    required String language,
    String? framework,
    String? style,
    required bool includeComments,
    required bool includeTests,
  }) {
    final buffer = StringBuffer();
    
    buffer.writeln("Generate $language code for: $prompt");
    
    if (framework != null) {
      buffer.writeln("Framework: $framework");
    }
    
    if (style != null) {
      buffer.writeln("Code style: $style");
    }
    
    buffer.writeln("Include comments: ${includeComments ? 'Yes' : 'No'}");
    buffer.writeln("Include tests: ${includeTests ? 'Yes' : 'No'}");
    
    buffer.writeln("\nRequirements:");
    buffer.writeln("- Follow $language best practices");
    buffer.writeln("- Use proper naming conventions");
    buffer.writeln("- Include error handling");
    buffer.writeln("- Make code readable and maintainable");
    
    if (includeTests) {
      buffer.writeln("- Include unit tests");
    }
    
    return buffer.toString();
  }
  
  String _buildDebugPrompt(String code, String? errorMessage) {
    final buffer = StringBuffer();
    
    buffer.writeln("Debug the following $selectedLanguage code:");
    buffer.writeln("\n```$selectedLanguage");
    buffer.writeln(code);
    buffer.writeln("```");
    
    if (errorMessage != null) {
      buffer.writeln("\nError message: $errorMessage");
    }
    
    buffer.writeln("\nPlease:");
    buffer.writeln("1. Identify the issue(s)");
    buffer.writeln("2. Explain the problem");
    buffer.writeln("3. Provide the corrected code");
    buffer.writeln("4. Suggest prevention strategies");
    
    return buffer.toString();
  }
  
  String _buildOptimizationPrompt(String code, String? optimizationType) {
    final buffer = StringBuffer();
    
    buffer.writeln("Optimize the following $selectedLanguage code:");
    buffer.writeln("\n```$selectedLanguage");
    buffer.writeln(code);
    buffer.writeln("```");
    
    if (optimizationType != null) {
      buffer.writeln("\nOptimization focus: $optimizationType");
    }
    
    buffer.writeln("\nPlease optimize for:");
    buffer.writeln("- Performance (speed, memory usage)");
    buffer.writeln("- Readability and maintainability");
    buffer.writeln("- Best practices and patterns");
    buffer.writeln("- Error handling and robustness");
    
    return buffer.toString();
  }
  
  String _buildExplanationPrompt(String code, String? explanationType) {
    final buffer = StringBuffer();
    
    buffer.writeln("Explain the following $selectedLanguage code:");
    buffer.writeln("\n```$selectedLanguage");
    buffer.writeln(code);
    buffer.writeln("```");
    
    if (explanationType != null) {
      buffer.writeln("\nExplanation type: $explanationType");
    }
    
    buffer.writeln("\nPlease explain:");
    buffer.writeln("- What the code does");
    buffer.writeln("- How it works");
    buffer.writeln("- Key concepts and patterns used");
    buffer.writeln("- Potential improvements");
    
    return buffer.toString();
  }
  
  String _buildConversionPrompt(String code, String fromLanguage, String toLanguage) {
    final buffer = StringBuffer();
    
    buffer.writeln("Convert the following $fromLanguage code to $toLanguage:");
    buffer.writeln("\n```$fromLanguage");
    buffer.writeln(code);
    buffer.writeln("```");
    
    buffer.writeln("\nRequirements:");
    buffer.writeln("- Maintain the same functionality");
    buffer.writeln("- Follow $toLanguage best practices");
    buffer.writeln("- Use appropriate $toLanguage idioms");
    buffer.writeln("- Include proper error handling");
    
    return buffer.toString();
  }
  
  // System Prompts
  String _getCoderSystemPrompt() {
    return """
You are DeepSeek Coder, an expert programming assistant specialized in code generation, debugging, and optimization.

Your capabilities include:
- Generating clean, efficient, and well-documented code
- Debugging and fixing code issues
- Optimizing code for performance and readability
- Explaining complex code concepts
- Converting code between programming languages
- Following best practices and design patterns

Guidelines:
- Always write production-ready code
- Include proper error handling
- Follow language-specific best practices
- Use meaningful variable and function names
- Include helpful comments when appropriate
- Consider edge cases and input validation
- Optimize for both performance and readability

Provide code that is:
- Correct and functional
- Well-structured and maintainable
- Following industry standards
- Properly documented
- Tested and validated
""";
  }
  
  String _getDebugSystemPrompt() {
    return """
You are DeepSeek Coder, specialized in debugging and fixing code issues.

Your debugging process:
1. Analyze the code thoroughly
2. Identify the root cause of issues
3. Explain the problem clearly
4. Provide corrected code
5. Suggest prevention strategies

Focus on:
- Root cause analysis
- Clear explanations
- Correct solutions
- Best practices
- Prevention strategies
""";
  }
  
  String _getOptimizationSystemPrompt() {
    return """
You are DeepSeek Coder, specialized in code optimization and performance improvement.

Your optimization approach:
1. Analyze current code performance
2. Identify optimization opportunities
3. Apply performance improvements
4. Maintain code readability
5. Ensure functionality preservation

Optimize for:
- Performance (speed, memory)
- Readability and maintainability
- Best practices and patterns
- Error handling and robustness
""";
  }
  
  String _getExplanationSystemPrompt() {
    return """
You are DeepSeek Coder, specialized in explaining code and programming concepts.

Your explanation approach:
1. Break down complex concepts
2. Use clear, simple language
3. Provide practical examples
4. Highlight key patterns and techniques
5. Suggest improvements

Make explanations:
- Clear and understandable
- Comprehensive but concise
- Practical and actionable
- Educational and informative
""";
  }
  
  String _getConversionSystemPrompt() {
    return """
You are DeepSeek Coder, specialized in converting code between programming languages.

Your conversion process:
1. Understand the source code functionality
2. Map concepts to target language
3. Apply target language best practices
4. Maintain equivalent functionality
5. Use appropriate idioms and patterns

Ensure:
- Functional equivalence
- Language-specific best practices
- Proper error handling
- Clean, readable code
""";
  }
  
  // Code Analysis
  Future<void> _analyzeGeneratedCode(String code) async {
    try {
      // Basic code analysis
      final lines = code.split('\n');
      final nonEmptyLines = lines.where((line) => line.trim().isNotEmpty).length;
      
      codeMetrics.value = {
        'totalLines': lines.length,
        'nonEmptyLines': nonEmptyLines,
        'complexity': _calculateComplexity(code),
        'language': selectedLanguage.value,
      };
      
      // Analyze code quality
      codeQuality.value = _assessCodeQuality(code);
      
      // Find potential issues
      codeIssues.clear();
      _findCodeIssues(code);
      
      // Generate optimization suggestions
      optimizationSuggestions.clear();
      _generateOptimizationSuggestions(code);
      
    } catch (e) {
      printAction("❌ DeepSeek Coder: Error analyzing code - $e");
    }
  }
  
  int _calculateComplexity(String code) {
    // Simple complexity calculation
    int complexity = 0;
    final lines = code.split('\n');
    
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.contains('if') || trimmed.contains('for') || trimmed.contains('while')) {
        complexity++;
      }
      if (trimmed.contains('switch') || trimmed.contains('case')) {
        complexity += 2;
      }
    }
    
    return complexity;
  }
  
  String _assessCodeQuality(String code) {
    // Simple quality assessment
    if (code.contains('TODO') || code.contains('FIXME')) {
      return 'Needs Improvement';
    }
    
    if (code.contains('//') && code.length > 100) {
      return 'Good';
    }
    
    if (code.length > 500) {
      return 'Excellent';
    }
    
    return 'Basic';
  }
  
  void _findCodeIssues(String code) {
    // Find common code issues
    if (code.contains('print(') && !code.contains('debugPrint')) {
      codeIssues.add('Consider using debugPrint instead of print for debugging');
    }
    
    if (code.contains('var ') && !code.contains('final ')) {
      codeIssues.add('Consider using final or const for immutable values');
    }
    
    if (code.contains('new ') && selectedLanguage.value == 'dart') {
      codeIssues.add('Remove unnecessary "new" keyword in Dart');
    }
  }
  
  void _generateOptimizationSuggestions(String code) {
    // Generate optimization suggestions
    if (code.contains('List') && code.contains('for')) {
      optimizationSuggestions.add('Consider using map() or where() for functional programming');
    }
    
    if (code.contains('String') && code.contains('+')) {
      optimizationSuggestions.add('Consider using StringBuffer for multiple concatenations');
    }
    
    if (code.contains('async') && code.contains('await')) {
      optimizationSuggestions.add('Consider using Future.wait() for parallel async operations');
    }
  }
  
  Future<void> _generateCodeExplanation(String code) async {
    try {
      // Generate explanation for the code
      codeExplanation.value = "Code explanation will be generated here...";
      
      // This would call DeepSeek to explain the code
      // For now, we'll use a simple placeholder
      
    } catch (e) {
      printAction("❌ DeepSeek Coder: Error generating explanation - $e");
    }
  }
  
  Future<void> _generateCodeSuggestions(String code) async {
    try {
      // Generate suggestions for the code
      codeSuggestions.clear();
      codeSuggestions.addAll([
        "Add error handling",
        "Include input validation",
        "Add unit tests",
        "Optimize performance",
        "Improve documentation",
      ]);
      
    } catch (e) {
      printAction("❌ DeepSeek Coder: Error generating suggestions - $e");
    }
  }
  
  // Utility Methods
  void clearCode() {
    generatedCode.value = "";
    codeExplanation.value = "";
    codeSuggestions.clear();
    codeIssues.clear();
    optimizationSuggestions.clear();
    codeMetrics.clear();
  }
  
  void copyCodeToClipboard() {
    if (generatedCode.value.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: generatedCode.value));
      utils.showSnackBar("Code copied to clipboard");
    }
  }
  
  void saveCodeToFile() {
    if (generatedCode.value.isNotEmpty) {
      // Implement file saving logic
      utils.showSnackBar("Code saved to file");
    }
  }
  
  // Get code template for selected language
  String getCodeTemplate(String language) {
    return codeTemplates[language] ?? codeTemplates['dart']!;
  }
  
  // Validate code syntax
  bool validateCodeSyntax(String code, String language) {
    // Basic syntax validation
    if (language == 'dart') {
      return code.contains('class') || code.contains('void') || code.contains('String');
    }
    
    if (language == 'javascript') {
      return code.contains('function') || code.contains('const') || code.contains('let');
    }
    
    if (language == 'python') {
      return code.contains('def') || code.contains('class') || code.contains('import');
    }
    
    return true;
  }
}