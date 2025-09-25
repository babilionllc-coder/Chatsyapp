#!/bin/bash

# 🔐 AI API Key Setup Script
# Interactive script to setup API keys for Chatsy app

set -e  # Exit on any error

echo "🔐 Setting up API keys for Chatsy..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to get user input
get_input() {
    local prompt="$1"
    local default="$2"
    local value
    
    if [ -n "$default" ]; then
        read -p "$prompt [$default]: " value
        echo "${value:-$default}"
    else
        read -p "$prompt: " value
        echo "$value"
    fi
}

# Function to validate API key format
validate_key() {
    local key="$1"
    local type="$2"
    
    case "$type" in
        "openai"|"deepseek")
            if [[ "$key" =~ ^sk- ]]; then
                return 0
            else
                print_error "Invalid OpenAI/DeepSeek API key format. Should start with 'sk-'"
                return 1
            fi
            ;;
        "elevenlabs")
            if [[ "$key" =~ ^sk_ ]]; then
                return 0
            else
                print_error "Invalid ElevenLabs API key format. Should start with 'sk_'"
                return 1
            fi
            ;;
        "gemini")
            if [[ "$key" =~ ^AI ]]; then
                return 0
            else
                print_error "Invalid Gemini API key format. Should start with 'AI'"
                return 1
            fi
            ;;
        "tavily")
            if [[ "$key" =~ ^tvly- ]]; then
                return 0
            else
                print_error "Invalid Tavily API key format. Should start with 'tvly-'"
                return 1
            fi
            ;;
        *)
            if [ ${#key} -gt 10 ]; then
                return 0
            else
                print_error "API key seems too short"
                return 1
            fi
            ;;
    esac
}

# Check if .env file already exists
if [ -f ".env" ]; then
    print_warning ".env file already exists!"
    read -p "Do you want to overwrite it? (y/N): " overwrite
    if [[ ! "$overwrite" =~ ^[Yy]$ ]]; then
        print_status "Keeping existing .env file"
        exit 0
    fi
fi

print_status "Let's setup your API keys..."
echo ""

# Required API Keys
print_status "=== REQUIRED API KEYS ==="
echo ""

# OpenAI API Key
print_status "1. OpenAI API Key (Required)"
print_status "   Get it from: https://platform.openai.com/api-keys"
OPENAI_KEY=""
while true; do
    OPENAI_KEY=$(get_input "Enter your OpenAI API key")
    if validate_key "$OPENAI_KEY" "openai"; then
        break
    fi
done

echo ""

# DeepSeek API Key
print_status "2. DeepSeek API Key (Required)"
print_status "   Get it from: https://platform.deepseek.com/api_keys"
DEEPSEEK_KEY=""
while true; do
    DEEPSEEK_KEY=$(get_input "Enter your DeepSeek API key")
    if validate_key "$DEEPSEEK_KEY" "deepseek"; then
        break
    fi
done

echo ""

# ElevenLabs API Key
print_status "3. ElevenLabs API Key (Required)"
print_status "   Get it from: https://elevenlabs.io/app/settings/api-keys"
ELEVENLABS_KEY=""
while true; do
    ELEVENLABS_KEY=$(get_input "Enter your ElevenLabs API key")
    if validate_key "$ELEVENLABS_KEY" "elevenlabs"; then
        break
    fi
done

echo ""

# ElevenLabs Voice ID
print_status "4. ElevenLabs Voice ID (Required)"
print_status "   Get it from: https://elevenlabs.io/app/voice-library"
ELEVENLABS_VOICE_ID=$(get_input "Enter your ElevenLabs Voice ID")

echo ""

# Optional API Keys
print_status "=== OPTIONAL API KEYS ==="
echo ""

# Gemini API Key
print_status "5. Google Gemini API Key (Optional)"
print_status "   Get it from: https://makersuite.google.com/app/apikey"
read -p "Enter your Gemini API key (or press Enter to skip): " GEMINI_KEY

# YouTube API Key
print_status "6. YouTube API Key (Optional)"
print_status "   Get it from: https://console.developers.google.com/"
read -p "Enter your YouTube API key (or press Enter to skip): " YOUTUBE_KEY

# Weather API Key
print_status "7. Weather API Key (Optional)"
print_status "   Get it from: https://openweathermap.org/api"
read -p "Enter your Weather API key (or press Enter to skip): " WEATHER_KEY

# Tavily API Key
print_status "8. Tavily API Key (Optional)"
print_status "   Get it from: https://tavily.com/"
TAVILY_KEY=""
read -p "Enter your Tavily API key (or press Enter to skip): " TAVILY_KEY
if [ -n "$TAVILY_KEY" ]; then
    while ! validate_key "$TAVILY_KEY" "tavily"; do
        read -p "Enter your Tavily API key (or press Enter to skip): " TAVILY_KEY
        if [ -z "$TAVILY_KEY" ]; then
            break
        fi
    done
fi

echo ""

# Create .env file
print_status "Creating .env file..."

cat > .env << EOF
# Chatsy API Keys Configuration
# Generated by AI Deployment Assistant

# OpenAI API Key (Required)
OPENAI_API_KEY=$OPENAI_KEY

# DeepSeek API Key (Required)
DEEPSEEK_API_KEY=$DEEPSEEK_KEY

# ElevenLabs API Key (Required)
ELEVENLABS_API_KEY=$ELEVENLABS_KEY
ELEVENLABS_VOICE_ID=$ELEVENLABS_VOICE_ID

# Google Gemini API Key (Optional)
GEMINI_API_KEY=${GEMINI_KEY:-YOUR_GEMINI_API_KEY_HERE}

# YouTube API Key (Optional)
YOUTUBE_API_KEY=${YOUTUBE_KEY:-YOUR_YOUTUBE_API_KEY_HERE}

# Weather API Key (Optional)
WEATHER_API_KEY=${WEATHER_KEY:-YOUR_WEATHER_API_KEY_HERE}

# Tavily API Key (Optional)
TAVILY_API_KEY=${TAVILY_KEY:-YOUR_TAVILY_API_KEY_HERE}
EOF

print_success ".env file created successfully!"

# Validate the created file
print_status "Validating API keys..."

# Test OpenAI key (basic validation)
if [[ "$OPENAI_KEY" =~ ^sk- ]]; then
    print_success "✅ OpenAI API key format is valid"
else
    print_warning "⚠️ OpenAI API key format might be invalid"
fi

# Test DeepSeek key (basic validation)
if [[ "$DEEPSEEK_KEY" =~ ^sk- ]]; then
    print_success "✅ DeepSeek API key format is valid"
else
    print_warning "⚠️ DeepSeek API key format might be invalid"
fi

# Test ElevenLabs key (basic validation)
if [[ "$ELEVENLABS_KEY" =~ ^sk_ ]]; then
    print_success "✅ ElevenLabs API key format is valid"
else
    print_warning "⚠️ ElevenLabs API key format might be invalid"
fi

echo ""
print_success "🎉 API key setup completed successfully!"
print_status "Your .env file has been created with all the API keys"
print_warning "⚠️ Remember: Never commit the .env file to version control!"
print_status "The .env file is already added to .gitignore for security"

echo ""
print_status "Next steps:"
print_status "1. Run 'flutter pub get' to update dependencies"
print_status "2. Use the AI Deployment Assistant to build and deploy your app"
print_status "3. Test your app to ensure all API keys work correctly"

echo ""
print_success "Ready to deploy! 🚀"
