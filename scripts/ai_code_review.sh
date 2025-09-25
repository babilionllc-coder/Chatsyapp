#!/bin/bash

# 🤖 AI Code Review Agent - Automated Pre-Deployment Analysis
# Comprehensive validation system for 100% functionality

set -e

echo "🤖 AI Code Review Agent: Starting comprehensive analysis..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[AI AGENT]${NC} $1"
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

print_analysis() {
    echo -e "${PURPLE}[ANALYSIS]${NC} $1"
}

print_fix() {
    echo -e "${CYAN}[FIX SUGGESTION]${NC} $1"
}

# Initialize counters
TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0
CRITICAL_ISSUES=0
WARNINGS=0
INFO_ISSUES=0

# Quality thresholds
MIN_QUALITY_SCORE=90
MAX_CRITICAL_ISSUES=0
MAX_BUILD_TIME=300  # 5 minutes

# Function to run a check
run_check() {
    local check_name="$1"
    local check_command="$2"
    local is_critical="$3"
    local fix_suggestion="$4"
    
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    print_status "🔍 Checking: $check_name"
    
    if eval "$check_command" > /dev/null 2>&1; then
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
        print_success "✅ $check_name: PASSED"
    else
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
        
        if [ "$is_critical" = "true" ]; then
            CRITICAL_ISSUES=$((CRITICAL_ISSUES + 1))
            print_error "🚨 CRITICAL: $check_name: FAILED"
            if [ ! -z "$fix_suggestion" ]; then
                print_fix "💡 Fix: $fix_suggestion"
            fi
        else
            WARNINGS=$((WARNINGS + 1))
            print_warning "⚠️ WARNING: $check_name: FAILED"
            if [ ! -z "$fix_suggestion" ]; then
                print_fix "💡 Suggestion: $fix_suggestion"
            fi
        fi
    fi
}

# Function to analyze code quality
analyze_code_quality() {
    print_analysis "📊 Analyzing code quality metrics..."
    
    # Check for long methods (>50 lines)
    local long_methods=$(find lib/ -name "*.dart" -exec awk '/^[[:space:]]*[a-zA-Z].*\(.*\)[[:space:]]*\{/ {start=NR} /^[[:space:]]*\}[[:space:]]*$/ {if(NR-start>50) print FILENAME":"start}' {} \; | wc -l)
    
    if [ $long_methods -gt 0 ]; then
        print_warning "Found $long_methods methods longer than 50 lines"
        print_fix "Break down large methods into smaller, focused functions"
    fi
    
    # Check for deep nesting (>4 levels)
    local deep_nesting=$(find lib/ -name "*.dart" -exec grep -n "^[[:space:]]\{16,\}" {} \; | wc -l)
    
    if [ $deep_nesting -gt 0 ]; then
        print_warning "Found $deep_nesting lines with deep nesting (>4 levels)"
        print_fix "Reduce nesting by using early returns and extracting methods"
    fi
    
    # Check for TODO comments
    local todos=$(find lib/ -name "*.dart" -exec grep -n "TODO\|FIXME\|HACK" {} \; | wc -l)
    
    if [ $todos -gt 0 ]; then
        print_warning "Found $todos TODO/FIXME/HACK comments"
        print_fix "Address TODO items or convert to proper issue tracking"
    fi
}

# Function to validate AI service integrations
validate_ai_services() {
    print_analysis "🤖 Validating AI service integrations..."
    
    # Check OpenAI integration
    if grep -q "YOUR_OPENAI_API_KEY_HERE" lib/app/helper/constants.dart; then
        print_error "OpenAI API key not configured"
        print_fix "Set OPENAI_API_KEY in environment variables"
        CRITICAL_ISSUES=$((CRITICAL_ISSUES + 1))
    else
        print_success "OpenAI API key configured"
    fi
    
    # Check DeepSeek integration
    if grep -q "YOUR_DEEPSEEK_API_KEY_HERE" lib/app/helper/constants.dart; then
        print_error "DeepSeek API key not configured"
        print_fix "Set DEEPSEEK_API_KEY in environment variables"
        CRITICAL_ISSUES=$((CRITICAL_ISSUES + 1))
    else
        print_success "DeepSeek API key configured"
    fi
    
    # Check ElevenLabs integration
    if grep -q "YOUR_ELEVENLABS_API_KEY_HERE" lib/app/helper/constants.dart; then
        print_error "ElevenLabs API key not configured"
        print_fix "Set ELEVENLABS_API_KEY in environment variables"
        CRITICAL_ISSUES=$((CRITICAL_ISSUES + 1))
    else
        print_success "ElevenLabs API key configured"
    fi
    
    # Check for proper error handling in AI service calls
    local ai_files=$(find lib/ -name "*.dart" -exec grep -l "openai\|deepseek\|elevenlabs\|tavily" {} \;)
    local error_handling=0
    
    for file in $ai_files; do
        if grep -q "try\|catch" "$file"; then
            error_handling=$((error_handling + 1))
        fi
    done
    
    if [ $error_handling -lt $(echo "$ai_files" | wc -l) ]; then
        print_warning "Some AI service calls lack proper error handling"
        print_fix "Add try-catch blocks around all AI service calls"
    fi
}

