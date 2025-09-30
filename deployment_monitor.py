#!/usr/bin/env python3
"""
Deployment Monitor Module
Monitoring and analytics dashboard for iOS deployment
"""

import json
import time
import sqlite3
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional
from dataclasses import dataclass, asdict
import matplotlib.pyplot as plt
import pandas as pd

@dataclass
class BuildMetrics:
    """Build metrics data structure"""
    timestamp: float
    build_id: str
    status: str  # success, failed, in_progress
    duration: float  # in seconds
    error_type: Optional[str]
    error_message: Optional[str]
    fixer_applied: Optional[str]
    fix_success: Optional[bool]

@dataclass
class DeploymentHealth:
    """Deployment health metrics"""
    success_rate: float
    average_build_time: float
    common_errors: Dict[str, int]
    fix_effectiveness: Dict[str, float]
    trend_data: List[Dict[str, Any]]

class DeploymentMonitor:
    """Monitoring and analytics system for iOS deployment"""
    
    def __init__(self, db_path: str = "deployment_metrics.db"):
        self.db_path = db_path
        self.init_database()
    
    def init_database(self):
        """Initialize SQLite database for metrics storage"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Create build_metrics table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS build_metrics (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                timestamp REAL NOT NULL,
                build_id TEXT NOT NULL,
                status TEXT NOT NULL,
                duration REAL,
                error_type TEXT,
                error_message TEXT,
                fixer_applied TEXT,
                fix_success BOOLEAN
            )
        ''')
        
        # Create deployment_health table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS deployment_health (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                timestamp REAL NOT NULL,
                success_rate REAL NOT NULL,
                average_build_time REAL NOT NULL,
                common_errors TEXT,
                fix_effectiveness TEXT,
                trend_data TEXT
            )
        ''')
        
        conn.commit()
        conn.close()
    
    def record_build_metric(self, metric: BuildMetrics):
        """Record a build metric"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            INSERT INTO build_metrics 
            (timestamp, build_id, status, duration, error_type, error_message, fixer_applied, fix_success)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            metric.timestamp,
            metric.build_id,
            metric.status,
            metric.duration,
            metric.error_type,
            metric.error_message,
            metric.fixer_applied,
            metric.fix_success
        ))
        
        conn.commit()
        conn.close()
    
    def get_build_metrics(self, days: int = 30) -> List[BuildMetrics]:
        """Get build metrics for the last N days"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cutoff_time = time.time() - (days * 24 * 60 * 60)
        
        cursor.execute('''
            SELECT timestamp, build_id, status, duration, error_type, error_message, fixer_applied, fix_success
            FROM build_metrics
            WHERE timestamp > ?
            ORDER BY timestamp DESC
        ''', (cutoff_time,))
        
        rows = cursor.fetchall()
        conn.close()
        
        metrics = []
        for row in rows:
            metric = BuildMetrics(
                timestamp=row[0],
                build_id=row[1],
                status=row[2],
                duration=row[3],
                error_type=row[4],
                error_message=row[5],
                fixer_applied=row[6],
                fix_success=row[7]
            )
            metrics.append(metric)
        
        return metrics
    
    def calculate_deployment_health(self, days: int = 30) -> DeploymentHealth:
        """Calculate deployment health metrics"""
        metrics = self.get_build_metrics(days)
        
        if not metrics:
            return DeploymentHealth(
                success_rate=0.0,
                average_build_time=0.0,
                common_errors={},
                fix_effectiveness={},
                trend_data=[]
            )
        
        # Calculate success rate
        total_builds = len(metrics)
        successful_builds = len([m for m in metrics if m.status == "success"])
        success_rate = successful_builds / total_builds if total_builds > 0 else 0.0
        
        # Calculate average build time
        build_times = [m.duration for m in metrics if m.duration is not None]
        average_build_time = sum(build_times) / len(build_times) if build_times else 0.0
        
        # Calculate common errors
        common_errors = {}
        for metric in metrics:
            if metric.error_type:
                common_errors[metric.error_type] = common_errors.get(metric.error_type, 0) + 1
        
        # Calculate fix effectiveness
        fix_effectiveness = {}
        for metric in metrics:
            if metric.fixer_applied:
                if metric.fixer_applied not in fix_effectiveness:
                    fix_effectiveness[metric.fixer_applied] = {"success": 0, "total": 0}
                
                fix_effectiveness[metric.fixer_applied]["total"] += 1
                if metric.fix_success:
                    fix_effectiveness[metric.fixer_applied]["success"] += 1
        
        # Calculate effectiveness percentages
        for fixer in fix_effectiveness:
            total = fix_effectiveness[fixer]["total"]
            success = fix_effectiveness[fixer]["success"]
            fix_effectiveness[fixer] = success / total if total > 0 else 0.0
        
        # Generate trend data
        trend_data = self._generate_trend_data(metrics)
        
        return DeploymentHealth(
            success_rate=success_rate,
            average_build_time=average_build_time,
            common_errors=common_errors,
            fix_effectiveness=fix_effectiveness,
            trend_data=trend_data
        )
    
    def _generate_trend_data(self, metrics: List[BuildMetrics]) -> List[Dict[str, Any]]:
        """Generate trend data for visualization"""
        # Group metrics by day
        daily_metrics = {}
        
        for metric in metrics:
            date = datetime.fromtimestamp(metric.timestamp).date()
            if date not in daily_metrics:
                daily_metrics[date] = {"total": 0, "success": 0, "duration": []}
            
            daily_metrics[date]["total"] += 1
            if metric.status == "success":
                daily_metrics[date]["success"] += 1
            if metric.duration:
                daily_metrics[date]["duration"].append(metric.duration)
        
        # Convert to trend data
        trend_data = []
        for date, data in sorted(daily_metrics.items()):
            success_rate = data["success"] / data["total"] if data["total"] > 0 else 0.0
            avg_duration = sum(data["duration"]) / len(data["duration"]) if data["duration"] else 0.0
            
            trend_data.append({
                "date": date.isoformat(),
                "success_rate": success_rate,
                "average_duration": avg_duration,
                "total_builds": data["total"]
            })
        
        return trend_data
    
    def generate_health_dashboard(self, days: int = 30) -> str:
        """Generate health dashboard report"""
        health = self.calculate_deployment_health(days)
        
        dashboard = f"""
