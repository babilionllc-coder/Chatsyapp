#!/bin/bash

# 🤖 AI Deployment Script - Android
# Automated Android app deployment to Google Play Store

set -e  # Exit on any error

echo "🚀 Starting Android deployment..."

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

# Check if .env file exists
if [ ! -f ".env" ]; then
    print_error ".env file not found!"
    print_warning "Please create .env file with your API keys first"
    print_status "You can copy env.example to .env and add your keys"
    exit 1
fi

print_success ".env file found"

# Load environment variables
export $(cat .env | grep -v '^#' | xargs)

# Validate required API keys
required_keys=("OPENAI_API_KEY" "DEEPSEEK_API_KEY" "ELEVENLABS_API_KEY")
missing_keys=()

for key in "${required_keys[@]}"; do
    if [ -z "${!key}" ] || [[ "${!key}" == *"YOUR_"* ]]; then
        missing_keys+=("$key")
    fi
done

if [ ${#missing_keys[@]} -ne 0 ]; then
    print_error "Missing or invalid API keys: ${missing_keys[*]}"
    print_warning "Please update your .env file with valid API keys"
    exit 1
fi

print_success "All required API keys are configured"

# Clean previous build
print_status "Cleaning previous build..."
flutter clean

# Get dependencies
print_status "Getting dependencies..."
flutter pub get

# Check Flutter doctor
print_status "Checking Flutter environment..."
flutter doctor

# Build Android APK
print_status "Building Android APK..."
flutter build apk --release

# Check if APK was created
if [ -f "build/app/outputs/flutter-apk/app-release.apk" ]; then
    print_success "Android APK built successfully!"
    
    # Get APK info
    apk_size=$(du -h build/app/outputs/flutter-apk/app-release.apk | cut -f1)
    print_status "APK size: $apk_size"
    
    # Optional: Install APK on connected device
    if command -v adb &> /dev/null; then
        print_status "Checking for connected Android devices..."
        if adb devices | grep -q "device$"; then
            print_status "Installing APK on connected device..."
            adb install -r build/app/outputs/flutter-apk/app-release.apk
            print_success "APK installed on device!"
        else
            print_warning "No Android devices connected"
        fi
    fi
    
    # Optional: Upload to Google Play Console (requires additional setup)
    if [ "$UPLOAD_TO_PLAY_STORE" = "true" ]; then
        print_status "Uploading to Google Play Console..."
        # This would require Google Play Console API setup
        print_warning "Google Play Console upload requires additional API setup"
    fi
    
else
    print_error "APK build failed!"
    exit 1
fi

print_success "Android deployment completed successfully! 🎉"
print_status "APK location: build/app/outputs/flutter-apk/app-release.apk"
