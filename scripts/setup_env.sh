#!/bin/bash

# 🔐 Environment Setup Script
# Secure API key configuration for Chatsy app

set -e

echo "🔐 Setting up environment variables for Chatsy..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Check if .env file exists
if [ -f ".env" ]; then
    print_warning ".env file already exists!"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Keeping existing .env file"
        exit 0
    fi
fi

print_status "Creating .env file with secure API key placeholders..."

# Create .env file
cat > .env << EOF
# Required API Keys - Replace with your actual keys
OPENAI_API_KEY=sk-your-actual-openai-key-here
DEEPSEEK_API_KEY=sk-your-actual-deepseek-key-here
ELEVENLABS_API_KEY=sk-your-actual-elevenlabs-key-here
ELEVENLABS_VOICE_ID=your-voice-id-here

# Optional API Keys
GEMINI_API_KEY=your-gemini-key-here
YOUTUBE_API_KEY=your-youtube-key-here
WEATHER_API_KEY=your-weather-key-here
TAVILY_API_KEY=your-tavily-key-here

# Add any other environment variables here
# For example:
# BACKEND_BASE_URL=https://your-backend-api.com/
# APP_VERSION=1.0.0
EOF

print_success ".env file created successfully!"

print_status "Next steps:"
echo "1. Edit the .env file with your actual API keys"
echo "2. Replace the placeholder values with your real keys"
echo "3. Never commit the .env file to version control"
echo "4. Run './scripts/run_qa_tests.sh' to test your setup"

print_warning "IMPORTANT: Never commit .env file to Git!"
print_warning "The .env file is already in .gitignore for security"

# Check if user wants to configure keys now
read -p "Do you want to configure API keys now? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Opening .env file for editing..."
    
    # Try to open with common editors
    if command -v code &> /dev/null; then
        code .env
    elif command -v nano &> /dev/null; then
        nano .env
    elif command -v vim &> /dev/null; then
        vim .env
    else
        print_status "Please edit .env file manually with your preferred editor"
    fi
fi

print_success "Environment setup complete!"
print_status "Run './scripts/run_qa_tests.sh' to test your configuration"