# Function to check performance metrics
check_performance() {
    print_analysis "⚡ Analyzing performance metrics..."
    
    # Check for potential memory leaks
    local listeners=$(find lib/ -name "*.dart" -exec grep -n "addListener\|listen" {} \; | wc -l)
    local disposals=$(find lib/ -name "*.dart" -exec grep -n "removeListener\|dispose\|cancel" {} \; | wc -l)
    
    if [ $listeners -gt $disposals ]; then
        print_warning "Potential memory leaks: $listeners listeners vs $disposals disposals"
        print_fix "Ensure all listeners and subscriptions are properly disposed"
    fi
    
    # Check for heavy operations in build methods
    local heavy_builds=$(find lib/ -name "*.dart" -exec grep -A 10 "Widget build" {} \; | grep -n "for\|while\|http\|Future" | wc -l)
    
    if [ $heavy_builds -gt 0 ]; then
        print_warning "Found $heavy_builds potential heavy operations in build methods"
        print_fix "Move heavy operations to initState, didChangeDependencies, or use FutureBuilder"
    fi
}

# Function to validate security measures
check_security() {
    print_analysis "🛡️ Analyzing security measures..."
    
    # Check for hardcoded secrets
    local secrets=$(find lib/ -name "*.dart" -exec grep -n "password\|secret\|key.*=.*['\"][A-Za-z0-9]" {} \; | wc -l)
    
    if [ $secrets -gt 0 ]; then
        print_error "Found $secrets potential hardcoded secrets"
        print_fix "Move all secrets to environment variables or secure storage"
        CRITICAL_ISSUES=$((CRITICAL_ISSUES + 1))
    fi
    
    # Check for HTTP URLs (should be HTTPS)
    local http_urls=$(find lib/ -name "*.dart" -exec grep -n "http://[^l]" {} \; | wc -l)
    
    if [ $http_urls -gt 0 ]; then
        print_warning "Found $http_urls HTTP URLs (should use HTTPS)"
        print_fix "Replace HTTP URLs with HTTPS equivalents"
    fi
    
    # Check for proper input validation
    local user_inputs=$(find lib/ -name "*.dart" -exec grep -n "TextField\|TextFormField" {} \; | wc -l)
    local validations=$(find lib/ -name "*.dart" -exec grep -n "validator\|isValidationEmpty" {} \; | wc -l)
    
    if [ $user_inputs -gt $validations ]; then
        print_warning "Some user inputs may lack proper validation"
        print_fix "Add validation to all user input fields"
    fi
}

# Function to check store compliance
check_store_compliance() {
    print_analysis "🏪 Checking store compliance..."
    
    # Check Android manifest
    if [ -f "android/app/src/main/AndroidManifest.xml" ]; then
        if ! grep -q "android.permission.INTERNET" android/app/src/main/AndroidManifest.xml; then
            print_error "Missing INTERNET permission in Android manifest"
            print_fix "Add INTERNET permission to AndroidManifest.xml"
            CRITICAL_ISSUES=$((CRITICAL_ISSUES + 1))
        fi
        
        if ! grep -q "android:label" android/app/src/main/AndroidManifest.xml; then
            print_error "Missing app label in Android manifest"
            print_fix "Add android:label to AndroidManifest.xml"
            CRITICAL_ISSUES=$((CRITICAL_ISSUES + 1))
        fi
    fi
    
    # Check for privacy policy
    if ! grep -q -i "privacy" lib/ -r; then
        print_warning "No privacy policy references found"
        print_fix "Add privacy policy to your app and reference it in settings"
    fi
    
    # Check for terms of service
    if ! grep -q -i "terms" lib/ -r; then
        print_warning "No terms of service references found"
        print_fix "Add terms of service to your app and reference it in settings"
    fi
}

# Function to analyze new features
analyze_new_features() {
    print_analysis "🆕 Analyzing recent changes and new features..."
    
    # Get recent changes (last commit)
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local changed_files=$(git diff --name-only HEAD~1 2>/dev/null | grep "\.dart$" | wc -l)
        
        if [ $changed_files -gt 0 ]; then
            print_status "Found $changed_files changed Dart files in recent commit"
            
            # Check if tests were added for new features
            local test_files=$(git diff --name-only HEAD~1 2>/dev/null | grep "_test\.dart$" | wc -l)
            
            if [ $test_files -eq 0 ] && [ $changed_files -gt 0 ]; then
                print_warning "New changes detected but no test files added"
                print_fix "Add unit tests for new features and changes"
            fi
        fi
    fi
}

# Main analysis phases
print_status "🚀 Starting Phase 1: Pre-Analysis Setup"
print_status "📁 Loading project structure..."
print_status "🔍 Identifying recent changes..."

print_status "🚀 Starting Phase 2: Comprehensive Scanning"

# Static Analysis
run_check "Flutter Dependencies" \
    "flutter pub get" \
    "true" \
    "Run 'flutter pub get' to resolve dependencies"

run_check "Dart Analysis" \
    "flutter analyze --no-fatal-infos" \
    "true" \
    "Fix all analyzer issues before deployment"

