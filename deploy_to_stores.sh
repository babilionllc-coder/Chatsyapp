#!/bin/bash

echo "🚀 CHATSY App Deployment Script"
echo "=================================="

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

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

print_status "Flutter version:"
flutter --version

# Clean and get dependencies
print_status "Cleaning project and getting dependencies..."
flutter clean
flutter pub get

# Build Android App Bundle
print_status "Building Android App Bundle (AAB)..."
flutter build appbundle --release

if [ $? -eq 0 ]; then
    print_success "Android App Bundle built successfully!"
    print_status "Android AAB location: build/app/outputs/bundle/release/app-release.aab"
else
    print_error "Failed to build Android App Bundle"
    exit 1
fi

# Build iOS (will fail without proper signing, but we'll try)
print_status "Attempting to build iOS app..."
flutter build ios --release --no-codesign

if [ $? -eq 0 ]; then
    print_success "iOS app built successfully (without signing)!"
    print_status "iOS app location: build/ios/iphoneos/Runner.app"
else
    print_warning "iOS build failed (likely due to signing issues)"
    print_status "This is normal if you haven't set up iOS signing certificates"
fi

# Create deployment package
print_status "Creating deployment package..."
DEPLOY_DIR="CHATSY_Deployment_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$DEPLOY_DIR"

# Copy Android AAB
if [ -f "build/app/outputs/bundle/release/app-release.aab" ]; then
    cp build/app/outputs/bundle/release/app-release.aab "$DEPLOY_DIR/"
    print_success "Android AAB copied to $DEPLOY_DIR/"
fi

# Copy iOS app (if built)
if [ -d "build/ios/iphoneos/Runner.app" ]; then
    cp -r build/ios/iphoneos/Runner.app "$DEPLOY_DIR/"
    print_success "iOS app copied to $DEPLOY_DIR/"
fi

# Copy Firebase configuration files
print_status "Copying Firebase configuration..."
cp android/app/google-services.json "$DEPLOY_DIR/" 2>/dev/null || print_warning "Google Services JSON not found"
cp ios/Runner/GoogleService-Info.plist "$DEPLOY_DIR/" 2>/dev/null || print_warning "Google Service Info plist not found"

# Copy app icons and metadata
print_status "Copying app metadata..."
mkdir -p "$DEPLOY_DIR/metadata"
cp -r android/app/src/main/res/mipmap-* "$DEPLOY_DIR/metadata/" 2>/dev/null || print_warning "Android icons not found"
cp -r ios/Runner/Assets.xcassets "$DEPLOY_DIR/metadata/" 2>/dev/null || print_warning "iOS assets not found"

# Create deployment instructions
cat > "$DEPLOY_DIR/DEPLOYMENT_INSTRUCTIONS.md" << EOF
# CHATSY App Deployment Instructions

## App Information
- **App Name**: ChatSY
- **Bundle ID**: com.aichatsy.app
- **Firebase Project**: ai-chatsy-390411

## Android Deployment (Google Play Store)

### 1. Upload to Google Play Console
1. Go to [Google Play Console](https://play.google.com/console)
2. Select your app or create a new one
3. Go to "Release" > "Production"
4. Click "Create new release"
5. Upload the \`app-release.aab\` file
6. Fill in release notes
7. Review and publish

### 2. Required Information
- **App Category**: Productivity or Communication
- **Content Rating**: 12+ (due to AI features)
- **Privacy Policy**: Required for apps with AI features
- **Target Audience**: General audience

## iOS Deployment (App Store)

### 1. Prerequisites
- Apple Developer Account ($99/year)
- Xcode installed
- Valid signing certificates

### 2. Signing Setup
1. Open \`ios/Runner.xcworkspace\` in Xcode
2. Select your development team
3. Configure bundle identifier: \`com.aichatsy.app\`
4. Set up provisioning profiles

### 3. Upload to App Store Connect
1. Build for iOS with proper signing:
   \`flutter build ios --release\`
2. Archive in Xcode
3. Upload to App Store Connect
4. Submit for review

## Firebase Configuration
- All Firebase services are configured
- Backend API endpoints are live at: https://us-central1-ai-chatsy-390411.cloudfunctions.net/api
- Health check: https://us-central1-ai-chatsy-390411.cloudfunctions.net/api/api/health.json

## AI Features Included
- ✅ GPT-5 Integration
- ✅ DeepSeek AI Models
- ✅ Google Gemini
- ✅ ElevenLabs Voice
- ✅ Real-time Web Search
- ✅ YouTube Analysis
- ✅ Document Summarization
- ✅ Image Analysis

## Support
For technical support, contact: aichatsyapp@gmail.com
EOF

print_success "Deployment package created: $DEPLOY_DIR"
print_status "Contents:"
ls -la "$DEPLOY_DIR"

echo ""
print_success "🎉 Deployment preparation complete!"
print_status "Next steps:"
echo "1. Upload Android AAB to Google Play Console"
echo "2. Set up iOS signing and upload to App Store Connect"
echo "3. Both stores will review and approve your app"
echo ""
print_status "Your CHATSY app is ready for the world! 🌍"



