# 🔑 API Keys Setup Guide

## 🚀 Quick Setup

1. **Copy the template file:**
   ```bash
   cp lib/app/config/api_keys_template.dart lib/app/config/api_keys.dart
   ```

2. **Add your actual API keys to `api_keys.dart`:**
   - Replace `YOUR_OPENAI_API_KEY_HERE` with your OpenAI API key
   - Replace `YOUR_DEEPSEEK_API_KEY_HERE` with your DeepSeek API key
   - Replace other placeholders with your actual API keys

## 🔐 Security Features

- ✅ `api_keys.dart` is in `.gitignore` - never committed to repository
- ✅ Only template file is public
- ✅ Your actual API keys remain secure locally
- ✅ Ready for production deployment

## 📋 Required API Keys

### OpenAI API Key
- **Purpose**: GPT-5, GPT-4, GPT-3.5 models
- **Get from**: https://platform.openai.com/api-keys
- **Format**: `sk-proj-...`

### DeepSeek API Key  
- **Purpose**: DeepSeek Chat, Coder, Math, Reasoning models
- **Get from**: https://platform.deepseek.com/api_keys
- **Format**: `sk-...`

### Other API Keys (Optional)
- **Gemini**: Google AI Studio
- **ElevenLabs**: Voice cloning
- **YouTube**: Video analysis
- **Weather**: Weather data
- **Tavily**: Real-time web search

## ✅ Ready to Use

Once you've set up your `api_keys.dart` file, your CHATSY app will have access to:
- 🚀 GPT-5 (Latest AI model)
- 🤖 DeepSeek (4 specialized models)
- 🔥 All advanced AI features
- 📱 Complete app functionality

**Your API keys are now securely configured and ready for production!**