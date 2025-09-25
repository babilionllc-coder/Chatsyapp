# 🔐 Security Guide - API Key Management

## Overview
This guide explains how to securely manage API keys in the Chatsy application to prevent exposure of sensitive credentials.

## 🚨 Current Security Status
**IMPORTANT**: The following API keys are currently exposed in the codebase and need to be secured:

- DeepSeek API Key: `sk-cfe7af2d18464568a829e6a137151553`
- ElevenLabs API Key: `sk_17691e65b6a545752df616707a22a513663c51fab3be823e`
- Tavily API Key: `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`

## 🔧 How to Secure API Keys

### Method 1: Environment Variables (Recommended)

1. **Create a `.env` file** in your project root:
```bash
cp env.example .env
```

2. **Add your actual API keys** to the `.env` file:
```env
# OpenAI API Key (Required)
OPENAI_API_KEY=sk-your-actual-openai-key-here

# DeepSeek API Key (Required)
DEEPSEEK_API_KEY=sk-your-actual-deepseek-key-here

# ElevenLabs API Key (Required)
ELEVENLABS_API_KEY=sk-your-actual-elevenlabs-key-here
ELEVENLABS_VOICE_ID=your-voice-id-here

# Other optional keys...
GEMINI_API_KEY=your-gemini-key-here
YOUTUBE_API_KEY=your-youtube-key-here
WEATHER_API_KEY=your-weather-key-here
TAVILY_API_KEY=your-tavily-key-here
```

3. **Add `.env` to `.gitignore`**:
```gitignore
# Environment variables
.env
.env.local
.env.production
```

### Method 2: Build-time Environment Variables

For production builds, set environment variables during build:

```bash
# For Flutter build
flutter build apk --dart-define=OPENAI_API_KEY=your-key-here
flutter build ios --dart-define=OPENAI_API_KEY=your-key-here
```

### Method 3: Secure Storage (Production)

For production apps, use Flutter Secure Storage:

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
await storage.write(key: 'openai_api_key', value: 'your-key-here');
```

## 🛡️ Security Best Practices

### 1. Never Commit API Keys
- ✅ Use `.env` files for development
- ✅ Use environment variables for CI/CD
- ✅ Use secure storage for production
- ❌ Never commit API keys to version control

### 2. Key Rotation
- Rotate API keys regularly
- Monitor API usage for anomalies
- Revoke compromised keys immediately

### 3. Access Control
- Use least privilege principle
- Limit API key permissions
- Monitor key usage

### 4. Environment Separation
- Use different keys for development/staging/production
- Never use production keys in development

## 🔍 How the Security System Works

### 1. Environment Configuration (`env_config.dart`)
- Loads variables from `.env` file
- Reads system environment variables
- Provides fallback values for missing keys

### 2. API Key Manager (`api_key_manager.dart`)
- Centralized key management
- Validation and security checks
- Runtime key updates

### 3. Constants Integration (`constants.dart`)
- Secure key loading on app startup
- Validation of key configuration
- Status checking for debugging

## 🚀 Implementation Steps

### Step 1: Secure Current Keys
1. Copy `env.example` to `.env`
2. Add your actual API keys to `.env`
3. Remove hardcoded keys from `constants.dart`
4. Test the application

### Step 2: Update CI/CD
1. Add environment variables to your CI/CD system
2. Update build scripts to use environment variables
3. Test builds with secure keys

### Step 3: Production Deployment
1. Use secure storage for production
2. Implement key rotation strategy
3. Monitor API usage and costs

## 🔧 Troubleshooting

### Common Issues

1. **Keys not loading**: Check `.env` file format and location
2. **Build failures**: Ensure environment variables are set in CI/CD
3. **Runtime errors**: Verify key validation and error handling

### Debug Commands

```dart
// Check API key status
print(Constants.getApiKeyStatus());

// Validate configuration
print(Constants.areApiKeysConfigured());

// Security audit
ApiKeyManager.securityAudit();
```

## 📋 Checklist

- [ ] Create `.env` file with actual API keys
- [ ] Add `.env` to `.gitignore`
- [ ] Remove hardcoded keys from code
- [ ] Test application with secure keys
- [ ] Update CI/CD with environment variables
- [ ] Implement production secure storage
- [ ] Set up key rotation strategy
- [ ] Monitor API usage and costs

## 🆘 Emergency Response

If API keys are compromised:

1. **Immediately revoke** the compromised keys
2. **Generate new keys** from the respective services
3. **Update** all environments with new keys
4. **Monitor** for unauthorized usage
5. **Review** security practices

## 📞 Support

For security-related questions or issues:
- Check the logs for detailed error messages
- Verify environment variable configuration
- Ensure proper key format and permissions

---

**Remember**: Security is an ongoing process. Regularly review and update your security practices!
