#!/usr/bin/env python3
"""
ChatSY Deployment Manager
Main integration script for XCodeDeployBot system
"""

import os
import sys
import argparse
import json
import time
from pathlib import Path
from typing import Dict, List, Any, Optional

# Import our modules
from xcode_deploy_bot import XCodeDeployBot, DeploymentIssue, IssueType, Severity
from deployment_diagnostics import DeploymentDiagnostics
from automated_fixer import AutomatedFixer
from deployment_monitor import DeploymentMonitor, BuildMetrics

class ChatSYDeploymentManager:
    """Main deployment manager for ChatSY project"""
    
    def __init__(self, project_path: str = "/Users/alexjego/Desktop/CHATSY"):
        self.project_path = Path(project_path)
        self.agent = XCodeDeployBot()
        self.diagnostics = DeploymentDiagnostics(str(self.project_path))
        self.fixer = AutomatedFixer(str(self.project_path))
        self.monitor = DeploymentMonitor()
        
        print("🚀 ChatSY Deployment Manager initialized!")
        print(f"📁 Project path: {self.project_path}")
    
    def run_full_deployment_check(self) -> Dict[str, Any]:
        """Run comprehensive deployment check and fix"""
        print("🔍 Running full deployment check for ChatSY...")
        
        results = {
            "timestamp": time.time(),
            "project_path": str(self.project_path),
            "diagnostics": {},
            "fixes": {},
            "health": {},
            "recommendations": []
        }
        
        # Step 1: Run diagnostics
        print("\n📊 Step 1: Running diagnostics...")
        results["diagnostics"] = self._run_diagnostics()
        
        # Step 2: Analyze issues
        print("\n🔍 Step 2: Analyzing issues...")
        issues = self._analyze_issues(results["diagnostics"])
        
        # Step 3: Apply fixes
        print("\n🔧 Step 3: Applying fixes...")
        results["fixes"] = self._apply_fixes(issues)
        
        # Step 4: Generate health report
        print("\n📈 Step 4: Generating health report...")
        results["health"] = self._generate_health_report()
        
        # Step 5: Generate recommendations
        print("\n🎯 Step 5: Generating recommendations...")
        results["recommendations"] = self._generate_recommendations(results)
        
        return results
    
    def _run_diagnostics(self) -> Dict[str, Any]:
        """Run comprehensive diagnostics"""
        diagnostics = {}
        
        # Project structure diagnostics
        diagnostics["project_structure"] = self.diagnostics.diagnose_project_structure()
        
        # Code signing diagnostics
        diagnostics["code_signing"] = self.diagnostics.diagnose_code_signing()
        
        # Generate diagnostic report
        diagnostics["report"] = self.diagnostics.generate_diagnostic_report()
        
        return diagnostics
    
    def _analyze_issues(self, diagnostics: Dict[str, Any]) -> List[DeploymentIssue]:
        """Analyze diagnostics and identify issues"""
        issues = []
        
        # Analyze project structure issues
        project_config = diagnostics["project_structure"]
        
        # Check for problematic dependencies
        flutter_config = project_config.get("flutter_config", {})
        problematic_deps = flutter_config.get("problematic_dependencies", [])
        
        if problematic_deps:
            issue = DeploymentIssue(
                issue_type=IssueType.FLUTTER,
                severity=Severity.HIGH,
                error_message=f"Problematic dependencies found: {', '.join(problematic_deps)}",
                error_code="problematic_dependencies",
                suggested_fixes=[
                    "Remove video player dependencies",
                    "Update pubspec.yaml",
                    "Run flutter pub get",
                    "Test build after dependency removal"
                ],
                confidence_score=0.9
            )
            issues.append(issue)
        
        # Check CocoaPods status
        dependencies = project_config.get("dependencies", {})
        pod_status = dependencies.get("pod_install_status", {})
        
        if pod_status.get("status") == "outdated":
            issue = DeploymentIssue(
                issue_type=IssueType.COCOAPODS,
                severity=Severity.MEDIUM,
                error_message="CocoaPods dependencies are outdated",
                error_code="outdated_pods",
                suggested_fixes=[
                    "Run pod install --repo-update",
                    "Clean CocoaPods cache",
                    "Commit Pods directory",
                    "Test local build"
                ],
                confidence_score=0.8
            )
            issues.append(issue)
        
        # Check code signing issues
        code_signing = diagnostics["code_signing"]
        certificates = code_signing.get("certificates", {})
        
        if certificates.get("certificates_found", 0) == 0:
            issue = DeploymentIssue(
                issue_type=IssueType.CODE_SIGNING,
                severity=Severity.CRITICAL,
                error_message="No distribution certificates found in keychain",
                error_code="no_certificates",
                suggested_fixes=[
                    "Install Apple Distribution certificate",
                    "Verify certificate in Keychain Access",
                    "Configure Xcode Cloud certificates",
                    "Test local archive creation"
                ],
                confidence_score=0.95
            )
            issues.append(issue)
        
        return issues
    
    def _apply_fixes(self, issues: List[DeploymentIssue]) -> Dict[str, Any]:
        """Apply fixes based on identified issues"""
        fix_results = {}
        
        # Group issues by type
        issue_groups = {}
        for issue in issues:
            issue_type = issue.issue_type
            if issue_type not in issue_groups:
                issue_groups[issue_type] = []
            issue_groups[issue_type].append(issue)
        
        # Apply fixes for each issue type
        for issue_type, type_issues in issue_groups.items():
            print(f"   🔧 Fixing {issue_type.value} issues...")
            
            if issue_type == IssueType.COCOAPODS:
                fix_results["cocoapods"] = self.fixer.fix_cocoapods_issues()
            elif issue_type == IssueType.FLUTTER:
                fix_results["flutter"] = self.fixer.fix_flutter_issues()
            elif issue_type == IssueType.CODE_SIGNING:
                fix_results["code_signing"] = self.fixer.fix_code_signing_issues()
            elif issue_type == IssueType.XCODE_CLOUD:
                fix_results["xcode_cloud"] = self.fixer.fix_xcode_cloud_issues()
            elif issue_type == IssueType.APP_STORE:
                fix_results["app_store"] = self.fixer.fix_app_store_connect_issues()
            elif issue_type == IssueType.BUILD_ENVIRONMENT:
                fix_results["build_environment"] = self.fixer.fix_build_environment_issues()
        
        return fix_results
    
    def _generate_health_report(self) -> Dict[str, Any]:
        """Generate deployment health report"""
        return self.monitor.calculate_deployment_health()
    
    def _generate_recommendations(self, results: Dict[str, Any]) -> List[str]:
        """Generate actionable recommendations"""
        recommendations = []
        
        # Check diagnostics results
        diagnostics = results["diagnostics"]
        
        # Check for critical issues
        if diagnostics["code_signing"]["certificates"]["certificates_found"] == 0:
            recommendations.append("🚨 CRITICAL: Install Apple Distribution certificate in keychain")
        
        # Check for high priority issues
        flutter_config = diagnostics["project_structure"]["flutter_config"]
        if flutter_config.get("problematic_dependencies"):
            recommendations.append("⚠️ HIGH: Remove video player dependencies from pubspec.yaml")
        
        # Check fix results
        fixes = results["fixes"]
        for fixer_type, fix_result in fixes.items():
            if not fix_result["success"]:
                recommendations.append(f"🔧 MEDIUM: Address remaining {fixer_type} issues")
        
        # General recommendations
        recommendations.extend([
            "📋 Run deployment checklist to verify readiness",
            "🧪 Test local build before cloud deployment",
            "☁️ Configure Xcode Cloud environment variables",
            "📱 Validate App Store Connect integration",
            "🔄 Monitor build health dashboard"
        ])
        
        return recommendations
    
    def generate_deployment_report(self, results: Dict[str, Any]) -> str:
        """Generate comprehensive deployment report"""
        report = f"""
# 🚀 ChatSY Deployment Report
Generated: {time.strftime('%Y-%m-%d %H:%M:%S')}
Project: {results['project_path']}

## 📊 Executive Summary
- **Project Status**: {'✅ Ready for deployment' if not results['recommendations'] else '⚠️ Issues need attention'}
- **Critical Issues**: {len([r for r in results['recommendations'] if 'CRITICAL' in r])}
- **High Priority Issues**: {len([r for r in results['recommendations'] if 'HIGH' in r])}
- **Overall Health Score**: {results['health']['success_rate']:.1%}

## 🔍 Diagnostic Results

### Project Structure
- **Flutter Configuration**: {results['diagnostics']['project_structure']['flutter_config']['status']}
- **iOS Configuration**: {results['diagnostics']['project_structure']['ios_config']['status']}
- **Dependencies**: {results['diagnostics']['project_structure']['dependencies']['podfile_exists']}

### Code Signing
- **Certificates Found**: {results['diagnostics']['code_signing']['certificates']['certificates_found']}
- **Team ID**: {results['diagnostics']['code_signing']['team_id']['team_id']}
- **Bundle ID**: {results['diagnostics']['code_signing']['bundle_id']['bundle_id']}

## 🔧 Fix Results

"""
        
        for fixer_type, fix_result in results["fixes"].items():
            status = "✅ Success" if fix_result["success"] else "❌ Failed"
            report += f"### {fixer_type.replace('_', ' ').title()}\n"
            report += f"- **Status**: {status}\n"
            report += f"- **Fixes Applied**: {len(fix_result['fixes_applied'])}\n"
            report += f"- **Errors**: {len(fix_result['errors'])}\n\n"
        
        report += """
## 🎯 Recommendations

"""
        
        for i, recommendation in enumerate(results["recommendations"], 1):
            report += f"{i}. {recommendation}\n"
        
        report += """
## 📈 Next Steps

1. **Review Recommendations**: Address all critical and high-priority issues
2. **Test Locally**: Run `flutter build ios` to verify local build
3. **Configure Xcode Cloud**: Set up environment variables and workflow
4. **Deploy**: Push to GitHub to trigger Xcode Cloud build
5. **Monitor**: Watch build health dashboard for improvements

---
*Report generated by XCodeDeployBot - Your iOS Deployment Specialist*
"""
        
        return report
    
    def run_quick_check(self) -> Dict[str, Any]:
        """Run quick deployment check"""
        print("⚡ Running quick deployment check...")
        
        # Run basic diagnostics
        project_structure = self.diagnostics.diagnose_project_structure()
        code_signing = self.diagnostics.diagnose_code_signing()
        
        # Quick analysis
        issues = []
        
        # Check for problematic dependencies
        flutter_config = project_structure.get("flutter_config", {})
        if flutter_config.get("problematic_dependencies"):
            issues.append("Problematic dependencies found")
        
        # Check certificates
        if code_signing["certificates"]["certificates_found"] == 0:
            issues.append("No distribution certificates found")
        
        # Check CocoaPods
        dependencies = project_structure.get("dependencies", {})
        if dependencies["pod_install_status"]["status"] == "outdated":
            issues.append("CocoaPods dependencies outdated")
        
        return {
            "status": "✅ Ready" if not issues else "⚠️ Issues found",
            "issues": issues,
            "recommendations": [
                "Run full deployment check for detailed analysis",
                "Address identified issues before deployment"
            ] if issues else [
                "Project appears ready for deployment",
                "Run full check for comprehensive analysis"
            ]
        }


