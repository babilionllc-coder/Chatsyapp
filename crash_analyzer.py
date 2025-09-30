#!/usr/bin/env python3
"""
Crash Analyzer Module
Advanced crash analysis tools for Firebase Crashlytics
"""

import re
import json
import os
from typing import Dict, List, Any, Optional, Tuple
from datetime import datetime, timedelta
from pathlib import Path
import subprocess

class CrashAnalyzer:
    """Advanced crash analysis system for Firebase Crashlytics"""
    
    def __init__(self, project_path: str = "/Users/alexjego/Desktop/CHATSY"):
        self.project_path = Path(project_path)
        self.analysis_patterns = self._load_analysis_patterns()
        self.crash_database = {}
    
    def _load_analysis_patterns(self) -> Dict[str, Any]:
        """Load crash analysis patterns and rules"""
        return {
            "stack_trace_patterns": {
                "image_loading": [
                    r"cached_network_image",
                    r"ImageLoader\.loadImageAsync",
                    r"Invalid image data",
                    r"image_provider",
                    r"NetworkImage",
                    r"image\.dart"
                ],
                "network": [
                    r"SocketException",
                    r"TimeoutException",
                    r"NetworkException",
                    r"Connection.*failed",
                    r"HttpException",
                    r"dio"
                ],
                "memory": [
                    r"OutOfMemoryError",
                    r"Memory.*allocation",
                    r"Heap.*overflow",
                    r"Stack.*overflow",
                    r"memory.*leak"
                ],
                "ui_rendering": [
                    r"RenderFlex.*overflow",
                    r"RenderBox.*overflow",
                    r"constraint.*violation",
                    r"widget.*error",
                    r"build.*error"
                ],
                "data_parsing": [
                    r"JsonDecodeException",
                    r"FormatException",
                    r"parsing.*error",
                    r"decode.*error",
                    r"serialization.*error"
                ],
                "authentication": [
                    r"AuthException",
                    r"FirebaseAuth",
                    r"login.*failed",
                    r"token.*invalid",
                    r"credential.*error"
                ],
                "storage": [
                    r"FileSystemException",
                    r"DatabaseException",
                    r"sqlite.*error",
                    r"storage.*error",
                    r"io.*error"
                ],
                "native_plugin": [
                    r"PlatformException",
                    r"MethodChannel",
                    r"native.*error",
                    r"plugin.*error",
                    r"channel.*error"
                ],
                "flutter_framework": [
                    r"main\.dart",
                    r"Flutter.*initialization",
                    r"framework.*error",
                    r"widget.*binding",
                    r"runApp"
                ]
            },
            "error_keywords": {
                "critical": ["crash", "fatal", "exception", "error", "failed"],
                "warning": ["warning", "deprecated", "timeout", "retry"],
                "info": ["info", "debug", "trace", "log"]
            },
            "device_patterns": {
                "android": ["android", "samsung", "huawei", "xiaomi", "oneplus"],
                "ios": ["iphone", "ipad", "ios", "apple"]
            },
            "version_patterns": {
                "flutter": r"Flutter (\d+\.\d+\.\d+)",
                "android": r"Android (\d+)",
                "ios": r"iOS (\d+\.\d+)"
            }
        }
    
    def analyze_crash_log(self, crash_data: Dict[str, Any]) -> Dict[str, Any]:
        """Analyze a crash log and extract detailed information"""
        print(f"🔍 Analyzing crash log: {crash_data.get('title', 'Unknown')}")
        
        analysis = {
            "crash_id": crash_data.get('id', 'unknown'),
            "title": crash_data.get('title', ''),
            "subtitle": crash_data.get('subtitle', ''),
            "stack_trace": crash_data.get('stack_trace', []),
            "device_info": crash_data.get('device_info', {}),
            "app_info": crash_data.get('app_info', {}),
            "timestamp": crash_data.get('timestamp', datetime.now().isoformat()),
            "analysis_results": {}
        }
        
        # Analyze stack trace
        stack_analysis = self._analyze_stack_trace(crash_data.get('stack_trace', []))
        analysis["analysis_results"]["stack_trace"] = stack_analysis
        
        # Analyze device information
        device_analysis = self._analyze_device_info(crash_data.get('device_info', {}))
        analysis["analysis_results"]["device"] = device_analysis
        
        # Analyze app information
        app_analysis = self._analyze_app_info(crash_data.get('app_info', {}))
        analysis["analysis_results"]["app"] = app_analysis
        
        # Determine crash category and severity
        category = self._determine_crash_category(stack_analysis)
        severity = self._determine_crash_severity(crash_data, stack_analysis)
        
        analysis["analysis_results"]["category"] = category
        analysis["analysis_results"]["severity"] = severity
        
        # Generate root cause analysis
        root_cause = self._generate_root_cause_analysis(category, stack_analysis, device_analysis)
        analysis["analysis_results"]["root_cause"] = root_cause
        
        # Generate impact assessment
        impact = self._assess_crash_impact(crash_data, category, severity)
        analysis["analysis_results"]["impact"] = impact
        
        # Generate recommendations
        recommendations = self._generate_recommendations(category, root_cause, impact)
        analysis["analysis_results"]["recommendations"] = recommendations
        
        return analysis
    
    def _analyze_stack_trace(self, stack_trace: List[str]) -> Dict[str, Any]:
        """Analyze stack trace for patterns and issues"""
        if not stack_trace:
            return {"status": "no_stack_trace", "patterns": [], "issues": []}
        
        stack_text = '\n'.join(stack_trace)
        patterns_found = []
        issues_found = []
        
        # Check for specific patterns
        for category, patterns in self.analysis_patterns["stack_trace_patterns"].items():
            for pattern in patterns:
                if re.search(pattern, stack_text, re.IGNORECASE):
                    patterns_found.append({
                        "category": category,
                        "pattern": pattern,
                        "matches": re.findall(pattern, stack_text, re.IGNORECASE)
                    })
        
        # Look for error keywords
        for severity, keywords in self.analysis_patterns["error_keywords"].items():
            for keyword in keywords:
                if keyword.lower() in stack_text.lower():
                    issues_found.append({
                        "severity": severity,
                        "keyword": keyword,
                        "context": self._extract_context(stack_text, keyword)
                    })
        
        return {
            "status": "analyzed",
            "total_lines": len(stack_trace),
            "patterns_found": patterns_found,
            "issues_found": issues_found,
            "stack_depth": len(stack_trace),
            "top_functions": self._extract_top_functions(stack_trace),
            "error_location": self._find_error_location(stack_trace)
        }
    
    def _analyze_device_info(self, device_info: Dict[str, Any]) -> Dict[str, Any]:
        """Analyze device information for patterns"""
        analysis = {
            "platform": device_info.get('platform', 'unknown'),
            "model": device_info.get('model', 'unknown'),
            "os_version": device_info.get('os_version', 'unknown'),
            "memory": device_info.get('memory', 'unknown'),
            "storage": device_info.get('storage', 'unknown'),
            "patterns": []
        }
        
        # Analyze platform-specific patterns
        platform = device_info.get('platform', '').lower()
        if 'android' in platform:
            analysis["patterns"].append("android_platform")
            # Check for specific Android issues
            if device_info.get('os_version', ''):
                version = self._extract_version_number(device_info['os_version'])
                if version < 8:
                    analysis["patterns"].append("old_android_version")
                elif version >= 12:
                    analysis["patterns"].append("new_android_version")
        
        elif 'ios' in platform or 'iphone' in platform:
            analysis["patterns"].append("ios_platform")
            # Check for specific iOS issues
            if device_info.get('os_version', ''):
                version = self._extract_version_number(device_info['os_version'])
                if version < 13:
                    analysis["patterns"].append("old_ios_version")
                elif version >= 16:
                    analysis["patterns"].append("new_ios_version")
        
        # Analyze memory patterns
        memory = device_info.get('memory', '')
        if memory and 'gb' in memory.lower():
            memory_gb = float(re.search(r'(\d+(?:\.\d+)?)', memory).group(1))
            if memory_gb < 2:
                analysis["patterns"].append("low_memory_device")
            elif memory_gb >= 8:
                analysis["patterns"].append("high_memory_device")
        
        return analysis
    
    def _analyze_app_info(self, app_info: Dict[str, Any]) -> Dict[str, Any]:
        """Analyze app information for patterns"""
        analysis = {
            "version": app_info.get('version', 'unknown'),
            "build_number": app_info.get('build_number', 'unknown'),
            "package_name": app_info.get('package_name', 'unknown'),
            "install_source": app_info.get('install_source', 'unknown'),
            "patterns": []
        }
        
        # Analyze version patterns
        version = app_info.get('version', '')
        if version:
            version_parts = version.split('.')
            if len(version_parts) >= 2:
                major = int(version_parts[0])
                minor = int(version_parts[1])
                if major == 1 and minor <= 3:
                    analysis["patterns"].append("early_version")
                elif major >= 2:
                    analysis["patterns"].append("mature_version")
        
        # Analyze build patterns
        build_number = app_info.get('build_number', '')
        if build_number:
            try:
                build_num = int(build_number)
                if build_num < 100:
                    analysis["patterns"].append("early_build")
                elif build_num >= 1000:
                    analysis["patterns"].append("mature_build")
            except ValueError:
                pass
        
        return analysis
    
    def _determine_crash_category(self, stack_analysis: Dict[str, Any]) -> str:
        """Determine the primary crash category based on stack trace analysis"""
        patterns = stack_analysis.get('patterns_found', [])
        
        if not patterns:
            return "unknown"
        
        # Count category occurrences
        category_counts = {}
        for pattern in patterns:
            category = pattern['category']
            category_counts[category] = category_counts.get(category, 0) + 1
        
        # Return the most common category
        if category_counts:
            return max(category_counts.items(), key=lambda x: x[1])[0]
        
        return "unknown"
    
    def _determine_crash_severity(self, crash_data: Dict[str, Any], stack_analysis: Dict[str, Any]) -> str:
        """Determine crash severity based on multiple factors"""
        severity_score = 0
        
        # Factor 1: Number of affected users
        affected_users = crash_data.get('affected_users', 0)
        if affected_users >= 1000:
            severity_score += 40
        elif affected_users >= 100:
            severity_score += 30
        elif affected_users >= 10:
            severity_score += 20
        elif affected_users >= 1:
            severity_score += 10
        
        # Factor 2: Stack trace complexity
        issues = stack_analysis.get('issues_found', [])
        critical_issues = len([i for i in issues if i['severity'] == 'critical'])
        severity_score += critical_issues * 15
        
        # Factor 3: Crash category impact
        category = self._determine_crash_category(stack_analysis)
        high_impact_categories = ['memory', 'flutter_framework', 'native_plugin']
        if category in high_impact_categories:
            severity_score += 25
        
        # Factor 4: Device patterns
        device_patterns = crash_data.get('device_info', {}).get('patterns', [])
        if 'low_memory_device' in device_patterns:
            severity_score += 10
        
        # Determine severity level
        if severity_score >= 80:
            return "critical"
        elif severity_score >= 60:
            return "high"
        elif severity_score >= 40:
            return "medium"
        else:
            return "low"
    
    def _generate_root_cause_analysis(self, category: str, stack_analysis: Dict[str, Any], device_analysis: Dict[str, Any]) -> Dict[str, Any]:
        """Generate root cause analysis based on category and analysis results"""
        root_causes = []
        confidence = 0.0
        
        if category == "image_loading":
            root_causes = [
                "Invalid or corrupted image data from network source",
                "Network timeout or connection issues during image download",
                "Server returning error pages instead of valid images",
                "Image format not supported or corrupted during transmission",
                "Cached image corruption on device storage",
                "Content-Type header mismatch causing parsing errors"
            ]
            confidence = 0.85
        
        elif category == "network":
            root_causes = [
                "Poor network connectivity or intermittent connection",
                "Server overload, downtime, or rate limiting",
                "DNS resolution failures or routing issues",
                "Firewall or proxy blocking requests",
                "SSL/TLS certificate validation failures",
                "Network timeout configuration too aggressive"
            ]
            confidence = 0.80
        
        elif category == "memory":
            root_causes = [
                "Memory leak in image processing or caching",
                "Large image files without proper size optimization",
                "Infinite loops or excessive recursion",
                "Poor memory management in native plugins",
                "Device memory constraints on older hardware",
                "Memory fragmentation from frequent allocations"
            ]
            confidence = 0.75
        
        elif category == "ui_rendering":
            root_causes = [
                "Layout constraint violations in widget tree",
                "Null safety issues with widget properties",
                "Infinite widget rebuild loops",
                "Platform-specific rendering differences",
                "Memory pressure affecting UI rendering",
                "Widget lifecycle management issues"
            ]
            confidence = 0.70
        
        else:
            root_causes = ["Unknown or complex error requiring deeper investigation"]
            confidence = 0.30
        
        # Adjust confidence based on device patterns
        device_patterns = device_analysis.get('patterns', [])
        if 'low_memory_device' in device_patterns:
            confidence += 0.10
        if 'old_android_version' in device_patterns or 'old_ios_version' in device_patterns:
            confidence += 0.05
        
        return {
            "primary_causes": root_causes[:3],  # Top 3 most likely causes
            "all_causes": root_causes,
            "confidence": min(1.0, confidence),
            "device_factors": device_patterns,
            "recommended_investigation": self._get_investigation_steps(category)
        }
    
    def _assess_crash_impact(self, crash_data: Dict[str, Any], category: str, severity: str) -> Dict[str, Any]:
        """Assess the business and technical impact of the crash"""
        affected_users = crash_data.get('affected_users', 0)
        affected_sessions = crash_data.get('affected_sessions', 0)
        
        # User impact assessment
        if affected_users >= 1000:
            user_impact = "critical"
        elif affected_users >= 100:
            user_impact = "high"
        elif affected_users >= 10:
            user_impact = "medium"
        else:
            user_impact = "low"
        
        # Business impact assessment
        high_impact_categories = ['memory', 'flutter_framework', 'native_plugin']
        if category in high_impact_categories and severity in ['critical', 'high']:
            business_impact = "critical"
        elif severity in ['critical', 'high']:
            business_impact = "high"
        elif severity == 'medium':
            business_impact = "medium"
        else:
            business_impact = "low"
        
        # Technical complexity assessment
        complex_categories = ['native_plugin', 'flutter_framework', 'memory']
        if category in complex_categories:
            technical_complexity = "high"
        elif category in ['image_loading', 'ui_rendering']:
            technical_complexity = "medium"
        else:
            technical_complexity = "low"
        
        # Estimated fix time
        fix_time_estimates = {
            "critical": {"high": "2-4 days", "medium": "1-2 days", "low": "4-8 hours"},
            "high": {"high": "1-3 days", "medium": "4-8 hours", "low": "2-4 hours"},
            "medium": {"high": "4-8 hours", "medium": "2-4 hours", "low": "1-2 hours"},
            "low": {"high": "2-4 hours", "medium": "1-2 hours", "low": "30-60 minutes"}
        }
        
        estimated_fix_time = fix_time_estimates.get(severity, {}).get(technical_complexity, "unknown")
        
        return {
            "user_impact": user_impact,
            "business_impact": business_impact,
            "technical_complexity": technical_complexity,
            "affected_users": affected_users,
            "affected_sessions": affected_sessions,
            "estimated_fix_time": estimated_fix_time,
            "priority_score": self._calculate_priority_score(affected_users, severity, business_impact)
        }
    
    def _generate_recommendations(self, category: str, root_cause: Dict[str, Any], impact: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Generate prioritized recommendations based on analysis"""
        recommendations = []
        
        # Immediate actions based on severity
        if impact['business_impact'] == 'critical':
            recommendations.append({
                "priority": "immediate",
                "action": "Hotfix deployment required",
                "description": "Deploy immediate fix due to critical business impact",
                "estimated_time": "2-4 hours",
                "type": "deployment"
            })
        
        # Category-specific recommendations
        if category == "image_loading":
            recommendations.extend([
                {
                    "priority": "high",
                    "action": "Implement robust error handling",
                    "description": "Add errorWidget to all CachedNetworkImage widgets",
                    "estimated_time": "2-4 hours",
                    "type": "code_fix"
                },
                {
                    "priority": "high",
                    "action": "Add image validation",
                    "description": "Validate image URLs and data before processing",
                    "estimated_time": "4-6 hours",
                    "type": "code_fix"
                },
                {
                    "priority": "medium",
                    "action": "Implement retry mechanism",
                    "description": "Add automatic retry for failed image loads",
                    "estimated_time": "3-5 hours",
                    "type": "code_fix"
                },
                {
                    "priority": "medium",
                    "action": "Clear corrupted cache",
                    "description": "Implement cache clearing for corrupted images",
                    "estimated_time": "1-2 hours",
                    "type": "maintenance"
                }
            ])
        
        elif category == "network":
            recommendations.extend([
                {
                    "priority": "high",
                    "action": "Add connectivity checks",
                    "description": "Implement network connectivity validation",
                    "estimated_time": "2-3 hours",
                    "type": "code_fix"
                },
                {
                    "priority": "high",
                    "action": "Configure timeouts",
                    "description": "Set appropriate timeout values for network requests",
                    "estimated_time": "1-2 hours",
                    "type": "configuration"
                },
                {
                    "priority": "medium",
                    "action": "Implement retry logic",
                    "description": "Add exponential backoff retry mechanism",
                    "estimated_time": "3-4 hours",
                    "type": "code_fix"
                }
            ])
        
        elif category == "memory":
            recommendations.extend([
                {
                    "priority": "high",
                    "action": "Add memory monitoring",
                    "description": "Implement memory usage tracking and limits",
                    "estimated_time": "4-6 hours",
                    "type": "code_fix"
                },
                {
                    "priority": "high",
                    "action": "Optimize image processing",
                    "description": "Implement image compression and size limits",
                    "estimated_time": "6-8 hours",
                    "type": "optimization"
                },
                {
                    "priority": "medium",
                    "action": "Review resource disposal",
                    "description": "Audit and fix memory leaks in resource disposal",
                    "estimated_time": "4-6 hours",
                    "type": "maintenance"
                }
            ])
        
        # General recommendations
        recommendations.extend([
            {
                "priority": "medium",
                "action": "Add comprehensive logging",
                "description": "Implement detailed crash logging for better debugging",
                "estimated_time": "2-3 hours",
                "type": "monitoring"
            },
            {
                "priority": "low",
                "action": "Update dependencies",
                "description": "Update relevant packages to latest stable versions",
                "estimated_time": "1-2 hours",
                "type": "maintenance"
            }
        ])
        
        # Sort by priority
        priority_order = {"immediate": 0, "high": 1, "medium": 2, "low": 3}
        recommendations.sort(key=lambda x: priority_order.get(x["priority"], 4))
        
        return recommendations
    
    def _extract_context(self, text: str, keyword: str, context_size: int = 50) -> str:
        """Extract context around a keyword in text"""
        index = text.lower().find(keyword.lower())
        if index == -1:
            return ""
        
        start = max(0, index - context_size)
        end = min(len(text), index + len(keyword) + context_size)
        return text[start:end].strip()
    
    def _extract_top_functions(self, stack_trace: List[str], limit: int = 5) -> List[str]:
        """Extract top functions from stack trace"""
        functions = []
        for line in stack_trace:
            # Look for function patterns
            match = re.search(r'(\w+\.\w+|\w+)\s*\(', line)
            if match:
                functions.append(match.group(1))
        
        return functions[:limit]
    
    def _find_error_location(self, stack_trace: List[str]) -> Dict[str, Any]:
        """Find the error location in stack trace"""
        for i, line in enumerate(stack_trace):
            if any(keyword in line.lower() for keyword in ['error', 'exception', 'crash', 'failed']):
                return {
                    "line_number": i + 1,
                    "content": line,
                    "file": self._extract_file_from_line(line),
                    "function": self._extract_function_from_line(line)
                }
        
        return {"line_number": 0, "content": "", "file": "", "function": ""}
    
    def _extract_file_from_line(self, line: str) -> str:
        """Extract file name from stack trace line"""
        match = re.search(r'([^/\\]+\.(?:dart|java|swift|kt))', line)
        return match.group(1) if match else ""
    
    def _extract_function_from_line(self, line: str) -> str:
        """Extract function name from stack trace line"""
        match = re.search(r'(\w+)\s*\(', line)
        return match.group(1) if match else ""
    
    def _extract_version_number(self, version_string: str) -> float:
        """Extract numeric version from version string"""
        match = re.search(r'(\d+(?:\.\d+)?)', version_string)
        return float(match.group(1)) if match else 0.0
    
    def _get_investigation_steps(self, category: str) -> List[str]:
        """Get recommended investigation steps for category"""
        investigation_steps = {
            "image_loading": [
                "Reproduce crash with specific image URLs",
                "Test image loading in different network conditions",
                "Verify image format and server response headers",
                "Check for cached image corruption",
                "Test with different image sizes and formats"
            ],
            "network": [
                "Test with poor network connectivity",
                "Verify server availability and response times",
                "Check DNS resolution and routing",
                "Test with different network configurations",
                "Monitor network request/response logs"
            ],
            "memory": [
                "Profile memory usage during crash reproduction",
                "Test with memory-constrained devices",
                "Check for memory leaks in long-running sessions",
                "Monitor garbage collection patterns",
                "Test with different image sizes and quantities"
            ]
        }
        
        return investigation_steps.get(category, [
            "Review crash logs for specific conditions",
            "Test on affected device types and OS versions",
            "Reproduce with minimal test case",
            "Check for specific user actions that trigger crash"
        ])
    
    def _calculate_priority_score(self, affected_users: int, severity: str, business_impact: str) -> int:
        """Calculate priority score for crash"""
        score = 0
        
        # User impact scoring
        if affected_users >= 1000:
            score += 40
        elif affected_users >= 100:
            score += 30
        elif affected_users >= 10:
            score += 20
        else:
            score += 10
        
        # Severity scoring
        severity_scores = {"critical": 30, "high": 20, "medium": 10, "low": 5}
        score += severity_scores.get(severity, 0)
        
        # Business impact scoring
        impact_scores = {"critical": 30, "high": 20, "medium": 10, "low": 5}
        score += impact_scores.get(business_impact, 0)
        
        return min(100, score)


def main():
    """Test the crash analyzer"""
    analyzer = CrashAnalyzer()
    
    # Test with sample crash data
    sample_crash = {
        "id": "crash_001",
        "title": "Invalid image data. Error thrown.",
        "subtitle": "cached_network_image/src/image_provider/",
        "affected_users": 43,
        "affected_sessions": 598,
        "stack_trace": [
            "Exception: Invalid image data. Error thrown.",
            "ImageLoader.loadImageAsync.<fn>",
            "io.flutter.plugins.firebase.crashlytics.FlutterError",
            "package:cached_network_image/src/image_provider/",
            "com.aichatsy.app"
        ],
        "device_info": {
            "platform": "android",
            "model": "samsung galaxy s21",
            "os_version": "Android 12",
            "memory": "8GB"
        },
        "app_info": {
            "version": "1.3.5",
            "build_number": "106",
            "package_name": "com.aichatsy.app"
        }
    }
    
    # Analyze the crash
    analysis = analyzer.analyze_crash_log(sample_crash)
    
    # Print results
    print("🔍 Crash Analysis Results:")
    print(f"Category: {analysis['analysis_results']['category']}")
    print(f"Severity: {analysis['analysis_results']['severity']}")
    print(f"Root Cause: {analysis['analysis_results']['root_cause']['primary_causes'][0]}")
    print(f"User Impact: {analysis['analysis_results']['impact']['user_impact']}")
    print(f"Priority Score: {analysis['analysis_results']['impact']['priority_score']}")
    print(f"Recommendations: {len(analysis['analysis_results']['recommendations'])}")


if __name__ == "__main__":
    main()
