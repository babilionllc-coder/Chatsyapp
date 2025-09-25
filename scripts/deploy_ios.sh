#!/bin/bash

# 🤖 AI Deployment Script - iOS
# Automated iOS app deployment to Apple App Store

set -e  # Exit on any error

echo "🍎 Starting iOS deployment..."

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

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "iOS deployment requires macOS"
    exit 1
fi

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

# Check Xcode installation
if ! command -v xcodebuild &> /dev/null; then
    print_error "Xcode not found! Please install Xcode from App Store"
    exit 1
fi

print_success "Xcode found"

# Clean previous build
print_status "Cleaning previous build..."
flutter clean

# Get dependencies
print_status "Getting dependencies..."
flutter pub get

# Check Flutter doctor
print_status "Checking Flutter environment..."
flutter doctor

# Build iOS app
print_status "Building iOS app..."
flutter build ios --release

# Check if iOS build was created
if [ -d "build/ios/Release-iphoneos/Runner.app" ]; then
    print_success "iOS app built successfully!"
    
    # Get app info
    app_size=$(du -sh build/ios/Release-iphoneos/Runner.app | cut -f1)
    print_status "App size: $app_size"
    
    # Optional: Install on connected iOS device
    if command -v ios-deploy &> /dev/null; then
        print_status "Checking for connected iOS devices..."
        if ios-deploy --detect | grep -q "Found"; then
            print_status "Installing app on connected iOS device..."
            ios-deploy --bundle build/ios/Release-iphoneos/Runner.app
            print_success "App installed on iOS device!"
        else
            print_warning "No iOS devices connected"
        fi
    fi
    
    # Optional: Upload to App Store Connect (requires additional setup)
    if [ "$UPLOAD_TO_APP_STORE" = "true" ]; then
        print_status "Uploading to App Store Connect..."
        # This would require App Store Connect API setup
        print_warning "App Store Connect upload requires additional API setup"
    fi
    
else
    print_error "iOS build failed!"
    exit 1
fi

print_success "iOS deployment completed successfully! 🎉"
print_status "App location: build/ios/Release-iphoneos/Runner.app"
