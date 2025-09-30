#!/usr/bin/env python3
"""
XCodeDeployBot Setup Script
Setup and installation script for the iOS deployment specialist
"""

import os
import sys
import subprocess
import shutil
from pathlib import Path

def setup_xcode_deploy_bot():
    """Setup XCodeDeployBot system"""
    print("🚀 Setting up XCodeDeployBot - iOS Deployment Specialist")
    print("=" * 60)
    
    # Check Python version
    if sys.version_info < (3, 7):
        print("❌ Python 3.7 or higher is required")
        sys.exit(1)
    
    print(f"✅ Python version: {sys.version}")
    
    # Install required packages
    print("\n📦 Installing required packages...")
    try:
        subprocess.run([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"], 
                      check=True)
        print("✅ Required packages installed successfully")
    except subprocess.CalledProcessError as e:
        print(f"❌ Failed to install packages: {e}")
        sys.exit(1)
    
    # Create necessary directories
    print("\n📁 Creating necessary directories...")
    directories = [
        "logs",
        "reports",
        "backups",
        "config"
    ]
    
    for directory in directories:
        Path(directory).mkdir(exist_ok=True)
        print(f"✅ Created directory: {directory}")
    
    # Set up database
    print("\n🗄️ Setting up database...")
    try:
        from deployment_monitor import DeploymentMonitor
        monitor = DeploymentMonitor()
        print("✅ Database initialized successfully")
    except Exception as e:
        print(f"❌ Failed to initialize database: {e}")
        sys.exit(1)
    
    # Create configuration file
    print("\n⚙️ Creating configuration file...")
    config = {
        "project_path": "/Users/alexjego/Desktop/CHATSY",
        "database_path": "deployment_metrics.db",
        "log_level": "INFO",
        "monitoring_enabled": True,
        "auto_fix_enabled": True,
        "report_generation": True
    }
    
    import json
    with open("config/deploy_bot_config.json", "w") as f:
        json.dump(config, f, indent=2)
    
    print("✅ Configuration file created")
    
    # Test the system
    print("\n🧪 Testing XCodeDeployBot system...")
    try:
        from xcode_deploy_bot import XCodeDeployBot
        bot = XCodeDeployBot()
        print("✅ XCodeDeployBot initialized successfully")
        
        # Test diagnostics
        from deployment_diagnostics import DeploymentDiagnostics
        diagnostics = DeploymentDiagnostics("/Users/alexjego/Desktop/CHATSY")
        print("✅ Diagnostics system working")
        
        # Test fixer
        from automated_fixer import AutomatedFixer
        fixer = AutomatedFixer("/Users/alexjego/Desktop/CHATSY")
        print("✅ Automated fixer system working")
        
        # Test monitor
        from deployment_monitor import DeploymentMonitor
        monitor = DeploymentMonitor()
        print("✅ Deployment monitor working")
        
    except Exception as e:
        print(f"❌ System test failed: {e}")
        sys.exit(1)
    
    # Create shortcuts
    print("\n🔗 Creating shortcuts...")
    
    # Create main deployment script
    main_script = """#!/usr/bin/env python3
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent))
from deploy_chatsy import main
main()
"""
    
    with open("deploy_chatsy.py", "w") as f:
        f.write(main_script)
    
    # Make it executable
    os.chmod("deploy_chatsy.py", 0o755)
    print("✅ Main deployment script created")
    
    # Create quick check script
    quick_script = """#!/usr/bin/env python3
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent))
from deploy_chatsy import ChatSYDeploymentManager

if __name__ == "__main__":
    manager = ChatSYDeploymentManager()
    results = manager.run_quick_check()
    print(f"Status: {results['status']}")
    print(f"Issues: {', '.join(results['issues']) if results['issues'] else 'None'}")
"""
    
    with open("quick_check.py", "w") as f:
        f.write(quick_script)
    
    os.chmod("quick_check.py", 0o755)
    print("✅ Quick check script created")
    
    # Create README
    print("\n📚 Creating documentation...")
    readme = """# XCodeDeployBot - iOS Deployment Specialist

## Overview
XCodeDeployBot is an AI-powered system that systematically diagnoses and fixes iOS deployment issues for Flutter projects.

## Features
- 🔍 Comprehensive diagnostic system
- 🔧 Automated fixing capabilities
- 📊 Health monitoring and analytics
- 📈 Trend analysis and reporting
- 🚀 One-click deployment management

## Quick Start

### Run Full Deployment Check
```bash
python deploy_chatsy.py --mode full
```

### Run Quick Check
```bash
python deploy_chatsy.py --mode quick
```

### Run Diagnostics Only
```bash
python deploy_chatsy.py --mode diagnose
```

### Run Fixes Only
```bash
python deploy_chatsy.py --mode fix
```

### Monitor Health
```bash
python deploy_chatsy.py --mode monitor
```

## Configuration
Edit `config/deploy_bot_config.json` to customize settings.

## Support
For issues and questions, check the logs in the `logs/` directory.
"""
    
    with open("README.md", "w") as f:
        f.write(readme)
    
    print("✅ Documentation created")
    
    print("\n🎉 XCodeDeployBot setup completed successfully!")
    print("\n📋 Next Steps:")
    print("1. Run: python deploy_chatsy.py --mode full")
    print("2. Review the generated report")
    print("3. Apply any recommended fixes")
    print("4. Test your deployment")
    
    print("\n🔧 Available Commands:")
    print("- python deploy_chatsy.py --mode full     # Full deployment check")
    print("- python deploy_chatsy.py --mode quick    # Quick status check")
    print("- python deploy_chatsy.py --mode diagnose # Diagnostics only")
    print("- python deploy_chatsy.py --mode fix      # Apply fixes")
    print("- python deploy_chatsy.py --mode monitor  # Health monitoring")


if __name__ == "__main__":
    setup_xcode_deploy_bot()
