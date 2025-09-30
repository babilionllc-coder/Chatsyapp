#!/usr/bin/env python3
"""
Performance Analyzer Module
Advanced performance analysis tools for Flutter apps
"""

import re
import json
import os
from typing import Dict, List, Any, Optional, Tuple
from datetime import datetime, timedelta
from pathlib import Path
import subprocess

class PerformanceAnalyzer:
    """Advanced performance analysis system for Flutter apps"""
    
    def __init__(self, project_path: str = "/Users/alexjego/Desktop/CHATSY"):
        self.project_path = Path(project_path)
        self.lib_path = self.project_path / "lib"
        self.analysis_patterns = self._load_performance_patterns()
        self.performance_database = {}
    
    def _load_performance_patterns(self) -> Dict[str, Any]:
        """Load performance analysis patterns and rules"""
        return {
            "startup_patterns": {
                "heavy_initialization": [
                    r"await.*\.init\(\)",
                    r"Firebase\.initializeApp\(\)",
                    r"GetStorage\.init\(\)",
                    r"SharedPreferences\.getInstance\(\)",
                    r"sqflite\.openDatabase\(\)"
                ],
                "synchronous_operations": [
                    r"File\(.*\)\.readAsStringSync\(\)",
                    r"Directory\(.*\)\.listSync\(\)",
                    r"Platform\.isAndroid",
                    r"Platform\.isIOS"
                ],
                "large_asset_loading": [
                    r"AssetImage\(.*\)",
                    r"Image\.asset\(.*\)",
                    r"FontLoader\(.*\)",
                    r"precacheImage\(.*\)"
                ]
            },
            "memory_patterns": {
                "memory_leaks": [
                    r"Timer\(.*\)",
                    r"StreamController\(.*\)",
                    r"AnimationController\(.*\)",
                    r"TextEditingController\(.*\)"
                ],
                "large_objects": [
                    r"List\.filled\(.*\)",
                    r"Map\.from\(.*\)",
                    r"Set\.from\(.*\)",
                    r"ByteData\(.*\)"
                ],
                "image_processing": [
                    r"Image\.decode\(.*\)",
                    r"ui\.Image\.fromByteData\(.*\)",
                    r"ImageProcessor\(.*\)",
                    r"ImageFilter\(.*\)"
                ]
            },
            "ui_patterns": {
                "inefficient_widgets": [
                    r"Container\(.*child:.*Container\(.*\)",
                    r"Column\(.*children:.*Column\(.*\)",
                    r"Row\(.*children:.*Row\(.*\)",
                    r"Stack\(.*children:.*Stack\(.*\)"
                ],
                "heavy_animations": [
                    r"AnimationController\(.*duration:.*Duration\(seconds:.*\)",
                    r"TweenAnimationBuilder\(.*\)",
                    r"AnimatedBuilder\(.*\)",
                    r"Hero\(.*\)"
                ],
                "complex_layouts": [
                    r"CustomScrollView\(.*\)",
                    r"SliverAppBar\(.*\)",
                    r"SliverList\(.*\)",
                    r"SliverGrid\(.*\)"
                ]
            },
            "network_patterns": {
                "inefficient_requests": [
                    r"http\.get\(.*\)",
                    r"http\.post\(.*\)",
                    r"Dio\(\)\.get\(.*\)",
                    r"Dio\(\)\.post\(.*\)"
                ],
                "missing_caching": [
                    r"CacheManager\(.*\)",
                    r"SharedPreferences\(.*\)",
                    r"Hive\(.*\)",
                    r"sqflite\(.*\)"
                ],
                "synchronous_network": [
                    r"await.*\.get\(.*\)",
                    r"await.*\.post\(.*\)",
                    r"await.*\.put\(.*\)",
                    r"await.*\.delete\(.*\)"
                ]
            },
            "battery_patterns": {
                "cpu_intensive": [
                    r"compute\(.*\)",
                    r"Isolate\.spawn\(.*\)",
                    r"Timer\.periodic\(.*\)",
                    r"Stream\.periodic\(.*\)"
                ],
                "background_processing": [
                    r"WorkManager\(.*\)",
                    r"BackgroundTask\(.*\)",
                    r"Service\(.*\)",
                    r"Notification\(.*\)"
                ],
                "sensor_usage": [
                    r"Accelerometer\(.*\)",
                    r"Gyroscope\(.*\)",
                    r"GPS\(.*\)",
                    r"Location\(.*\)"
                ]
            }
        }
    
    def analyze_startup_performance(self) -> Dict[str, Any]:
        """Analyze app startup performance"""
        print("🔍 Analyzing startup performance...")
        
        analysis = {
            "startup_time_estimate": 0.0,
            "initialization_issues": [],
            "optimization_opportunities": [],
            "severity": "unknown"
        }
        
        # Analyze main.dart
        main_dart_path = self.lib_path / "main.dart"
        if main_dart_path.exists():
            main_analysis = self._analyze_main_dart(main_dart_path)
            analysis.update(main_analysis)
        
        # Analyze initialization files
        init_files = list(self.lib_path.rglob("*init*.dart"))
        for init_file in init_files:
            init_analysis = self._analyze_initialization_file(init_file)
            analysis["initialization_issues"].extend(init_analysis.get("issues", []))
        
        # Calculate startup time estimate
        analysis["startup_time_estimate"] = self._calculate_startup_time_estimate(analysis)
        
        # Determine severity
        analysis["severity"] = self._determine_startup_severity(analysis["startup_time_estimate"])
        
        return analysis
    
    def _analyze_main_dart(self, main_dart_path: Path) -> Dict[str, Any]:
        """Analyze main.dart for startup performance issues"""
        with open(main_dart_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        issues = []
        optimization_opportunities = []
        
        # Check for heavy initialization
        heavy_init_patterns = self.analysis_patterns["startup_patterns"]["heavy_initialization"]
        for pattern in heavy_init_patterns:
            matches = re.findall(pattern, content)
            if matches:
                issues.append({
                    "type": "heavy_initialization",
                    "pattern": pattern,
                    "matches": matches,
                    "impact": "high"
                })
        
        # Check for synchronous operations
        sync_patterns = self.analysis_patterns["startup_patterns"]["synchronous_operations"]
        for pattern in sync_patterns:
            matches = re.findall(pattern, content)
            if matches:
                issues.append({
                    "type": "synchronous_operations",
                    "pattern": pattern,
                    "matches": matches,
                    "impact": "medium"
                })
        
        # Check for large asset loading
        asset_patterns = self.analysis_patterns["startup_patterns"]["large_asset_loading"]
        for pattern in asset_patterns:
            matches = re.findall(pattern, content)
            if matches:
                issues.append({
                    "type": "large_asset_loading",
                    "pattern": pattern,
                    "matches": matches,
                    "impact": "medium"
                })
        
        # Generate optimization opportunities
        if any(issue["type"] == "heavy_initialization" for issue in issues):
            optimization_opportunities.append("Implement lazy loading for non-critical services")
        
        if any(issue["type"] == "synchronous_operations" for issue in issues):
            optimization_opportunities.append("Move synchronous operations to background threads")
        
        if any(issue["type"] == "large_asset_loading" for issue in issues):
            optimization_opportunities.append("Implement progressive asset loading")
        
        return {
            "issues": issues,
            "optimization_opportunities": optimization_opportunities,
            "total_issues": len(issues)
        }
    
    def _analyze_initialization_file(self, init_file: Path) -> Dict[str, Any]:
        """Analyze initialization files for performance issues"""
        try:
            with open(init_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            issues = []
            
            # Check for heavy initialization patterns
            heavy_patterns = self.analysis_patterns["startup_patterns"]["heavy_initialization"]
            for pattern in heavy_patterns:
                matches = re.findall(pattern, content)
                if matches:
                    issues.append({
                        "file": init_file.name,
                        "type": "heavy_initialization",
                        "pattern": pattern,
                        "matches": matches,
                        "impact": "high"
                    })
            
            return {"issues": issues}
        except Exception as e:
            return {"issues": [], "error": str(e)}
    
    def _calculate_startup_time_estimate(self, analysis: Dict[str, Any]) -> float:
        """Calculate estimated startup time based on analysis"""
        base_time = 1.0  # Base startup time
        
        # Add time for each issue type
        for issue in analysis.get("initialization_issues", []):
            if issue["type"] == "heavy_initialization":
                base_time += 0.5 * len(issue["matches"])
            elif issue["type"] == "synchronous_operations":
                base_time += 0.2 * len(issue["matches"])
            elif issue["type"] == "large_asset_loading":
                base_time += 0.3 * len(issue["matches"])
        
        return base_time
    
    def _determine_startup_severity(self, startup_time: float) -> str:
        """Determine startup performance severity"""
        if startup_time > 5.0:
            return "critical"
        elif startup_time > 3.0:
            return "high"
        elif startup_time > 2.0:
            return "medium"
        else:
            return "low"
    
    def analyze_memory_performance(self) -> Dict[str, Any]:
        """Analyze memory usage performance"""
        print("🔍 Analyzing memory performance...")
        
        analysis = {
            "memory_leaks": [],
            "large_objects": [],
            "optimization_opportunities": [],
            "severity": "unknown"
        }
        
        # Analyze all Dart files for memory issues
        dart_files = list(self.lib_path.rglob("*.dart"))
        
        for dart_file in dart_files:
            try:
                with open(dart_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Check for memory leak patterns
                leak_patterns = self.analysis_patterns["memory_patterns"]["memory_leaks"]
                for pattern in leak_patterns:
                    matches = re.findall(pattern, content)
                    if matches:
                        analysis["memory_leaks"].append({
                            "file": dart_file.name,
                            "pattern": pattern,
                            "matches": matches,
                            "impact": "high"
                        })
                
                # Check for large object patterns
                large_object_patterns = self.analysis_patterns["memory_patterns"]["large_objects"]
                for pattern in large_object_patterns:
                    matches = re.findall(pattern, content)
                    if matches:
                        analysis["large_objects"].append({
                            "file": dart_file.name,
                            "pattern": pattern,
                            "matches": matches,
                            "impact": "medium"
                        })
                
                # Check for image processing patterns
                image_patterns = self.analysis_patterns["memory_patterns"]["image_processing"]
                for pattern in image_patterns:
                    matches = re.findall(pattern, content)
                    if matches:
                        analysis["memory_leaks"].append({
                            "file": dart_file.name,
                            "type": "image_processing",
                            "pattern": pattern,
                            "matches": matches,
                            "impact": "high"
                        })
                
            except Exception as e:
                print(f"Error analyzing {dart_file}: {e}")
        
        # Generate optimization opportunities
        if analysis["memory_leaks"]:
            analysis["optimization_opportunities"].append("Implement proper resource disposal")
        
        if analysis["large_objects"]:
            analysis["optimization_opportunities"].append("Optimize data structure usage")
        
        # Determine severity
        total_issues = len(analysis["memory_leaks"]) + len(analysis["large_objects"])
        if total_issues > 10:
            analysis["severity"] = "critical"
        elif total_issues > 5:
            analysis["severity"] = "high"
        elif total_issues > 2:
            analysis["severity"] = "medium"
        else:
            analysis["severity"] = "low"
        
        return analysis
    
    def analyze_ui_performance(self) -> Dict[str, Any]:
        """Analyze UI rendering performance"""
        print("🔍 Analyzing UI performance...")
        
        analysis = {
            "inefficient_widgets": [],
            "heavy_animations": [],
            "complex_layouts": [],
            "optimization_opportunities": [],
            "severity": "unknown"
        }
        
        # Analyze widget files
        widget_files = list(self.lib_path.rglob("*widget*.dart")) + list(self.lib_path.rglob("*view*.dart"))
        
        for widget_file in widget_files:
            try:
                with open(widget_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Check for inefficient widget patterns
                inefficient_patterns = self.analysis_patterns["ui_patterns"]["inefficient_widgets"]
                for pattern in inefficient_patterns:
                    matches = re.findall(pattern, content)
                    if matches:
                        analysis["inefficient_widgets"].append({
                            "file": widget_file.name,
                            "pattern": pattern,
                            "matches": matches,
                            "impact": "medium"
                        })
                
                # Check for heavy animation patterns
                animation_patterns = self.analysis_patterns["ui_patterns"]["heavy_animations"]
                for pattern in animation_patterns:
                    matches = re.findall(pattern, content)
                    if matches:
                        analysis["heavy_animations"].append({
                            "file": widget_file.name,
                            "pattern": pattern,
                            "matches": matches,
                            "impact": "high"
                        })
                
                # Check for complex layout patterns
                layout_patterns = self.analysis_patterns["ui_patterns"]["complex_layouts"]
                for pattern in layout_patterns:
                    matches = re.findall(pattern, content)
                    if matches:
                        analysis["complex_layouts"].append({
                            "file": widget_file.name,
                            "pattern": pattern,
                            "matches": matches,
                            "impact": "medium"
                        })
                
            except Exception as e:
                print(f"Error analyzing {widget_file}: {e}")
        
        # Generate optimization opportunities
        if analysis["inefficient_widgets"]:
            analysis["optimization_opportunities"].append("Optimize widget tree structure")
        
        if analysis["heavy_animations"]:
            analysis["optimization_opportunities"].append("Implement efficient animations")
        
        if analysis["complex_layouts"]:
            analysis["optimization_opportunities"].append("Simplify complex layouts")
        
        # Determine severity
        total_issues = len(analysis["inefficient_widgets"]) + len(analysis["heavy_animations"]) + len(analysis["complex_layouts"])
        if total_issues > 15:
            analysis["severity"] = "critical"
        elif total_issues > 8:
            analysis["severity"] = "high"
        elif total_issues > 3:
            analysis["severity"] = "medium"
        else:
            analysis["severity"] = "low"
        
        return analysis
    
    def analyze_network_performance(self) -> Dict[str, Any]:
        """Analyze network performance"""
        print("🔍 Analyzing network performance...")
        
        analysis = {
            "inefficient_requests": [],
            "missing_caching": [],
            "synchronous_network": [],
            "optimization_opportunities": [],
            "severity": "unknown"
        }
        
        # Analyze API and network files
        network_files = list(self.lib_path.rglob("*api*.dart")) + list(self.lib_path.rglob("*network*.dart"))
        
        for network_file in network_files:
            try:
                with open(network_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Check for inefficient request patterns
                request_patterns = self.analysis_patterns["network_patterns"]["inefficient_requests"]
                for pattern in request_patterns:
                    matches = re.findall(pattern, content)
                    if matches:
                        analysis["inefficient_requests"].append({
                            "file": network_file.name,
                            "pattern": pattern,
                            "matches": matches,
                            "impact": "high"
                        })
                
                # Check for missing caching patterns
                cache_patterns = self.analysis_patterns["network_patterns"]["missing_caching"]
                for pattern in cache_patterns:
                    matches = re.findall(pattern, content)
                    if matches:
                        analysis["missing_caching"].append({
                            "file": network_file.name,
                            "pattern": pattern,
                            "matches": matches,
                            "impact": "medium"
                        })
                
                # Check for synchronous network patterns
                sync_patterns = self.analysis_patterns["network_patterns"]["synchronous_network"]
                for pattern in sync_patterns:
                    matches = re.findall(pattern, content)
                    if matches:
                        analysis["synchronous_network"].append({
                            "file": network_file.name,
                            "pattern": pattern,
                            "matches": matches,
                            "impact": "high"
                        })
                
            except Exception as e:
                print(f"Error analyzing {network_file}: {e}")
        
        # Generate optimization opportunities
        if analysis["inefficient_requests"]:
            analysis["optimization_opportunities"].append("Implement request batching and optimization")
        
        if analysis["missing_caching"]:
            analysis["optimization_opportunities"].append("Add intelligent caching strategies")
        
        if analysis["synchronous_network"]:
            analysis["optimization_opportunities"].append("Implement asynchronous network operations")
        
        # Determine severity
        total_issues = len(analysis["inefficient_requests"]) + len(analysis["missing_caching"]) + len(analysis["synchronous_network"])
        if total_issues > 8:
            analysis["severity"] = "critical"
        elif total_issues > 4:
            analysis["severity"] = "high"
        elif total_issues > 2:
            analysis["severity"] = "medium"
        else:
            analysis["severity"] = "low"
        
        return analysis
    
    def analyze_battery_performance(self) -> Dict[str, Any]:
        """Analyze battery consumption performance"""
        print("🔍 Analyzing battery performance...")
        
        analysis = {
            "cpu_intensive": [],
            "background_processing": [],
            "sensor_usage": [],
            "optimization_opportunities": [],
            "severity": "unknown"
        }
        
        # Analyze all Dart files for battery issues
        dart_files = list(self.lib_path.rglob("*.dart"))
        
        for dart_file in dart_files:
            try:
                with open(dart_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Check for CPU-intensive patterns
                cpu_patterns = self.analysis_patterns["battery_patterns"]["cpu_intensive"]
                for pattern in cpu_patterns:
                    matches = re.findall(pattern, content)
                    if matches:
                        analysis["cpu_intensive"].append({
                            "file": dart_file.name,
                            "pattern": pattern,
                            "matches": matches,
                            "impact": "high"
                        })
                
                # Check for background processing patterns
                bg_patterns = self.analysis_patterns["battery_patterns"]["background_processing"]
                for pattern in bg_patterns:
                    matches = re.findall(pattern, content)
                    if matches:
                        analysis["background_processing"].append({
                            "file": dart_file.name,
                            "pattern": pattern,
                            "matches": matches,
                            "impact": "medium"
                        })
                
                # Check for sensor usage patterns
                sensor_patterns = self.analysis_patterns["battery_patterns"]["sensor_usage"]
                for pattern in sensor_patterns:
                    matches = re.findall(pattern, content)
                    if matches:
                        analysis["sensor_usage"].append({
                            "file": dart_file.name,
                            "pattern": pattern,
                            "matches": matches,
                            "impact": "high"
                        })
                
            except Exception as e:
                print(f"Error analyzing {dart_file}: {e}")
        
        # Generate optimization opportunities
        if analysis["cpu_intensive"]:
            analysis["optimization_opportunities"].append("Optimize CPU-intensive operations")
        
        if analysis["background_processing"]:
            analysis["optimization_opportunities"].append("Implement efficient background processing")
        
        if analysis["sensor_usage"]:
            analysis["optimization_opportunities"].append("Optimize sensor usage and battery consumption")
        
        # Determine severity
        total_issues = len(analysis["cpu_intensive"]) + len(analysis["background_processing"]) + len(analysis["sensor_usage"])
        if total_issues > 6:
            analysis["severity"] = "critical"
        elif total_issues > 3:
            analysis["severity"] = "high"
        elif total_issues > 1:
            analysis["severity"] = "medium"
        else:
            analysis["severity"] = "low"
        
        return analysis
    
    def generate_performance_analysis_report(self) -> str:
        """Generate comprehensive performance analysis report"""
        print("📊 Generating performance analysis report...")
        
        # Run all analyses
        startup_analysis = self.analyze_startup_performance()
        memory_analysis = self.analyze_memory_performance()
        ui_analysis = self.analyze_ui_performance()
        network_analysis = self.analyze_network_performance()
        battery_analysis = self.analyze_battery_performance()
        
        report = f"""
# 🔍 Performance Analysis Report
Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
Project: {self.project_path}

## 📊 Analysis Summary
- **Startup Performance**: {startup_analysis['severity'].upper()}
- **Memory Performance**: {memory_analysis['severity'].upper()}
- **UI Performance**: {ui_analysis['severity'].upper()}
- **Network Performance**: {network_analysis['severity'].upper()}
- **Battery Performance**: {battery_analysis['severity'].upper()}

## 🚀 Startup Performance Analysis
- **Estimated Startup Time**: {startup_analysis['startup_time_estimate']:.1f} seconds
- **Initialization Issues**: {len(startup_analysis['initialization_issues'])}
- **Optimization Opportunities**: {len(startup_analysis['optimization_opportunities'])}

### Issues Found:
"""
        
        for issue in startup_analysis['initialization_issues'][:5]:  # Show top 5
            report += f"- **{issue['type']}**: {len(issue.get('matches', []))} occurrences\n"
        
        report += f"""
### Optimization Opportunities:
"""
        for opportunity in startup_analysis['optimization_opportunities']:
            report += f"- {opportunity}\n"
        
        report += f"""
## 💾 Memory Performance Analysis
- **Memory Leaks**: {len(memory_analysis['memory_leaks'])}
- **Large Objects**: {len(memory_analysis['large_objects'])}
- **Severity**: {memory_analysis['severity'].upper()}

### Issues Found:
"""
        
        for issue in memory_analysis['memory_leaks'][:5]:  # Show top 5
            report += f"- **{issue.get('type', 'memory_leak')}** in {issue['file']}: {len(issue.get('matches', []))} occurrences\n"
        
        report += f"""
## 🎨 UI Performance Analysis
- **Inefficient Widgets**: {len(ui_analysis['inefficient_widgets'])}
- **Heavy Animations**: {len(ui_analysis['heavy_animations'])}
- **Complex Layouts**: {len(ui_analysis['complex_layouts'])}
- **Severity**: {ui_analysis['severity'].upper()}

### Issues Found:
"""
        
        for issue in ui_analysis['inefficient_widgets'][:3]:  # Show top 3
            report += f"- **Inefficient Widget** in {issue['file']}: {len(issue.get('matches', []))} occurrences\n"
        
        report += f"""
## 🌐 Network Performance Analysis
- **Inefficient Requests**: {len(network_analysis['inefficient_requests'])}
- **Missing Caching**: {len(network_analysis['missing_caching'])}
- **Synchronous Network**: {len(network_analysis['synchronous_network'])}
- **Severity**: {network_analysis['severity'].upper()}

### Issues Found:
"""
        
        for issue in network_analysis['inefficient_requests'][:3]:  # Show top 3
            report += f"- **Inefficient Request** in {issue['file']}: {len(issue.get('matches', []))} occurrences\n"
        
        report += f"""
## 🔋 Battery Performance Analysis
- **CPU Intensive**: {len(battery_analysis['cpu_intensive'])}
- **Background Processing**: {len(battery_analysis['background_processing'])}
- **Sensor Usage**: {len(battery_analysis['sensor_usage'])}
- **Severity**: {battery_analysis['severity'].upper()}

### Issues Found:
"""
        
        for issue in battery_analysis['cpu_intensive'][:3]:  # Show top 3
            report += f"- **CPU Intensive** in {issue['file']}: {len(issue.get('matches', []))} occurrences\n"
        
        report += """
## 🎯 Overall Recommendations

### High Priority:
1. **Startup Optimization**: Implement lazy loading and async initialization
2. **Memory Management**: Fix memory leaks and optimize resource usage
3. **Network Optimization**: Add caching and optimize API calls

### Medium Priority:
1. **UI Optimization**: Simplify widget trees and optimize animations
2. **Battery Optimization**: Reduce CPU usage and optimize background processing

### Low Priority:
1. **Code Optimization**: Add const constructors and optimize loops
2. **Asset Optimization**: Compress images and optimize asset loading

---
*Report generated by PerformanceAnalyzer*
"""
        
        return report


def main():
    """Test the performance analyzer"""
    analyzer = PerformanceAnalyzer("/Users/alexjego/Desktop/CHATSY")
    
    # Generate performance analysis report
    report = analyzer.generate_performance_analysis_report()
    print(report)


if __name__ == "__main__":
    main()