def main():
    """Main function"""
    parser = argparse.ArgumentParser(description="ChatSY Deployment Manager")
    parser.add_argument("--mode", choices=["full", "quick", "diagnose", "fix", "monitor"], 
                       default="full", help="Deployment check mode")
    parser.add_argument("--project-path", default="/Users/alexjego/Desktop/CHATSY",
                       help="Path to ChatSY project")
    parser.add_argument("--output", help="Output file for report")
    
    args = parser.parse_args()
    
    # Initialize deployment manager
    manager = ChatSYDeploymentManager(args.project_path)
    
    if args.mode == "full":
        # Run full deployment check
        results = manager.run_full_deployment_check()
        report = manager.generate_deployment_report(results)
        
        print(report)
        
        if args.output:
            with open(args.output, 'w') as f:
                f.write(report)
            print(f"\n📁 Report saved to: {args.output}")
    
    elif args.mode == "quick":
        # Run quick check
        results = manager.run_quick_check()
        print(f"\n⚡ Quick Check Results:")
        print(f"Status: {results['status']}")
        print(f"Issues: {', '.join(results['issues']) if results['issues'] else 'None'}")
        print(f"Recommendations:")
        for rec in results['recommendations']:
            print(f"  - {rec}")
    
    elif args.mode == "diagnose":
        # Run diagnostics only
        diagnostics = manager.diagnostics.generate_diagnostic_report()
        print(diagnostics)
    
    elif args.mode == "fix":
        # Run fixes only
        print("🔧 Running comprehensive fixes...")
        fix_results = manager.fixer.run_comprehensive_fix()
        report = manager.fixer.generate_fix_report(fix_results)
        print(report)
    
    elif args.mode == "monitor":
        # Run monitoring
        dashboard = manager.monitor.generate_health_dashboard()
        print(dashboard)
    
    print("\n🎉 ChatSY Deployment Manager completed!")


if __name__ == "__main__":
    main()