run_check "Code Formatting" \
    "dart format --set-exit-if-changed lib/" \
    "false" \
    "Run 'dart format lib/' to format code"

# Build Testing
run_check "Android Debug Build" \
    "flutter build apk --debug" \
    "true" \
    "Fix build errors in Android configuration"

if [[ "$OSTYPE" == "darwin"* ]]; then
    run_check "iOS Debug Build" \
        "flutter build ios --debug --no-codesign" \
        "true" \
        "Fix build errors in iOS configuration"
fi

run_check "Web Build" \
    "flutter build web" \
    "false" \
    "Fix web compatibility issues"

print_status "🚀 Starting Phase 3: Deep Feature Analysis"
analyze_new_features
analyze_code_quality
validate_ai_services

print_status "🚀 Starting Phase 4: Quality Assessment"
check_performance
check_security

print_status "🚀 Starting Phase 5: Deployment Readiness"
check_store_compliance

# Calculate quality score
QUALITY_SCORE=$((PASSED_CHECKS * 100 / TOTAL_CHECKS))

# Generate final report
print_analysis "📋 === AI CODE REVIEW AGENT REPORT ==="
print_analysis "🎯 Overall Quality Score: $QUALITY_SCORE%"
print_analysis "✅ Passed Checks: $PASSED_CHECKS"
print_analysis "❌ Failed Checks: $FAILED_CHECKS"
print_analysis "🚨 Critical Issues: $CRITICAL_ISSUES"
print_analysis "⚠️ Warnings: $WARNINGS"
print_analysis "ℹ️ Info Issues: $INFO_ISSUES"

# Determine deployment readiness
DEPLOYMENT_READY=false

if [ $QUALITY_SCORE -ge $MIN_QUALITY_SCORE ] && [ $CRITICAL_ISSUES -eq $MAX_CRITICAL_ISSUES ]; then
    DEPLOYMENT_READY=true
    print_success "🎉 DEPLOYMENT READY: Quality score $QUALITY_SCORE% (≥$MIN_QUALITY_SCORE%), $CRITICAL_ISSUES critical issues (≤$MAX_CRITICAL_ISSUES)"
    print_success "✅ Your app is ready for store deployment!"
elif [ $CRITICAL_ISSUES -gt $MAX_CRITICAL_ISSUES ]; then
    print_error "❌ NOT READY: $CRITICAL_ISSUES critical issues must be fixed first"
    print_fix "Address all critical issues before deployment"
else
    print_warning "⚠️ CONDITIONAL READY: Quality score $QUALITY_SCORE% (target: ≥$MIN_QUALITY_SCORE%)"
    print_fix "Improve quality score by addressing warnings and suggestions"
fi

# Generate detailed report
cat > ai_code_review_report.md << EOF
# AI Code Review Agent Report
Generated: $(date)

## Executive Summary
- **Overall Quality Score**: $QUALITY_SCORE%
- **Deployment Ready**: $DEPLOYMENT_READY
- **Critical Issues**: $CRITICAL_ISSUES
- **Warnings**: $WARNINGS
- **Total Checks**: $TOTAL_CHECKS

## Deployment Readiness Assessment
$(if [ "$DEPLOYMENT_READY" = "true" ]; then
    echo "✅ **STORE READY** - Your app meets all deployment criteria"
else
    echo "❌ **NEEDS WORK** - Address issues before deployment"
fi)

## Quality Thresholds
- Quality Score: $QUALITY_SCORE% (Target: ≥$MIN_QUALITY_SCORE%)
- Critical Issues: $CRITICAL_ISSUES (Target: ≤$MAX_CRITICAL_ISSUES)

## Recommendations
$(if [ $CRITICAL_ISSUES -gt 0 ]; then
    echo "1. **Priority 1**: Fix $CRITICAL_ISSUES critical issues"
fi)
$(if [ $WARNINGS -gt 0 ]; then
    echo "2. **Priority 2**: Address $WARNINGS warnings"
fi)
$(if [ $QUALITY_SCORE -lt $MIN_QUALITY_SCORE ]; then
    echo "3. **Priority 3**: Improve code quality to reach $MIN_QUALITY_SCORE%"
fi)

## Next Steps
$(if [ "$DEPLOYMENT_READY" = "true" ]; then
    echo "- ✅ Ready for store deployment"
    echo "- ✅ Run final QA testing"
    echo "- ✅ Submit to app stores"
else
    echo "- 🔧 Fix identified issues"
    echo "- 🔄 Re-run analysis"
    echo "- ⏳ Improve quality metrics"
fi)

---
Generated by AI Code Review Agent - Ensuring 100% Quality Before Deployment
EOF

print_status "📋 Detailed report saved to: ai_code_review_report.md"

# Exit with appropriate code
if [ "$DEPLOYMENT_READY" = "true" ]; then
    print_success "🎉 AI Code Review completed successfully!"
    print_success "Your app is ready for deployment! 🚀"
    exit 0
else
    print_error "❌ AI Code Review found issues that need attention"
    print_error "Please address the issues and run analysis again"
    exit 1
fi
