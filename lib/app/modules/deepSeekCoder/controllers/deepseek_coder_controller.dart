import 'dart:developer';
import '../../../helper/all_imports.dart';
import '../../../service/deepseek_service.dart';

class DeepSeekCoderController extends GetxController {
  // DeepSeek Coder Controller for Advanced Code Generation
  
  // Observable variables
  RxBool isLoading = false.obs;
  RxString generatedCode = "".obs;
  RxString selectedLanguage = "dart".obs;
  RxString codeExplanation = "".obs;
  RxList<String> codeSuggestions = <String>[].obs;
  RxString errorMessage = "".obs;
  
  // Code generation options
  RxBool includeComments = true.obs;
  RxBool includeErrorHandling = true.obs;
  RxBool includeTests = false.obs;
  RxBool optimizePerformance = true.obs;
  
  // Available programming languages
  final List<String> programmingLanguages = [
    'dart',
    'javascript',
    'typescript',
    'python',
    'java',
    'kotlin',
    'swift',
    'c++',
    'c#',
    'go',
    'rust',
    'php',
    'ruby',
    'html',
    'css',
    'sql',
    'bash',
    'powershell',
  ];
  
  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }
  
  void _initializeController() {
    printAction("💻 DeepSeek Coder: Controller initialized");
  }
  
  // Generate code with DeepSeek
  Future<void> generateCode({
    required String prompt,
    String? language,
    bool? includeComments,
    bool? includeErrorHandling,
    bool? includeTests,
    bool? optimizePerformance,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      
      // Use provided parameters or defaults
      final selectedLang = language ?? selectedLanguage.value;
      final withComments = includeComments ?? this.includeComments.value;
      final withErrorHandling = includeErrorHandling ?? this.includeErrorHandling.value;
      final withTests = includeTests ?? this.includeTests.value;
      final optimized = optimizePerformance ?? this.optimizePerformance.value;
      
      printAction("💻 DeepSeek Coder: Generating $selectedLang code...");
      
      // Build enhanced prompt
      String enhancedPrompt = _buildEnhancedPrompt(
        prompt,
        selectedLang,
        withComments,
        withErrorHandling,
        withTests,
        optimized,
      );
      
      // Generate code using DeepSeek
      final code = await DeepSeekService.generateCode(
        prompt: enhancedPrompt,
        language: selectedLang,
        model: Constants.deepSeekCoderModel,
        temperature: 0.1, // Low temperature for consistent code
        maxTokens: 2048,
      );
      
      if (code.contains('Error:')) {
        errorMessage.value = code;
        generatedCode.value = "";
      } else {
        generatedCode.value = code;
        await _generateCodeExplanation(code);
        await _generateCodeSuggestions(code, selectedLang);
      }
      
      printAction("✅ DeepSeek Coder: Code generation completed");
      
    } catch (e) {
      errorMessage.value = "Error generating code: $e";
      printAction("❌ DeepSeek Coder: Error - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Build enhanced prompt for code generation
  String _buildEnhancedPrompt(
    String prompt,
    String language,
    bool includeComments,
    bool includeErrorHandling,
    bool includeTests,
    bool optimizePerformance,
  ) {
    StringBuffer enhancedPrompt = StringBuffer();
    
    enhancedPrompt.writeln("Generate $language code for the following request:");
    enhancedPrompt.writeln(prompt);
    enhancedPrompt.writeln();
    
    enhancedPrompt.writeln("Requirements:");
    if (includeComments) {
      enhancedPrompt.writeln("- Include comprehensive comments explaining the code");
    }
    if (includeErrorHandling) {
      enhancedPrompt.writeln("- Include proper error handling and edge cases");
    }
    if (includeTests) {
      enhancedPrompt.writeln("- Include unit tests for the code");
    }
    if (optimizePerformance) {
      enhancedPrompt.writeln("- Optimize for performance and efficiency");
    }
    
    enhancedPrompt.writeln("- Follow $language best practices and conventions");
    enhancedPrompt.writeln("- Use clean, readable, and maintainable code structure");
    enhancedPrompt.writeln("- Include proper imports and dependencies");
    
    return enhancedPrompt.toString();
  }
  
  // Generate code explanation
  Future<void> _generateCodeExplanation(String code) async {
    try {
      printAction("📝 DeepSeek Coder: Generating code explanation...");
      
      final explanation = await DeepSeekService.chatWithTools(
        messages: [
          {
            'role': 'system',
            'content': 'You are an expert code reviewer. Provide a clear, detailed explanation of how the code works.',
          },
          {
            'role': 'user',
            'content': 'Please explain this code:\n\n$code',
          },
        ],
        tools: [],
        model: Constants.deepSeekCoderModel,
        temperature: 0.3,
        maxTokens: 1024,
      );
      
      if (explanation.containsKey('choices')) {
        final content = explanation['choices']?[0]?['message']?['content'];
        if (content != null) {
          codeExplanation.value = content;
        }
      }
      
    } catch (e) {
      printAction("❌ DeepSeek Coder: Explanation error - $e");
    }
  }
  
  // Generate code suggestions
  Future<void> _generateCodeSuggestions(String code, String language) async {
    try {
      printAction("💡 DeepSeek Coder: Generating code suggestions...");
      
      final suggestions = await DeepSeekService.chatWithTools(
        messages: [
          {
            'role': 'system',
            'content': 'You are an expert code reviewer. Provide 3-5 specific suggestions for improving the code.',
          },
          {
            'role': 'user',
            'content': 'Please provide suggestions to improve this $language code:\n\n$code',
          },
        ],
        tools: [],
        model: Constants.deepSeekCoderModel,
        temperature: 0.3,
        maxTokens: 512,
      );
      
      if (suggestions.containsKey('choices')) {
        final content = suggestions['choices']?[0]?['message']?['content'];
        if (content != null) {
          // Parse suggestions into list
          List<String> suggestionList = content
              .split('\n')
              .where((line) => line.trim().isNotEmpty)
              .map((line) => line.trim())
              .toList();
          
          codeSuggestions.value = suggestionList;
        }
      }
      
    } catch (e) {
      printAction("❌ DeepSeek Coder: Suggestions error - $e");
    }
  }
  
  // Optimize existing code
  Future<void> optimizeCode(String code, String language) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      
      printAction("⚡ DeepSeek Coder: Optimizing $language code...");
      
      final optimizedCode = await DeepSeekService.generateCode(
        prompt: "Optimize this $language code for better performance, readability, and maintainability:\n\n$code",
        language: language,
        model: Constants.deepSeekCoderModel,
        temperature: 0.1,
        maxTokens: 2048,
      );
      
      if (optimizedCode.contains('Error:')) {
        errorMessage.value = optimizedCode;
      } else {
        generatedCode.value = optimizedCode;
        await _generateCodeExplanation(optimizedCode);
      }
      
    } catch (e) {
      errorMessage.value = "Error optimizing code: $e";
      printAction("❌ DeepSeek Coder: Optimization error - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Debug code
  Future<void> debugCode(String code, String language, String errorDescription) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      
      printAction("🐛 DeepSeek Coder: Debugging $language code...");
      
      final debuggedCode = await DeepSeekService.generateCode(
        prompt: "Debug this $language code. The error description is: $errorDescription\n\nCode:\n$code",
        language: language,
        model: Constants.deepSeekCoderModel,
        temperature: 0.1,
        maxTokens: 2048,
      );
      
      if (debuggedCode.contains('Error:')) {
        errorMessage.value = debuggedCode;
      } else {
        generatedCode.value = debuggedCode;
        await _generateCodeExplanation(debuggedCode);
      }
      
    } catch (e) {
      errorMessage.value = "Error debugging code: $e";
      printAction("❌ DeepSeek Coder: Debug error - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Convert code between languages
  Future<void> convertCode(String code, String fromLanguage, String toLanguage) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      
      printAction("🔄 DeepSeek Coder: Converting from $fromLanguage to $toLanguage...");
      
      final convertedCode = await DeepSeekService.generateCode(
        prompt: "Convert this $fromLanguage code to $toLanguage while maintaining the same functionality:\n\n$code",
        language: toLanguage,
        model: Constants.deepSeekCoderModel,
        temperature: 0.1,
        maxTokens: 2048,
      );
      
      if (convertedCode.contains('Error:')) {
        errorMessage.value = convertedCode;
      } else {
        generatedCode.value = convertedCode;
        selectedLanguage.value = toLanguage;
        await _generateCodeExplanation(convertedCode);
      }
      
    } catch (e) {
      errorMessage.value = "Error converting code: $e";
      printAction("❌ DeepSeek Coder: Conversion error - $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Clear all data
  void clearData() {
    generatedCode.value = "";
    codeExplanation.value = "";
    codeSuggestions.clear();
    errorMessage.value = "";
  }
  
  // Update language selection
  void updateLanguage(String language) {
    selectedLanguage.value = language;
    printAction("💻 DeepSeek Coder: Language updated to $language");
  }
  
  // Toggle options
  void toggleComments() => includeComments.value = !includeComments.value;
  void toggleErrorHandling() => includeErrorHandling.value = !includeErrorHandling.value;
  void toggleTests() => includeTests.value = !includeTests.value;
  void toggleOptimization() => optimizePerformance.value = !optimizePerformance.value;
}