# 📊 XCodeDeployBot Health Dashboard
Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
Period: Last {days} days

## 🎯 Overall Health Score
**Success Rate**: {health.success_rate:.1%}
**Average Build Time**: {health.average_build_time:.1f} seconds
**Health Score**: {self._calculate_health_score(health):.1%}

## 🔍 Common Error Analysis
"""
        
        if health.common_errors:
            for error_type, count in sorted(health.common_errors.items(), key=lambda x: x[1], reverse=True):
                dashboard += f"- **{error_type}**: {count} occurrences\n"
        else:
            dashboard += "- No errors recorded in the selected period\n"
        
        dashboard += """
## 🔧 Fix Effectiveness
"""
        
        if health.fix_effectiveness:
            for fixer, effectiveness in health.fix_effectiveness.items():
                dashboard += f"- **{fixer}**: {effectiveness:.1%} success rate\n"
        else:
            dashboard += "- No fix data available\n"
        
        dashboard += """
## 📈 Trend Analysis
"""
        
        if health.trend_data:
            recent_trend = health.trend_data[-7:] if len(health.trend_data) >= 7 else health.trend_data
            
            dashboard += "### Last 7 Days\n"
            for day_data in recent_trend:
                dashboard += f"- **{day_data['date']}**: {day_data['success_rate']:.1%} success rate, {day_data['average_duration']:.1f}s avg build time\n"
        else:
            dashboard += "- No trend data available\n"
        
        dashboard += """
## 🎯 Recommendations
"""
        
        # Generate recommendations based on health data
        if health.success_rate < 0.8:
            dashboard += "- ⚠️ Low success rate - investigate common errors\n"
        
        if health.average_build_time > 300:  # 5 minutes
            dashboard += "- ⚠️ Long build times - optimize build process\n"
        
        if health.common_errors:
            most_common_error = max(health.common_errors.items(), key=lambda x: x[1])
            dashboard += f"- 🔧 Focus on fixing {most_common_error[0]} errors\n"
        
        if health.fix_effectiveness:
            least_effective_fixer = min(health.fix_effectiveness.items(), key=lambda x: x[1])
            if least_effective_fixer[1] < 0.5:
                dashboard += f"- 🔧 Improve {least_effective_fixer[0]} fixer effectiveness\n"
        
        dashboard += """
