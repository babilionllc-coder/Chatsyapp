import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../helper/all_imports.dart';
import '../helper/constants.dart';

class DeepSeekService {
  static final DeepSeekService _instance = DeepSeekService._internal();
  factory DeepSeekService() => _instance;
  DeepSeekService._internal();

  // DeepSeek Models
  static const Map<String, String> deepSeekModels = {
    'deepseek-chat': 'General purpose chat model',
    'deepseek-coder': 'Specialized for coding tasks',
    'deepseek-math': 'Optimized for mathematical reasoning',
    'deepseek-reasoning': 'Advanced reasoning capabilities',
  };

  // Advanced DeepSeek Chat Completion with Streaming
  static Stream<String> streamChatCompletion({
    required List<Map<String, String>> messages,
    String model = Constants.deepSeekChatModel,
    double temperature = 0.7,
    int maxTokens = 4096,
    double topP = 0.9,
    double frequencyPenalty = 0.0,
    double presencePenalty = 0.0,
    List<String>? stop,
    bool stream = true,
    Map<String, dynamic>? tools,
    String? toolChoice,
  }) async* {
    try {
      printAction("🚀 DeepSeek: Starting streaming chat completion...");
      
      final requestBody = {
        'model': model,
        'messages': messages,
        'temperature': temperature,
        'max_tokens': maxTokens,
        'top_p': topP,
        'frequency_penalty': frequencyPenalty,
        'presence_penalty': presencePenalty,
        'stream': stream,
        if (stop != null) 'stop': stop,
        if (tools != null) 'tools': tools,
        if (toolChoice != null) 'tool_choice': toolChoice,
      };

      final response = await http.post(
        Uri.parse('${Constants.deepSeekBaseUrl}/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${Constants.deepSeekApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        if (stream) {
          // Handle streaming response
          final lines = response.body.split('\n');
          for (String line in lines) {
            if (line.startsWith('data: ')) {
              final data = line.substring(6);
              if (data.trim() == '[DONE]') break;
              
              try {
                final jsonData = jsonDecode(data);
                final content = jsonData['choices']?[0]?['delta']?['content'];
                if (content != null && content.isNotEmpty) {
                  yield content;
                }
              } catch (e) {
                // Skip invalid JSON lines
                continue;
              }
            }
          }
        } else {
          // Handle non-streaming response
          final responseData = jsonDecode(response.body);
          final content = responseData['choices']?[0]?['message']?['content'];
          if (content != null) {
            yield content;
          }
        }
      } else {
        printAction("❌ DeepSeek: Error ${response.statusCode} - ${response.body}");
        yield "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      printAction("❌ DeepSeek: Exception - $e");
      yield "Error: $e";
    }
  }

  // DeepSeek Function Calling
  static Future<Map<String, dynamic>> chatWithTools({
    required List<Map<String, String>> messages,
    required List<Map<String, dynamic>> tools,
    String model = Constants.deepSeekChatModel,
    double temperature = 0.7,
    int maxTokens = 4096,
  }) async {
    try {
      printAction("🔧 DeepSeek: Starting function calling...");
      
      final requestBody = {
        'model': model,
        'messages': messages,
        'tools': tools,
        'tool_choice': 'auto',
        'temperature': temperature,
        'max_tokens': maxTokens,
      };

      final response = await http.post(
        Uri.parse('${Constants.deepSeekBaseUrl}/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${Constants.deepSeekApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        printAction("✅ DeepSeek: Function calling response received");
        return responseData;
      } else {
        printAction("❌ DeepSeek: Function calling error ${response.statusCode}");
        return {'error': '${response.statusCode} - ${response.body}'};
      }
    } catch (e) {
      printAction("❌ DeepSeek: Function calling exception - $e");
      return {'error': e.toString()};
    }
  }

  // DeepSeek Code Generation
  static Future<String> generateCode({
    required String prompt,
    String language = 'dart',
    String model = Constants.deepSeekCoderModel,
    double temperature = 0.1,
    int maxTokens = 2048,
  }) async {
    try {
      printAction("💻 DeepSeek: Generating code in $language...");
      
      final messages = [
        {
          'role': 'system',
          'content': 'You are an expert $language developer. Generate clean, efficient, and well-commented code.',
        },
        {
          'role': 'user',
          'content': prompt,
        },
      ];

      final requestBody = {
        'model': model,
        'messages': messages,
        'temperature': temperature,
        'max_tokens': maxTokens,
      };

      final response = await http.post(
        Uri.parse('${Constants.deepSeekBaseUrl}/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${Constants.deepSeekApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final content = responseData['choices']?[0]?['message']?['content'];
        printAction("✅ DeepSeek: Code generated successfully");
        return content ?? 'No code generated';
      } else {
        printAction("❌ DeepSeek: Code generation error ${response.statusCode}");
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      printAction("❌ DeepSeek: Code generation exception - $e");
      return 'Error: $e';
    }
  }

  // DeepSeek Mathematical Reasoning
  static Future<String> solveMath({
    required String problem,
    String model = Constants.deepSeekMathModel,
    double temperature = 0.1,
    int maxTokens = 1024,
  }) async {
    try {
      printAction("🧮 DeepSeek: Solving mathematical problem...");
      
      final messages = [
        {
          'role': 'system',
          'content': 'You are an expert mathematician. Solve problems step by step with clear explanations.',
        },
        {
          'role': 'user',
          'content': problem,
        },
      ];

      final requestBody = {
        'model': model,
        'messages': messages,
        'temperature': temperature,
        'max_tokens': maxTokens,
      };

      final response = await http.post(
        Uri.parse('${Constants.deepSeekBaseUrl}/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${Constants.deepSeekApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final content = responseData['choices']?[0]?['message']?['content'];
        printAction("✅ DeepSeek: Math problem solved");
        return content ?? 'No solution generated';
      } else {
        printAction("❌ DeepSeek: Math solving error ${response.statusCode}");
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      printAction("❌ DeepSeek: Math solving exception - $e");
      return 'Error: $e';
    }
  }

  // DeepSeek Advanced Reasoning
  static Future<String> advancedReasoning({
    required String query,
    String model = Constants.deepSeekReasoningModel,
    double temperature = 0.3,
    int maxTokens = 2048,
  }) async {
    try {
      printAction("🧠 DeepSeek: Advanced reasoning analysis...");
      
      final messages = [
        {
          'role': 'system',
          'content': 'You are an expert in logical reasoning and analysis. Provide detailed, step-by-step reasoning with clear conclusions.',
        },
        {
          'role': 'user',
          'content': query,
        },
      ];

      final requestBody = {
        'model': model,
        'messages': messages,
        'temperature': temperature,
        'max_tokens': maxTokens,
      };

      final response = await http.post(
        Uri.parse('${Constants.deepSeekBaseUrl}/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${Constants.deepSeekApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final content = responseData['choices']?[0]?['message']?['content'];
        printAction("✅ DeepSeek: Advanced reasoning completed");
        return content ?? 'No reasoning generated';
      } else {
        printAction("❌ DeepSeek: Advanced reasoning error ${response.statusCode}");
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      printAction("❌ DeepSeek: Advanced reasoning exception - $e");
      return 'Error: $e';
    }
  }

  // DeepSeek Model Information
  static Future<List<Map<String, dynamic>>> getAvailableModels() async {
    try {
      printAction("📋 DeepSeek: Fetching available models...");
      
      final response = await http.get(
        Uri.parse('${Constants.deepSeekBaseUrl}/models'),
        headers: {
          'Authorization': 'Bearer ${Constants.deepSeekApiKey}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final models = responseData['data'] as List;
        printAction("✅ DeepSeek: Models fetched successfully");
        return models.cast<Map<String, dynamic>>();
      } else {
        printAction("❌ DeepSeek: Models fetch error ${response.statusCode}");
        return [];
      }
    } catch (e) {
      printAction("❌ DeepSeek: Models fetch exception - $e");
      return [];
    }
  }

  // DeepSeek Usage Statistics
  static Future<Map<String, dynamic>> getUsageStats() async {
    try {
      printAction("📊 DeepSeek: Fetching usage statistics...");
      
      final response = await http.get(
        Uri.parse('${Constants.deepSeekBaseUrl}/usage'),
        headers: {
          'Authorization': 'Bearer ${Constants.deepSeekApiKey}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        printAction("✅ DeepSeek: Usage stats fetched successfully");
        return responseData;
      } else {
        printAction("❌ DeepSeek: Usage stats error ${response.statusCode}");
        return {'error': '${response.statusCode} - ${response.body}'};
      }
    } catch (e) {
      printAction("❌ DeepSeek: Usage stats exception - $e");
      return {'error': e.toString()};
    }
  }

  // DeepSeek Embeddings
  static Future<List<double>> getEmbeddings({
    required String text,
    String model = 'deepseek-embedding',
  }) async {
    try {
      printAction("🔍 DeepSeek: Generating embeddings...");
      
      final requestBody = {
        'model': model,
        'input': text,
      };

      final response = await http.post(
        Uri.parse('${Constants.deepSeekBaseUrl}/embeddings'),
        headers: {
          'Authorization': 'Bearer ${Constants.deepSeekApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final embeddings = responseData['data']?[0]?['embedding'] as List?;
        printAction("✅ DeepSeek: Embeddings generated successfully");
        return embeddings?.cast<double>() ?? [];
      } else {
        printAction("❌ DeepSeek: Embeddings error ${response.statusCode}");
        return [];
      }
    } catch (e) {
      printAction("❌ DeepSeek: Embeddings exception - $e");
      return [];
    }
  }

  // DeepSeek Image Analysis (if supported)
  static Future<String> analyzeImage({
    required String imageUrl,
    required String prompt,
    String model = 'deepseek-vl',
  }) async {
    try {
      printAction("🖼️ DeepSeek: Analyzing image...");
      
      final messages = [
        {
          'role': 'user',
          'content': [
            {'type': 'text', 'text': prompt},
            {'type': 'image_url', 'image_url': {'url': imageUrl}},
          ],
        },
      ];

      final requestBody = {
        'model': model,
        'messages': messages,
        'max_tokens': 1024,
      };

      final response = await http.post(
        Uri.parse('${Constants.deepSeekBaseUrl}/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${Constants.deepSeekApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final content = responseData['choices']?[0]?['message']?['content'];
        printAction("✅ DeepSeek: Image analysis completed");
        return content ?? 'No analysis generated';
      } else {
        printAction("❌ DeepSeek: Image analysis error ${response.statusCode}");
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      printAction("❌ DeepSeek: Image analysis exception - $e");
      return 'Error: $e';
    }
  }

  // DeepSeek Fine-tuning Support
  static Future<String> createFineTuningJob({
    required String trainingFileId,
    String model = Constants.deepSeekChatModel,
    int epochs = 3,
    double learningRate = 0.0001,
  }) async {
    try {
      printAction("🎯 DeepSeek: Creating fine-tuning job...");
      
      final requestBody = {
        'model': model,
        'training_file': trainingFileId,
        'hyperparameters': {
          'n_epochs': epochs,
          'learning_rate_multiplier': learningRate,
        },
      };

      final response = await http.post(
        Uri.parse('${Constants.deepSeekBaseUrl}/fine_tuning/jobs'),
        headers: {
          'Authorization': 'Bearer ${Constants.deepSeekApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final jobId = responseData['id'];
        printAction("✅ DeepSeek: Fine-tuning job created: $jobId");
        return jobId ?? 'No job ID returned';
      } else {
        printAction("❌ DeepSeek: Fine-tuning error ${response.statusCode}");
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      printAction("❌ DeepSeek: Fine-tuning exception - $e");
      return 'Error: $e';
    }
  }
}
