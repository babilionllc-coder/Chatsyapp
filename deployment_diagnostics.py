#!/usr/bin/env python3
"""
Deployment Diagnostics Module
Advanced diagnostic tools for iOS deployment issues
"""

import os
import re
import subprocess
import json
import plistlib
from typing import Dict, List, Any, Optional
from pathlib import Path

class DeploymentDiagnostics:
    """Advanced diagnostic system for iOS deployment issues"""
    
    def __init__(self, project_path: str):
        self.project_path = Path(project_path)
        self.ios_path = self.project_path / "ios"
        self.flutter_path = self.project_path
        
    def diagnose_project_structure(self) -> Dict[str, Any]:
        """Diagnose project structure and configuration"""
        print("🔍 Diagnosing project structure...")
        
        diagnosis = {
            "flutter_config": self._check_flutter_config(),
            "ios_config": self._check_ios_config(),
            "dependencies": self._check_dependencies(),
            "permissions": self._check_permissions(),
            "build_settings": self._check_build_settings()
        }
        
        return diagnosis
    
    def _check_flutter_config(self) -> Dict[str, Any]:
        """Check Flutter configuration"""
        pubspec_path = self.flutter_path / "pubspec.yaml"
        
        if not pubspec_path.exists():
            return {"status": "error", "message": "pubspec.yaml not found"}
        
        try:
            with open(pubspec_path, 'r') as f:
                content = f.read()
            
            # Extract key information
            name_match = re.search(r'name:\s*(\w+)', content)
            version_match = re.search(r'version:\s*([\d.]+)\+(\d+)', content)
            
            # Check for problematic dependencies
            problematic_deps = []
            if "video_player" in content:
                problematic_deps.append("video_player")
            if "chewie" in content:
                problematic_deps.append("chewie")
            
            return {
                "status": "success",
                "name": name_match.group(1) if name_match else "unknown",
                "version": version_match.group(1) if version_match else "unknown",
                "build_number": version_match.group(2) if version_match else "unknown",
                "problematic_dependencies": problematic_deps,
                "flutter_sdk_version": self._get_flutter_version()
            }
        except Exception as e:
            return {"status": "error", "message": str(e)}
    
    def _check_ios_config(self) -> Dict[str, Any]:
        """Check iOS configuration"""
        if not self.ios_path.exists():
            return {"status": "error", "message": "iOS directory not found"}
        
        # Check Xcode project
        project_path = self.ios_path / "Runner.xcodeproj"
        if not project_path.exists():
            return {"status": "error", "message": "Xcode project not found"}
        
        # Check Info.plist
        info_plist_path = self.ios_path / "Runner" / "Info.plist"
        if not info_plist_path.exists():
            return {"status": "error", "message": "Info.plist not found"}
        
        try:
            with open(info_plist_path, 'rb') as f:
                plist_data = plistlib.load(f)
            
            return {
                "status": "success",
                "bundle_identifier": plist_data.get("CFBundleIdentifier", "unknown"),
                "bundle_name": plist_data.get("CFBundleName", "unknown"),
                "bundle_version": plist_data.get("CFBundleVersion", "unknown"),
                "bundle_short_version": plist_data.get("CFBundleShortVersionString", "unknown"),
                "deployment_target": self._get_deployment_target(),
                "permissions": self._extract_permissions(plist_data)
            }
        except Exception as e:
            return {"status": "error", "message": str(e)}
    
    def _check_dependencies(self) -> Dict[str, Any]:
        """Check dependencies and CocoaPods configuration"""
        podfile_path = self.ios_path / "Podfile"
        podfile_lock_path = self.ios_path / "Podfile.lock"
        
        diagnosis = {
            "podfile_exists": podfile_path.exists(),
            "podfile_lock_exists": podfile_lock_path.exists(),
            "cocoapods_version": self._get_cocoapods_version(),
            "pod_install_status": self._check_pod_install_status()
        }
        
        if podfile_path.exists():
            try:
                with open(podfile_path, 'r') as f:
                    podfile_content = f.read()
                
                # Check for problematic pods
                problematic_pods = []
                if "video_player" in podfile_content:
                    problematic_pods.append("video_player")
                if "chewie" in podfile_content:
                    problematic_pods.append("chewie")
                
                diagnosis.update({
                    "problematic_pods": problematic_pods,
                    "deployment_target": self._extract_podfile_deployment_target(podfile_content)
                })
            except Exception as e:
                diagnosis["error"] = str(e)
        
        return diagnosis
    
    def _check_permissions(self) -> Dict[str, Any]:
        """Check iOS permissions and usage descriptions"""
        info_plist_path = self.ios_path / "Runner" / "Info.plist"
        
        if not info_plist_path.exists():
            return {"status": "error", "message": "Info.plist not found"}
        
        try:
            with open(info_plist_path, 'rb') as f:
                plist_data = plistlib.load(f)
            
            permissions = {}
            usage_descriptions = {}
            
            # Check for common permissions
            common_permissions = [
                "NSCameraUsageDescription",
                "NSMicrophoneUsageDescription",
                "NSPhotoLibraryUsageDescription",
                "NSLocationWhenInUseUsageDescription",
                "NSContactsUsageDescription"
            ]
            
            for permission in common_permissions:
                if permission in plist_data:
                    permissions[permission] = True
                    usage_descriptions[permission] = plist_data[permission]
                else:
                    permissions[permission] = False
            
            return {
                "status": "success",
                "permissions": permissions,
                "usage_descriptions": usage_descriptions
            }
        except Exception as e:
            return {"status": "error", "message": str(e)}
    
    def _check_build_settings(self) -> Dict[str, Any]:
        """Check Xcode build settings"""
        project_path = self.ios_path / "Runner.xcodeproj" / "project.pbxproj"
        
        if not project_path.exists():
            return {"status": "error", "message": "project.pbxproj not found"}
        
        try:
            with open(project_path, 'r') as f:
                content = f.read()
            
            # Extract key build settings
            build_settings = {
                "deployment_target": self._extract_build_setting(content, "IPHONEOS_DEPLOYMENT_TARGET"),
                "code_sign_identity": self._extract_build_setting(content, "CODE_SIGN_IDENTITY"),
                "code_sign_style": self._extract_build_setting(content, "CODE_SIGN_STYLE"),
                "development_team": self._extract_build_setting(content, "DEVELOPMENT_TEAM"),
                "provisioning_profile": self._extract_build_setting(content, "PROVISIONING_PROFILE_SPECIFIER")
            }
            
            return {
                "status": "success",
                "build_settings": build_settings
            }
        except Exception as e:
            return {"status": "error", "message": str(e)}
    
    def _get_flutter_version(self) -> str:
        """Get Flutter version"""
        try:
            result = subprocess.run(["flutter", "--version"], capture_output=True, text=True)
            version_match = re.search(r'Flutter (\d+\.\d+\.\d+)', result.stdout)
            return version_match.group(1) if version_match else "unknown"
        except:
            return "unknown"
    
    def _get_deployment_target(self) -> str:
        """Get iOS deployment target from project"""
        project_path = self.ios_path / "Runner.xcodeproj" / "project.pbxproj"
        
        if not project_path.exists():
            return "unknown"
        
        try:
            with open(project_path, 'r') as f:
                content = f.read()
            
            match = re.search(r'IPHONEOS_DEPLOYMENT_TARGET = ([^;]+);', content)
            return match.group(1).strip() if match else "unknown"
        except:
            return "unknown"
    
    def _get_cocoapods_version(self) -> str:
        """Get CocoaPods version"""
        try:
            result = subprocess.run(["pod", "--version"], capture_output=True, text=True)
            return result.stdout.strip() if result.returncode == 0 else "unknown"
        except:
            return "unknown"
    
    def _check_pod_install_status(self) -> Dict[str, Any]:
        """Check if pod install has been run recently"""
        podfile_lock_path = self.ios_path / "Podfile.lock"
        
        if not podfile_lock_path.exists():
            return {"status": "not_run", "message": "Podfile.lock not found"}
        
        try:
            stat = podfile_lock_path.stat()
            import datetime
            last_modified = datetime.datetime.fromtimestamp(stat.st_mtime)
            now = datetime.datetime.now()
            age_hours = (now - last_modified).total_seconds() / 3600
            
            if age_hours < 24:
                return {"status": "recent", "age_hours": age_hours}
            else:
                return {"status": "outdated", "age_hours": age_hours}
        except:
            return {"status": "error", "message": "Cannot check modification time"}
    
    def _extract_permissions(self, plist_data: Dict) -> List[str]:
        """Extract permissions from Info.plist"""
        permissions = []
        
        # Check for usage descriptions (permissions)
        for key in plist_data.keys():
            if key.endswith("UsageDescription"):
                permissions.append(key)
        
        return permissions
    
    def _extract_podfile_deployment_target(self, podfile_content: str) -> str:
        """Extract deployment target from Podfile"""
        match = re.search(r'platform :ios, [\'"]([\d.]+)[\'"]', podfile_content)
        return match.group(1) if match else "unknown"
    
    def _extract_build_setting(self, content: str, setting_name: str) -> str:
        """Extract build setting value from project.pbxproj"""
        pattern = rf'{setting_name} = ([^;]+);'
        match = re.search(pattern, content)
        return match.group(1).strip() if match else "unknown"
    
    def diagnose_code_signing(self) -> Dict[str, Any]:
        """Diagnose code signing configuration"""
        print("🔐 Diagnosing code signing configuration...")
        
        diagnosis = {
            "certificates": self._check_certificates(),
            "provisioning_profiles": self._check_provisioning_profiles(),
            "team_id": self._check_team_id(),
            "bundle_id": self._check_bundle_id(),
            "xcode_cloud_config": self._check_xcode_cloud_config()
        }
        
        return diagnosis
    
    def _check_certificates(self) -> Dict[str, Any]:
        """Check certificate configuration"""
        try:
            # Check keychain for certificates
            result = subprocess.run([
                "security", "find-identity", "-v", "-p", "codesigning"
            ], capture_output=True, text=True)
            
            if result.returncode == 0:
                certificates = []
                for line in result.stdout.split('\n'):
                    if "iPhone Distribution" in line or "Apple Distribution" in line:
                        certificates.append(line.strip())
                
                return {
                    "status": "success",
                    "certificates_found": len(certificates),
                    "certificates": certificates
                }
            else:
                return {"status": "error", "message": "Cannot access keychain"}
        except:
            return {"status": "error", "message": "Cannot check certificates"}
    
    def _check_provisioning_profiles(self) -> Dict[str, Any]:
        """Check provisioning profile configuration"""
        # This would require more complex analysis
        return {"status": "placeholder", "message": "Provisioning profile check not implemented"}
    
    def _check_team_id(self) -> Dict[str, Any]:
        """Check team ID configuration"""
        project_path = self.ios_path / "Runner.xcodeproj" / "project.pbxproj"
        
        if not project_path.exists():
            return {"status": "error", "message": "project.pbxproj not found"}
        
        try:
            with open(project_path, 'r') as f:
                content = f.read()
            
            team_match = re.search(r'DEVELOPMENT_TEAM = ([^;]+);', content)
            team_id = team_match.group(1).strip() if team_match else "unknown"
            
            return {
                "status": "success",
                "team_id": team_id,
                "is_valid": len(team_id) == 10 and team_id.isalnum()
            }
        except:
            return {"status": "error", "message": "Cannot check team ID"}
    
    def _check_bundle_id(self) -> Dict[str, Any]:
        """Check bundle identifier configuration"""
        info_plist_path = self.ios_path / "Runner" / "Info.plist"
        
        if not info_plist_path.exists():
            return {"status": "error", "message": "Info.plist not found"}
        
        try:
            with open(info_plist_path, 'rb') as f:
                plist_data = plistlib.load(f)
            
            bundle_id = plist_data.get("CFBundleIdentifier", "unknown")
            
            return {
                "status": "success",
                "bundle_id": bundle_id,
                "is_valid": bundle_id != "unknown" and "." in bundle_id
            }
        except:
            return {"status": "error", "message": "Cannot check bundle ID"}
    
    def _check_xcode_cloud_config(self) -> Dict[str, Any]:
        """Check Xcode Cloud configuration"""
        # This would require API integration with Xcode Cloud
        return {"status": "placeholder", "message": "Xcode Cloud config check not implemented"}
    
    def generate_diagnostic_report(self) -> str:
        """Generate comprehensive diagnostic report"""
        print("📊 Generating diagnostic report...")
        
        # Run all diagnostics
        project_diagnosis = self.diagnose_project_structure()
        code_signing_diagnosis = self.diagnose_code_signing()
        
        report = f"""
# 🔍 XCodeDeployBot Diagnostic Report
Generated: {os.popen('date').read().strip()}

## 📁 Project Structure Analysis

### Flutter Configuration
- **Status**: {project_diagnosis['flutter_config']['status']}
- **Name**: {project_diagnosis['flutter_config'].get('name', 'unknown')}
- **Version**: {project_diagnosis['flutter_config'].get('version', 'unknown')}
- **Build Number**: {project_diagnosis['flutter_config'].get('build_number', 'unknown')}
- **Flutter SDK**: {project_diagnosis['flutter_config'].get('flutter_sdk_version', 'unknown')}
- **Problematic Dependencies**: {', '.join(project_diagnosis['flutter_config'].get('problematic_dependencies', []))}

### iOS Configuration
- **Status**: {project_diagnosis['ios_config']['status']}
- **Bundle Identifier**: {project_diagnosis['ios_config'].get('bundle_identifier', 'unknown')}
- **Bundle Name**: {project_diagnosis['ios_config'].get('bundle_name', 'unknown')}
- **Bundle Version**: {project_diagnosis['ios_config'].get('bundle_version', 'unknown')}
- **Deployment Target**: {project_diagnosis['ios_config'].get('deployment_target', 'unknown')}

### Dependencies
- **Podfile Exists**: {project_diagnosis['dependencies']['podfile_exists']}
- **Podfile.lock Exists**: {project_diagnosis['dependencies']['podfile_lock_exists']}
- **CocoaPods Version**: {project_diagnosis['dependencies']['cocoapods_version']}
- **Pod Install Status**: {project_diagnosis['dependencies']['pod_install_status']['status']}

## 🔐 Code Signing Analysis

### Certificates
- **Status**: {code_signing_diagnosis['certificates']['status']}
- **Certificates Found**: {code_signing_diagnosis['certificates'].get('certificates_found', 0)}

### Team Configuration
- **Team ID**: {code_signing_diagnosis['team_id'].get('team_id', 'unknown')}
- **Is Valid**: {code_signing_diagnosis['team_id'].get('is_valid', False)}

### Bundle ID
- **Bundle ID**: {code_signing_diagnosis['bundle_id'].get('bundle_id', 'unknown')}
- **Is Valid**: {code_signing_diagnosis['bundle_id'].get('is_valid', False)}

## 🎯 Recommendations

"""
        
        # Add recommendations based on findings
        if project_diagnosis['flutter_config'].get('problematic_dependencies'):
            report += "- Remove problematic video player dependencies\n"
        
        if project_diagnosis['dependencies']['pod_install_status']['status'] == 'outdated':
            report += "- Run 'pod install --repo-update' to update dependencies\n"
        
        if not code_signing_diagnosis['certificates'].get('certificates_found', 0):
            report += "- Install distribution certificates in keychain\n"
        
        if not code_signing_diagnosis['team_id'].get('is_valid', False):
            report += "- Verify team ID configuration\n"
        
        report += """
---
*Diagnostic report generated by XCodeDeployBot*
"""
        
        return report


def main():
    """Test the diagnostic system"""
    diagnostics = DeploymentDiagnostics("/Users/alexjego/Desktop/CHATSY")
    
    # Generate diagnostic report
    report = diagnostics.generate_diagnostic_report()
    print(report)


if __name__ == "__main__":
    main()
