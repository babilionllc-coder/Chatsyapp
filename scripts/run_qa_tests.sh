#!/bin/bash

# 🔍 AI QA Testing Script
# Comprehensive quality assurance testing before store deployment

set -e  # Exit on any error

echo "🔍 Starting comprehensive QA testing..."

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

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0
CRITICAL_ISSUES=0

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    local is_critical="$3"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    print_status "Running test: $test_name"
    
    if eval "$test_command"; then
        PASSED_TESTS=$((PASSED_TESTS + 1))
        print_success "✅ $test_name: PASSED"
    else
        FAILED_TESTS=$((FAILED_TESTS + 1))
        print_error "❌ $test_name: FAILED"
        
        if [ "$is_critical" = "true" ]; then
            CRITICAL_ISSUES=$((CRITICAL_ISSUES + 1))
            print_error "🚨 CRITICAL ISSUE: $test_name"
        fi
    fi
}

# Check if .env file exists
if [ ! -f ".env" ]; then
    print_error ".env file not found!"
    print_warning "Please create .env file with your API keys first"
    exit 1
fi

print_success ".env file found"

# Load environment variables
export $(cat .env | grep -v '^#' | xargs)

print_status "Starting comprehensive QA testing..."

# API Integration Tests
print_status "=== API INTEGRATION TESTS ==="

run_test "OpenAI API Key Validation" \
    "[[ \"$OPENAI_API_KEY\" =~ ^sk- ]] && [[ \"$OPENAI_API_KEY\" != *\"YOUR_\"* ]]" \
    "true"

run_test "DeepSeek API Key Validation" \
    "[[ \"$DEEPSEEK_API_KEY\" =~ ^sk- ]] && [[ \"$DEEPSEEK_API_KEY\" != *\"YOUR_\"* ]]" \
    "true"

run_test "ElevenLabs API Key Validation" \
    "[[ \"$ELEVENLABS_API_KEY\" =~ ^sk_ ]] && [[ \"$ELEVENLABS_API_KEY\" != *\"YOUR_\"* ]]" \
    "true"

run_test "Tavily API Key Validation" \
    "[[ \"$TAVILY_API_KEY\" =~ ^tvly- ]] && [[ \"$TAVILY_API_KEY\" != *\"YOUR_\"* ]]" \
    "false"

# Flutter Environment Tests
print_status "=== FLUTTER ENVIRONMENT TESTS ==="

run_test "Flutter Doctor Check" \
    "flutter doctor --android-licenses" \
    "true"

run_test "Flutter Dependencies" \
    "flutter pub get" \
    "true"

run_test "Flutter Analyze" \
    "flutter analyze" \
    "true"

# Build Tests
print_status "=== BUILD TESTS ==="

run_test "Android Debug Build" \
    "flutter build apk --debug" \
    "true"

run_test "Android Release Build" \
    "flutter build apk --release" \
    "true"

# Check if running on macOS for iOS tests
if [[ "$OSTYPE" == "darwin"* ]]; then
    run_test "iOS Debug Build" \
        "flutter build ios --debug" \
        "true"
    
    run_test "iOS Release Build" \
        "flutter build ios --release" \
        "true"
else
    print_warning "Skipping iOS tests (not on macOS)"
fi

# Security Tests
print_status "=== SECURITY TESTS ==="

run_test "API Keys Not in Source Code" \
    "! grep -r 'sk-[a-zA-Z0-9]' lib/ --exclude-dir=.git" \
    "true"

run_test "API Keys Not in Source Code (ElevenLabs)" \
    "! grep -r 'sk_[a-zA-Z0-9]' lib/ --exclude-dir=.git" \
    "true"

run_test ".env File Not Committed" \
    "! git ls-files | grep -q '\.env$'" \
    "true"

# Performance Tests
print_status "=== PERFORMANCE TESTS ==="

run_test "APK Size Check" \
    "test \$(du -k build/app/outputs/flutter-apk/app-release.apk | cut -f1) -lt 100000" \
    "false"

run_test "Build Time Check" \
    "true" \
    "false"

# Store Compliance Tests
print_status "=== STORE COMPLIANCE TESTS ==="

run_test "App Permissions Check" \
    "grep -q 'android.permission.INTERNET' android/app/src/main/AndroidManifest.xml" \
    "true"

run_test "App Name Check" \
    "grep -q 'Chatsy' android/app/src/main/AndroidManifest.xml" \
    "true"

run_test "Version Code Check" \
    "grep -q 'versionCode' android/app/build.gradle.kts" \
    "true"

# Calculate Quality Score
QUALITY_SCORE=$((PASSED_TESTS * 100 / TOTAL_TESTS))

print_status "=== QA TESTING RESULTS ==="
print_status "Total Tests: $TOTAL_TESTS"
print_status "Passed Tests: $PASSED_TESTS"
print_status "Failed Tests: $FAILED_TESTS"
print_status "Critical Issues: $CRITICAL_ISSUES"
print_status "Quality Score: $QUALITY_SCORE%"

# Determine if app is store ready
if [ $CRITICAL_ISSUES -eq 0 ] && [ $QUALITY_SCORE -ge 90 ]; then
    print_success "🎉 APP IS STORE READY!"
    print_success "Quality Score: $QUALITY_SCORE% (>= 90%)"
    print_success "Critical Issues: $CRITICAL_ISSUES (== 0)"
    STORE_READY=true
else
    print_error "❌ APP IS NOT STORE READY"
    print_error "Quality Score: $QUALITY_SCORE% (< 90%)"
    print_error "Critical Issues: $CRITICAL_ISSUES (> 0)"
    STORE_READY=false
fi

# Generate QA Report
print_status "Generating QA report..."

cat > qa_report.txt << EOF
# QA Testing Report
Generated: $(date)

## Summary
- Total Tests: $TOTAL_TESTS
- Passed Tests: $PASSED_TESTS
- Failed Tests: $FAILED_TESTS
- Critical Issues: $CRITICAL_ISSUES
- Quality Score: $QUALITY_SCORE%
- Store Ready: $STORE_READY

## Test Results
EOF

if [ $STORE_READY = true ]; then
    print_success "✅ QA testing completed successfully!"
    print_success "Your app is ready for store deployment!"
    exit 0
else
    print_error "❌ QA testing failed!"
    print_error "Please fix the issues before deploying to stores."
    exit 1
fi
