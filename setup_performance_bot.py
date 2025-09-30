#!/usr/bin/env python3
"""
ChatSY Performance Bot Setup Script
Setup and installation script for the AppPerformanceBot system
"""

import os
import sys
import subprocess
import json
from pathlib import Path

def check_python_version():
    """Check if Python version is compatible"""
    if sys.version_info < (3, 8):
        print("❌ Python 3.8 or higher is required")
        print(f"Current version: {sys.version}")
        return False
    
    print(f"✅ Python version: {sys.version}")
    return True

def install_requirements():
    """Install required packages"""
    print("📦 Installing required packages...")
    
    requirements = [
        "matplotlib>=3.5.0",
        "pandas>=1.5.0",
        "numpy>=1.21.0",
        "requests>=2.28.0",
        "pyyaml>=6.0"
    ]
    
    for requirement in requirements:
        try:
            print(f"   Installing {requirement}...")
            subprocess.check_call([sys.executable, "-m", "pip", "install", requirement])
            print(f"   ✅ {requirement} installed successfully")
        except subprocess.CalledProcessError as e:
            print(f"   ❌ Failed to install {requirement}: {e}")
            return False
    
    return True

def create_performance_directories(project_path: str):
    """Create necessary directories for performance optimization"""
    print("📁 Creating performance optimization directories...")
    
    project_path = Path(project_path)
    
    # Create helper directory
    helper_dir = project_path / "lib" / "app" / "helper"
    helper_dir.mkdir(parents=True, exist_ok=True)
    print(f"   ✅ Created: {helper_dir}")
    
    # Create common_widget directory
    widget_dir = project_path / "lib" / "app" / "common_widget"
    widget_dir.mkdir(parents=True, exist_ok=True)
    print(f"   ✅ Created: {widget_dir}")
    
    # Create performance_data directory
    data_dir = project_path / "performance_data"
    data_dir.mkdir(parents=True, exist_ok=True)
    print(f"   ✅ Created: {data_dir}")
    
    return True

def create_performance_config(project_path: str):
    """Create performance configuration file"""
    print("⚙️  Creating performance configuration...")
    
    config = {
        "project_name": "ChatSY",
        "project_path": project_path,
        "performance_monitoring": {
            "enabled": True,
            "interval_seconds": 30,
            "alert_thresholds": {
                "startup_time": {"warning": 3.0, "critical": 5.0},
                "memory_usage": {"warning": 150.0, "critical": 200.0},
                "battery_drain": {"warning": 5.0, "critical": 8.0},
                "ui_fps": {"warning": 45.0, "critical": 30.0},
                "network_latency": {"warning": 500.0, "critical": 1000.0},
                "crash_rate": {"warning": 2.0, "critical": 5.0}
            }
        },
        "optimization_settings": {
            "startup_optimization": True,
            "memory_optimization": True,
            "ui_optimization": True,
            "network_optimization": True,
            "battery_optimization": True
        },
        "monitoring_settings": {
            "generate_charts": True,
            "save_reports": True,
            "alert_notifications": True
        }
    }
    
    config_file = Path(project_path) / "performance_config.json"
    with open(config_file, 'w', encoding='utf-8') as f:
        json.dump(config, f, indent=2)
    
    print(f"   ✅ Created: {config_file}")
    return True

