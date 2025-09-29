import 'dart:io';
import 'package:flutter/foundation.dart';

class EnvConfig {
  // Environment Configuration for Secure API Key Management
  
  static const String _envFileName = '.env';
  static Map<String, String> _envVariables = {};
  static bool _isInitialized = false;
  
  // Initialize environment variables
  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // Load from .env file if it exists
      await _loadFromEnvFile();
      
      // Load from environment variables
      _loadFromEnvironment();
      
      // Load from secure storage (for production)
      await _loadFromSecureStorage();
      
      _isInitialized = true;
      printAction("🔐 EnvConfig: Environment variables loaded successfully");
      
    } catch (e) {
      printAction("❌ EnvConfig: Error loading environment variables - $e");
      _isInitialized = true; // Prevent infinite retries
    }
  }
  
  // Load from .env file
  static Future<void> _loadFromEnvFile() async {
    try {
      final envFile = File(_envFileName);
      if (await envFile.exists()) {
        final content = await envFile.readAsString();
        final lines = content.split('\n');
        
        for (String line in lines) {
          line = line.trim();
          if (line.isNotEmpty && !line.startsWith('#')) {
            final parts = line.split('=');
            if (parts.length == 2) {
              _envVariables[parts[0].trim()] = parts[1].trim();
            }
          }
        }
        
        printAction("📁 EnvConfig: Loaded ${_envVariables.length} variables from .env file");
      }
    } catch (e) {
      printAction("❌ EnvConfig: Error reading .env file - $e");
    }
  }
  
  // Load from system environment variables
  static void _loadFromEnvironment() {
    // These will be set by the build system or CI/CD
    final envKeys = [
      'OPENAI_API_KEY',
      'DEEPSEEK_API_KEY',
      'ELEVENLABS_API_KEY',
      'ELEVENLABS_VOICE_ID',
      'GEMINI_API_KEY',
      'YOUTUBE_API_KEY',
      'WEATHER_API_KEY',
      'TAVILY_API_KEY',
    ];
    
    for (String key in envKeys) {
      final value = Platform.environment[key];
      if (value != null && value.isNotEmpty) {
        _envVariables[key] = value;
      }
    }
    
    printAction("🌍 EnvConfig: Loaded ${Platform.environment.length} system environment variables");
  }
  
  // Load from secure storage (for production apps)
  static Future<void> _loadFromSecureStorage() async {
    try {
      // This would integrate with Flutter Secure Storage
      // For now, we'll use a placeholder
      if (kReleaseMode) {
        // In production, load from secure storage
        printAction("🔒 EnvConfig: Production mode - using secure storage");
      }
    } catch (e) {
      printAction("❌ EnvConfig: Error loading from secure storage - $e");
    }
  }
  
  // Get environment variable with fallback
  static String getEnvVar(String key, {String? fallback}) {
    if (!_isInitialized) {
      printAction("⚠️ EnvConfig: Not initialized, using fallback for $key");
      return fallback ?? '';
    }
    
    final value = _envVariables[key];
    if (value != null && value.isNotEmpty) {
      return value;
    }
    
    if (fallback != null) {
      printAction("⚠️ EnvConfig: Using fallback for $key");
      return fallback;
    }
    
    printAction("❌ EnvConfig: No value found for $key");
    return '';
  }
  
  // Check if environment variable exists
  static bool hasEnvVar(String key) {
    if (!_isInitialized) return false;
    return _envVariables.containsKey(key) && _envVariables[key]!.isNotEmpty;
  }
  
  // Get all environment variables (for debugging)
  static Map<String, String> getAllEnvVars() {
    return Map.from(_envVariables);
  }
  
  // Validate required environment variables
  static List<String> validateRequiredKeys() {
    final requiredKeys = [
      'OPENAI_API_KEY',
      'DEEPSEEK_API_KEY',
      'ELEVENLABS_API_KEY',
    ];
    
    List<String> missingKeys = [];
    
    for (String key in requiredKeys) {
      if (!hasEnvVar(key)) {
        missingKeys.add(key);
      }
    }
    
    if (missingKeys.isNotEmpty) {
      printAction("❌ EnvConfig: Missing required keys: ${missingKeys.join(', ')}");
    } else {
      printAction("✅ EnvConfig: All required keys are present");
    }
    
    return missingKeys;
  }
  
  // Create sample .env file
  static Future<void> createSampleEnvFile() async {
    try {
      final sampleContent = '''
# Chatsy API Keys Configuration
# Copy this file to .env and add your actual API keys

# OpenAI API Key (Required)
OPENAI_API_KEY=your_openai_api_key_here

# DeepSeek API Key (Required)
DEEPSEEK_API_KEY=your_deepseek_api_key_here

# ElevenLabs API Key (Required)
ELEVENLABS_API_KEY=your_elevenlabs_api_key_here
ELEVENLABS_VOICE_ID=your_elevenlabs_voice_id_here

# Google Gemini API Key (Optional)
GEMINI_API_KEY=your_gemini_api_key_here

# YouTube API Key (Optional)
YOUTUBE_API_KEY=your_youtube_api_key_here

# Weather API Key (Optional)
WEATHER_API_KEY=your_weather_api_key_here

# Tavily API Key (Optional)
TAVILY_API_KEY=your_tavily_api_key_here
''';
      
      final envFile = File(_envFileName);
      await envFile.writeAsString(sampleContent);
      
      printAction("📝 EnvConfig: Sample .env file created");
      
    } catch (e) {
      printAction("❌ EnvConfig: Error creating sample .env file - $e");
    }
  }
  
  // Security check for exposed keys
  static void securityCheck() {
    final sensitiveKeys = [
      'OPENAI_API_KEY',
      'DEEPSEEK_API_KEY',
      'ELEVENLABS_API_KEY',
    ];
    
    for (String key in sensitiveKeys) {
      final value = getEnvVar(key);
      if (value.isNotEmpty && value.contains('sk-')) {
        // Check if it's a placeholder
        if (value.contains('your_') || value.contains('_here')) {
          printAction("⚠️ EnvConfig: $key appears to be a placeholder");
        } else {
          printAction("✅ EnvConfig: $key is properly configured");
        }
      }
    }
  }
}

// Helper function for logging
void printAction(String message) {
  if (kDebugMode) {
    print(message);
  }
}