---
*Health dashboard generated by XCodeDeployBot*
"""
        
        return dashboard
    
    def _calculate_health_score(self, health: DeploymentHealth) -> float:
        """Calculate overall health score"""
        # Weighted scoring system
        success_weight = 0.6
        time_weight = 0.2
        error_weight = 0.2
        
        # Success rate score
        success_score = health.success_rate
        
        # Build time score (inverse relationship - faster is better)
        max_acceptable_time = 600  # 10 minutes
        time_score = max(0, 1 - (health.average_build_time / max_acceptable_time))
        
        # Error score (fewer errors is better)
        total_errors = sum(health.common_errors.values())
        error_score = max(0, 1 - (total_errors / 10))  # Penalty for more than 10 errors
        
        # Calculate weighted health score
        health_score = (success_score * success_weight + 
                       time_score * time_weight + 
                       error_score * error_weight)
        
        return min(1.0, health_score)
    
    def create_visualizations(self, days: int = 30):
        """Create visualizations for deployment metrics"""
        health = self.calculate_deployment_health(days)
        
        if not health.trend_data:
            print("No trend data available for visualization")
            return
        
        # Create figure with subplots
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(15, 10))
        fig.suptitle('XCodeDeployBot Deployment Health Dashboard', fontsize=16)
        
        # Prepare data
        dates = [datetime.fromisoformat(day['date']) for day in health.trend_data]
        success_rates = [day['success_rate'] for day in health.trend_data]
        build_times = [day['average_duration'] for day in health.trend_data]
        build_counts = [day['total_builds'] for day in health.trend_data]
        
        # Plot 1: Success Rate Trend
        ax1.plot(dates, success_rates, marker='o', linewidth=2, markersize=6)
        ax1.set_title('Success Rate Trend')
        ax1.set_ylabel('Success Rate')
        ax1.set_ylim(0, 1)
        ax1.grid(True, alpha=0.3)
        ax1.tick_params(axis='x', rotation=45)
        
        # Plot 2: Build Time Trend
        ax2.plot(dates, build_times, marker='s', color='orange', linewidth=2, markersize=6)
        ax2.set_title('Average Build Time Trend')
        ax2.set_ylabel('Build Time (seconds)')
        ax2.grid(True, alpha=0.3)
        ax2.tick_params(axis='x', rotation=45)
        
        # Plot 3: Build Count Trend
        ax3.bar(dates, build_counts, color='green', alpha=0.7)
        ax3.set_title('Daily Build Count')
        ax3.set_ylabel('Number of Builds')
        ax3.grid(True, alpha=0.3)
        ax3.tick_params(axis='x', rotation=45)
        
        # Plot 4: Error Distribution
        if health.common_errors:
            error_types = list(health.common_errors.keys())
            error_counts = list(health.common_errors.values())
            ax4.bar(error_types, error_counts, color='red', alpha=0.7)
            ax4.set_title('Error Distribution')
            ax4.set_ylabel('Error Count')
            ax4.tick_params(axis='x', rotation=45)
        else:
            ax4.text(0.5, 0.5, 'No Errors', ha='center', va='center', transform=ax4.transAxes)
            ax4.set_title('Error Distribution')
        
        plt.tight_layout()
        plt.savefig('deployment_health_dashboard.png', dpi=300, bbox_inches='tight')
        plt.show()
        
        print("📊 Health dashboard visualization saved as 'deployment_health_dashboard.png'")
    
    def export_metrics(self, format: str = "json", days: int = 30) -> str:
        """Export metrics in various formats"""
        health = self.calculate_deployment_health(days)
        metrics = self.get_build_metrics(days)
        
        if format == "json":
            export_data = {
                "health": asdict(health),
                "metrics": [asdict(m) for m in metrics],
                "exported_at": datetime.now().isoformat()
            }
            
            filename = f"deployment_metrics_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
            with open(filename, 'w') as f:
                json.dump(export_data, f, indent=2)
            
            return filename
        
        elif format == "csv":
            # Convert metrics to DataFrame
            df = pd.DataFrame([asdict(m) for m in metrics])
            filename = f"deployment_metrics_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
            df.to_csv(filename, index=False)
            
            return filename
        
        else:
            raise ValueError(f"Unsupported export format: {format}")


def main():
    """Test the deployment monitor"""
    monitor = DeploymentMonitor()
    
    # Generate sample data for testing
    sample_metrics = [
        BuildMetrics(
            timestamp=time.time() - 3600,  # 1 hour ago
            build_id="build_001",
            status="success",
            duration=180.5,
            error_type=None,
            error_message=None,
            fixer_applied="CocoaPodsFixer",
            fix_success=True
        ),
        BuildMetrics(
            timestamp=time.time() - 7200,  # 2 hours ago
            build_id="build_002",
            status="failed",
            duration=120.0,
            error_type="code_signing",
            error_message="CODE_SIGN_IDENTITY=-",
            fixer_applied="CodeSigningFixer",
            fix_success=False
        )
    ]
    
    # Record sample metrics
    for metric in sample_metrics:
        monitor.record_build_metric(metric)
    
    # Generate health dashboard
    dashboard = monitor.generate_health_dashboard()
    print(dashboard)
    
    # Export metrics
    json_file = monitor.export_metrics("json")
    print(f"📁 Metrics exported to: {json_file}")


if __name__ == "__main__":
    main()