def create_performance_scripts(project_path: str):
    """Create performance monitoring scripts"""
    print("📜 Creating performance monitoring scripts...")
    
    project_path = Path(project_path)
    
    # Create performance monitoring script
    monitor_script = project_path / "monitor_performance.py"
    monitor_script_content = '''#!/usr/bin/env python3
"""
Performance Monitoring Script
Run this script to continuously monitor ChatSY performance
"""

import time
import json
from pathlib import Path
from performance_dashboard import PerformanceDashboard

def main():
    """Main monitoring function"""
    print("📊 Starting ChatSY Performance Monitoring...")
    
    # Load configuration
    config_file = Path("performance_config.json")
    if config_file.exists():
        with open(config_file, 'r') as f:
            config = json.load(f)
    else:
        print("❌ Configuration file not found. Please run setup first.")
        return
    
    # Initialize dashboard
    dashboard = PerformanceDashboard()
    
    print("🔄 Performance monitoring started. Press Ctrl+C to stop.")
    
    try:
        while True:
            # Simulate performance metrics (in real implementation, these would come from actual app metrics)
            test_metrics = {
                'startup_time': 3.2,
                'memory_usage': 145.0,
                'battery_drain': 4.5,
                'ui_fps': 55.0,
                'network_latency': 350.0,
                'image_load_time': 1.8,
                'database_query_time': 25.0,
                'crash_rate': 1.2,
                'user_satisfaction': 0.85
            }
            
            # Record metrics
            dashboard.record_performance_metric(test_metrics)
            
            # Get summary
            summary = dashboard.get_performance_summary()
            print(f"📊 Performance Health: {summary['overall_health'].upper()} | Active Alerts: {summary['active_alerts']}")
            
            # Wait for next monitoring cycle
            time.sleep(config['performance_monitoring']['interval_seconds'])
            
    except KeyboardInterrupt:
        print("\\n🛑 Performance monitoring stopped.")
        
        # Generate final report
        report = dashboard.generate_performance_report()
        print("\\n📋 Final Performance Report:")
        print(report)

if __name__ == "__main__":
    main()
'''
    
    with open(monitor_script, 'w', encoding='utf-8') as f:
        f.write(monitor_script_content)
    
    print(f"   ✅ Created: {monitor_script}")
    
    # Create performance test script
    test_script = project_path / "test_performance.py"
    test_script_content = '''#!/usr/bin/env python3
"""
Performance Testing Script
Run this script to test ChatSY performance optimizations
"""

import time
from optimize_chatsy_performance import ChatSYPerformanceManager

def main():
    """Main testing function"""
    print("🧪 Starting ChatSY Performance Testing...")
    
    # Initialize performance manager
    manager = ChatSYPerformanceManager()
    
    # Run AI performance analysis
    print("🤖 Running AI performance analysis...")
    ai_results = manager.run_ai_performance_analysis()
    
    print(f"📊 Performance Score: {ai_results.get('performance_score', 0):.1%}")
    print(f"🔍 Issues Found: {len(ai_results.get('issues', []))}")
    
    # Show critical issues
    critical_issues = [i for i in ai_results.get('issues', []) if i.get('severity') == 'critical']
    if critical_issues:
        print("\\n🚨 Critical Issues:")
        for issue in critical_issues:
            print(f"   - {issue['title']}: {issue['description']}")
    
    print("\\n✅ Performance testing completed!")

if __name__ == "__main__":
    main()
'''
    
    with open(test_script, 'w', encoding='utf-8') as f:
        f.write(test_script_content)
    
    print(f"   ✅ Created: {test_script}")
    
    return True

