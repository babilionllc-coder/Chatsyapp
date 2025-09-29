import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'env_config.dart';

class ApiKeyManager {
  // Secure API Key Manager for Chatsy App
  
  static bool _isInitialized = false;
  static Map<String, String> _apiKeys = {};
  
  // Initialize API key manager
  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // Initialize environment configuration
      await EnvConfig.initialize();
      
      // Load all API keys securely
      await _loadApiKeys();
      
      // Validate required keys
      _validateApiKeys();
      
      _isInitialized = true;
      printAction("🔐 ApiKeyManager: Initialized successfully");
      
    } catch (e) {
      printAction("❌ ApiKeyManager: Initialization error - $e");
      _isInitialized = true; // Prevent infinite retries
    }
  }
  
  // Load all API keys from environment
  static Future<void> _loadApiKeys() async {
    _apiKeys = {
      'openai': EnvConfig.getEnvVar('OPENAI_API_KEY', fallback: 'YOUR_OPENAI_API_KEY_HERE'),
      'deepseek': EnvConfig.getEnvVar('DEEPSEEK_API_KEY', fallback: 'YOUR_DEEPSEEK_API_KEY_HERE'),
      'elevenlabs': EnvConfig.getEnvVar('ELEVENLABS_API_KEY', fallback: 'YOUR_ELEVENLABS_API_KEY_HERE'),
      'elevenlabs_voice_id': EnvConfig.getEnvVar('ELEVENLABS_VOICE_ID', fallback: 'YOUR_ELEVENLABS_VOICE_ID_HERE'),
      'gemini': EnvConfig.getEnvVar('GEMINI_API_KEY', fallback: 'YOUR_GEMINI_API_KEY_HERE'),
      'youtube': EnvConfig.getEnvVar('YOUTUBE_API_KEY', fallback: 'YOUR_YOUTUBE_API_KEY_HERE'),
      'weather': EnvConfig.getEnvVar('WEATHER_API_KEY', fallback: 'YOUR_WEATHER_API_KEY_HERE'),
      'tavily': EnvConfig.getEnvVar('TAVILY_API_KEY', fallback: 'YOUR_TAVILY_API_KEY_HERE'),
    };
    
    printAction("🔑 ApiKeyManager: Loaded ${_apiKeys.length} API keys");
  }
  
  // Validate API keys
  static void _validateApiKeys() {
    final requiredKeys = ['openai', 'deepseek', 'elevenlabs', 'gemini', 'youtube', 'tavily'];
    List<String> missingKeys = [];
    
    for (String key in requiredKeys) {
      if (!_isValidApiKey(_apiKeys[key]!)) {
        missingKeys.add(key);
      }
    }
    
    if (missingKeys.isNotEmpty) {
      printAction("❌ ApiKeyManager: Missing or invalid keys: ${missingKeys.join(', ')}");
      printAction("💡 ApiKeyManager: Please check your .env file or environment variables");
    } else {
      printAction("✅ ApiKeyManager: All required API keys are valid");
    }
  }
  
  // Check if API key is valid (not placeholder)
  static bool _isValidApiKey(String key) {
    if (key.isEmpty) return false;
    if (key.contains('YOUR_') || key.contains('_HERE')) return false;
    if (key.length < 10) return false;
    return true;
  }
  
  // Get API key securely
  static String getApiKey(String service) {
    if (!_isInitialized) {
      printAction("⚠️ ApiKeyManager: Not initialized, returning placeholder");
      return 'YOUR_${service.toUpperCase()}_API_KEY_HERE';
    }
    
    final key = _apiKeys[service.toLowerCase()];
    if (key != null && _isValidApiKey(key)) {
      return key;
    }
    
    printAction("❌ ApiKeyManager: Invalid or missing key for $service");
    return 'YOUR_${service.toUpperCase()}_API_KEY_HERE';
  }
  
  // Check if API key is available
  static bool hasApiKey(String service) {
    if (!_isInitialized) return false;
    final key = _apiKeys[service.toLowerCase()];
    return key != null && _isValidApiKey(key);
  }
  
  // Get all available services
  static List<String> getAvailableServices() {
    if (!_isInitialized) return [];
    
    List<String> availableServices = [];
    _apiKeys.forEach((service, key) {
      if (_isValidApiKey(key)) {
        availableServices.add(service);
      }
    });
    
    return availableServices;
  }
  
  // Security audit
  static void securityAudit() {
    printAction("🔍 ApiKeyManager: Running security audit...");
    
    _apiKeys.forEach((service, key) {
      if (_isValidApiKey(key)) {
        // Mask the key for logging
        final maskedKey = key.length > 8 
            ? '${key.substring(0, 4)}...${key.substring(key.length - 4)}'
            : '***';
        printAction("✅ $service: $maskedKey");
      } else {
        printAction("❌ $service: Not configured");
      }
    });
  }
  
  // Update API key (for runtime updates)
  static void updateApiKey(String service, String newKey) {
    if (_isValidApiKey(newKey)) {
      _apiKeys[service.toLowerCase()] = newKey;
      printAction("✅ ApiKeyManager: Updated $service API key");
    } else {
      printAction("❌ ApiKeyManager: Invalid API key format for $service");
    }
  }
  
  // Get API key status
  static Map<String, bool> getApiKeyStatus() {
    Map<String, bool> status = {};
    _apiKeys.forEach((service, key) {
      status[service] = _isValidApiKey(key);
    });
    return status;
  }
  
  // Create .env file with current keys (for development)
  static Future<void> createEnvFile() async {
    try {
      await EnvConfig.createSampleEnvFile();
      printAction("📝 ApiKeyManager: .env file created with sample configuration");
    } catch (e) {
      printAction("❌ ApiKeyManager: Error creating .env file - $e");
    }
  }
}

// Helper function for logging
void printAction(String message) {
  if (kDebugMode) {
    print(message);
  }
}