def create_performance_guide(project_path: str):
    """Create performance optimization guide"""
    print("📚 Creating performance optimization guide...")
    
    guide_content = '''# 🚀 ChatSY Performance Optimization Guide

## Overview
This guide provides comprehensive instructions for optimizing ChatSY app performance using the AppPerformanceBot system.

## Quick Start

### 1. Run Full Optimization
```bash
python3 optimize_chatsy_performance.py --mode full
```

### 2. Run Analysis Only
```bash
python3 optimize_chatsy_performance.py --mode analysis
```

### 3. Run Optimization Only
```bash
python3 optimize_chatsy_performance.py --mode optimization
```

### 4. Setup Monitoring
```bash
python3 optimize_chatsy_performance.py --mode monitoring
```

### 5. Run AI Analysis
```bash
python3 optimize_chatsy_performance.py --mode ai
```

## Performance Monitoring

### Start Continuous Monitoring
```bash
python3 monitor_performance.py
```

### Run Performance Tests
```bash
python3 test_performance.py
```

## Generated Files

### Performance Utilities
- `lib/app/helper/startup_optimizer.dart` - Startup optimization utilities
- `lib/app/helper/performance_monitor.dart` - Performance monitoring
- `lib/app/helper/memory_manager.dart` - Memory management
- `lib/app/helper/memory_monitor.dart` - Memory monitoring
- `lib/app/helper/ui_optimizer.dart` - UI optimization
- `lib/app/helper/animation_optimizer.dart` - Animation optimization

### Widgets
- `lib/app/common_widget/lazy_loading_widget.dart` - Lazy loading widgets
- `lib/app/common_widget/optimized_widgets.dart` - Optimized widgets

### Reports and Charts
- `PERFORMANCE_OPTIMIZATION_REPORT.md` - Comprehensive report
- `startup_time_chart.png` - Startup time chart
- `memory_usage_chart.png` - Memory usage chart
- `ui_fps_chart.png` - UI FPS chart
- `network_latency_chart.png` - Network latency chart
- `performance_dashboard.png` - Performance dashboard

## Performance Categories

### 1. Startup Performance
- **Target**: < 3 seconds cold start
- **Optimizations**: Lazy loading, async initialization, progressive loading
- **Monitoring**: Startup time tracking, initialization monitoring

### 2. Memory Performance
- **Target**: < 150MB peak usage
- **Optimizations**: Resource disposal, memory limits, efficient data structures
- **Monitoring**: Memory usage tracking, leak detection

### 3. UI Performance
- **Target**: 60 FPS, smooth animations
- **Optimizations**: Widget optimization, efficient animations, const constructors
- **Monitoring**: Frame rate tracking, animation performance

### 4. Network Performance
- **Target**: < 500ms API response time
- **Optimizations**: Request batching, caching, compression
- **Monitoring**: Network latency tracking, success rate monitoring

### 5. Battery Performance
- **Target**: < 5% battery drain per hour
- **Optimizations**: CPU optimization, background processing, sensor usage
- **Monitoring**: Battery usage tracking, CPU monitoring

## Best Practices

### 1. Startup Optimization
- Use lazy loading for non-critical features
- Implement async initialization
- Defer heavy operations
- Use splash screens with progress indication

### 2. Memory Management
- Implement proper resource disposal
- Use efficient data structures
- Monitor memory usage
- Implement memory limits

### 3. UI Optimization
- Use const constructors where possible
- Optimize widget trees
- Implement efficient animations
- Use RepaintBoundary for complex widgets

### 4. Network Optimization
- Implement request batching
- Add intelligent caching
- Use compression for large requests
- Implement retry logic

### 5. Battery Optimization
- Optimize CPU-intensive operations
- Implement efficient background processing
- Reduce network request frequency
- Optimize sensor usage

## Troubleshooting

### Common Issues

#### 1. High Startup Time
- Check for heavy initialization in main()
- Implement lazy loading
- Move operations to background threads

#### 2. Memory Leaks
- Check for unclosed streams and controllers
- Implement proper disposal patterns
- Monitor memory usage

#### 3. Low FPS
- Check for heavy widget rebuilds
- Optimize animations
- Use const constructors

#### 4. Slow Network
- Implement caching
- Optimize API calls
- Add retry logic

#### 5. High Battery Drain
- Optimize CPU usage
- Reduce background processing
- Implement battery optimization modes

## Support

For issues or questions:
1. Check the generated performance report
2. Review the performance monitoring dashboard
3. Run performance tests
4. Check the troubleshooting section

## Updates

The AppPerformanceBot system is continuously updated with new optimizations and monitoring capabilities. Check for updates regularly.

---
*ChatSY Performance Optimization Guide - Generated by AppPerformanceBot*
'''
    
    guide_file = Path(project_path) / "PERFORMANCE_OPTIMIZATION_GUIDE.md"
    with open(guide_file, 'w', encoding='utf-8') as f:
        f.write(guide_content)
    
    print(f"   ✅ Created: {guide_file}")
    return True

def main():
    """Main setup function"""
    print("🚀 ChatSY Performance Bot Setup")
    print("=" * 50)
    
    # Get project path
    project_path = input("Enter ChatSY project path (default: /Users/alexjego/Desktop/CHATSY): ").strip()
    if not project_path:
        project_path = "/Users/alexjego/Desktop/CHATSY"
    
    print(f"📁 Project path: {project_path}")
    
    # Check if project path exists
    if not Path(project_path).exists():
        print(f"❌ Project path does not exist: {project_path}")
        return False
    
    # Check Python version
    if not check_python_version():
        return False
    
    # Install requirements
    if not install_requirements():
        return False
    
    # Create directories
    if not create_performance_directories(project_path):
        return False
    
    # Create configuration
    if not create_performance_config(project_path):
        return False
    
    # Create scripts
    if not create_performance_scripts(project_path):
        return False
    
    # Create guide
    if not create_performance_guide(project_path):
        return False
    
    print("\n✅ ChatSY Performance Bot setup completed successfully!")
    print("\n🎯 Next Steps:")
    print("1. Run full optimization: python3 optimize_chatsy_performance.py --mode full")
    print("2. Start monitoring: python3 monitor_performance.py")
    print("3. Read the guide: PERFORMANCE_OPTIMIZATION_GUIDE.md")
    
    return True

if __name__ == "__main__":
    main()
