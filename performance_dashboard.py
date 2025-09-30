#!/usr/bin/env python3
"""
Performance Monitoring Dashboard
Real-time performance monitoring and analytics system
"""

import json
import time
import sqlite3
import matplotlib.pyplot as plt
import pandas as pd
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass, asdict
import numpy as np

@dataclass
class PerformanceAlert:
    """Performance alert data structure"""
    alert_id: str
    timestamp: float
    alert_type: str
    severity: str
    message: str
    metric_name: str
    current_value: float
    threshold_value: float
    resolved: bool = False

@dataclass
class PerformanceTrend:
    """Performance trend data structure"""
    metric_name: str
    time_period: str
    current_value: float
    previous_value: float
    trend_direction: str  # "improving", "degrading", "stable"
    change_percentage: float

class PerformanceDashboard:
    """Real-time performance monitoring dashboard"""
    
    def __init__(self, db_path: str = "performance_metrics.db"):
        self.db_path = db_path
        self.alerts = []
        self.trends = []
        self.init_database()
    
    def init_database(self):
        """Initialize SQLite database for performance metrics"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Create performance_metrics table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS performance_metrics (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                timestamp REAL NOT NULL,
                startup_time REAL NOT NULL,
                memory_usage REAL NOT NULL,
                battery_drain REAL NOT NULL,
                ui_fps REAL NOT NULL,
                network_latency REAL NOT NULL,
                image_load_time REAL NOT NULL,
                database_query_time REAL NOT NULL,
                crash_rate REAL NOT NULL,
                user_satisfaction REAL NOT NULL
            )
        ''')
        
        # Create performance_alerts table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS performance_alerts (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                alert_id TEXT UNIQUE NOT NULL,
                timestamp REAL NOT NULL,
                alert_type TEXT NOT NULL,
                severity TEXT NOT NULL,
                message TEXT NOT NULL,
                metric_name TEXT NOT NULL,
                current_value REAL NOT NULL,
                threshold_value REAL NOT NULL,
                resolved BOOLEAN DEFAULT FALSE
            )
        ''')
        
        # Create performance_trends table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS performance_trends (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                timestamp REAL NOT NULL,
                metric_name TEXT NOT NULL,
                time_period TEXT NOT NULL,
                current_value REAL NOT NULL,
                previous_value REAL NOT NULL,
                trend_direction TEXT NOT NULL,
                change_percentage REAL NOT NULL
            )
        ''')
        
        conn.commit()
        conn.close()
    
    def record_performance_metric(self, metrics: Dict[str, float]):
        """Record performance metrics and check for alerts"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        timestamp = time.time()
        
        # Insert metrics
        cursor.execute('''
            INSERT INTO performance_metrics 
            (timestamp, startup_time, memory_usage, battery_drain, ui_fps, network_latency, image_load_time, database_query_time, crash_rate, user_satisfaction)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            timestamp,
            metrics.get('startup_time', 0.0),
            metrics.get('memory_usage', 0.0),
            metrics.get('battery_drain', 0.0),
            metrics.get('ui_fps', 60.0),
            metrics.get('network_latency', 0.0),
            metrics.get('image_load_time', 0.0),
            metrics.get('database_query_time', 0.0),
            metrics.get('crash_rate', 0.0),
            metrics.get('user_satisfaction', 1.0)
        ))
        
        conn.commit()
        conn.close()
        
        # Check for alerts
        self._check_performance_alerts(metrics)
        
        # Update trends
        self._update_performance_trends(metrics)
    
    def _check_performance_alerts(self, metrics: Dict[str, float]):
        """Check for performance alerts based on thresholds"""
        thresholds = {
            'startup_time': {'critical': 5.0, 'warning': 3.0},
            'memory_usage': {'critical': 200.0, 'warning': 150.0},
            'battery_drain': {'critical': 8.0, 'warning': 5.0},
            'ui_fps': {'critical': 30.0, 'warning': 45.0},
            'network_latency': {'critical': 1000.0, 'warning': 500.0},
            'image_load_time': {'critical': 3.0, 'warning': 2.0},
            'crash_rate': {'critical': 5.0, 'warning': 2.0},
            'user_satisfaction': {'critical': 0.5, 'warning': 0.7}
        }
        
        for metric_name, value in metrics.items():
            if metric_name not in thresholds:
                continue
            
            threshold = thresholds[metric_name]
            
            # Check critical threshold
            if value >= threshold['critical']:
                self._create_alert(metric_name, value, threshold['critical'], 'critical')
            elif value >= threshold['warning']:
                self._create_alert(metric_name, value, threshold['warning'], 'warning')
    
    def _create_alert(self, metric_name: str, current_value: float, threshold_value: float, severity: str):
        """Create a performance alert"""
        alert_id = f"{metric_name}_{int(time.time())}"
        
        alert = PerformanceAlert(
            alert_id=alert_id,
            timestamp=time.time(),
            alert_type="performance_threshold",
            severity=severity,
            message=f"{metric_name} exceeded {severity} threshold: {current_value:.2f} > {threshold_value:.2f}",
            metric_name=metric_name,
            current_value=current_value,
            threshold_value=threshold_value
        )
        
        # Store in database
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            INSERT OR REPLACE INTO performance_alerts 
            (alert_id, timestamp, alert_type, severity, message, metric_name, current_value, threshold_value, resolved)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            alert.alert_id,
            alert.timestamp,
            alert.alert_type,
            alert.severity,
            alert.message,
            alert.metric_name,
            alert.current_value,
            alert.threshold_value,
            alert.resolved
        ))
        
        conn.commit()
        conn.close()
        
        self.alerts.append(alert)
    
    def _update_performance_trends(self, metrics: Dict[str, float]):
        """Update performance trends"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Get previous values (last 24 hours)
        cursor.execute('''
            SELECT metric_name, AVG(value) as avg_value
            FROM (
                SELECT 'startup_time' as metric_name, startup_time as value FROM performance_metrics WHERE timestamp > ? - 86400
                UNION ALL
                SELECT 'memory_usage', memory_usage FROM performance_metrics WHERE timestamp > ? - 86400
                UNION ALL
                SELECT 'battery_drain', battery_drain FROM performance_metrics WHERE timestamp > ? - 86400
                UNION ALL
                SELECT 'ui_fps', ui_fps FROM performance_metrics WHERE timestamp > ? - 86400
                UNION ALL
                SELECT 'network_latency', network_latency FROM performance_metrics WHERE timestamp > ? - 86400
                UNION ALL
                SELECT 'image_load_time', image_load_time FROM performance_metrics WHERE timestamp > ? - 86400
                UNION ALL
                SELECT 'crash_rate', crash_rate FROM performance_metrics WHERE timestamp > ? - 86400
                UNION ALL
                SELECT 'user_satisfaction', user_satisfaction FROM performance_metrics WHERE timestamp > ? - 86400
            )
            GROUP BY metric_name
        ''', (time.time(),) * 8)
        
        previous_values = {row[0]: row[1] for row in cursor.fetchall()}
        
        # Calculate trends
        for metric_name, current_value in metrics.items():
            if metric_name in previous_values:
                previous_value = previous_values[metric_name]
                change_percentage = ((current_value - previous_value) / previous_value) * 100 if previous_value != 0 else 0
                
                if change_percentage > 5:
                    trend_direction = "degrading"
                elif change_percentage < -5:
                    trend_direction = "improving"
                else:
                    trend_direction = "stable"
                
                trend = PerformanceTrend(
                    metric_name=metric_name,
                    time_period="24h",
                    current_value=current_value,
                    previous_value=previous_value,
                    trend_direction=trend_direction,
                    change_percentage=change_percentage
                )
                
                # Store trend
                cursor.execute('''
                    INSERT INTO performance_trends 
                    (timestamp, metric_name, time_period, current_value, previous_value, trend_direction, change_percentage)
                    VALUES (?, ?, ?, ?, ?, ?, ?)
                ''', (
                    time.time(),
                    trend.metric_name,
                    trend.time_period,
                    trend.current_value,
                    trend.previous_value,
                    trend.trend_direction,
                    trend.change_percentage
                ))
                
                self.trends.append(trend)
        
        conn.commit()
        conn.close()
    
    def get_performance_summary(self) -> Dict[str, Any]:
        """Get performance summary with current metrics and trends"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Get latest metrics
        cursor.execute('''
            SELECT * FROM performance_metrics 
            ORDER BY timestamp DESC LIMIT 1
        ''')
        
        latest_metrics = cursor.fetchone()
        
        # Get active alerts
        cursor.execute('''
            SELECT COUNT(*) FROM performance_alerts 
            WHERE resolved = FALSE
        ''')
        
        active_alerts = cursor.fetchone()[0]
        
        # Get trend summary
        cursor.execute('''
            SELECT metric_name, trend_direction, COUNT(*) as count
            FROM performance_trends 
            WHERE timestamp > ? - 86400
            GROUP BY metric_name, trend_direction
        ''', (time.time(),))
        
        trend_summary = {}
        for row in cursor.fetchall():
            metric_name, trend_direction, count = row
            if metric_name not in trend_summary:
                trend_summary[metric_name] = {}
            trend_summary[metric_name][trend_direction] = count
        
        conn.close()
        
        return {
            "timestamp": time.time(),
            "latest_metrics": latest_metrics,
            "active_alerts": active_alerts,
            "trend_summary": trend_summary,
            "overall_health": self._calculate_overall_health(latest_metrics, active_alerts)
        }
    
    def _calculate_overall_health(self, metrics: Tuple, active_alerts: int) -> str:
        """Calculate overall performance health"""
        if not metrics:
            return "unknown"
        
        # Extract metrics (excluding id and timestamp)
        startup_time, memory_usage, battery_drain, ui_fps, network_latency, image_load_time, database_query_time, crash_rate, user_satisfaction = metrics[2:]
        
        # Calculate health score
        health_score = 0
        
        # Startup time (lower is better)
        if startup_time <= 2.0:
            health_score += 1
        elif startup_time <= 3.0:
            health_score += 0.7
        elif startup_time <= 5.0:
            health_score += 0.4
        
        # Memory usage (lower is better)
        if memory_usage <= 100:
            health_score += 1
        elif memory_usage <= 150:
            health_score += 0.7
        elif memory_usage <= 200:
            health_score += 0.4
        
        # Battery drain (lower is better)
        if battery_drain <= 3:
            health_score += 1
        elif battery_drain <= 5:
            health_score += 0.7
        elif battery_drain <= 8:
            health_score += 0.4
        
        # UI FPS (higher is better)
        if ui_fps >= 60:
            health_score += 1
        elif ui_fps >= 45:
            health_score += 0.7
        elif ui_fps >= 30:
            health_score += 0.4
        
        # Network latency (lower is better)
        if network_latency <= 200:
            health_score += 1
        elif network_latency <= 500:
            health_score += 0.7
        elif network_latency <= 1000:
            health_score += 0.4
        
        # Crash rate (lower is better)
        if crash_rate <= 1:
            health_score += 1
        elif crash_rate <= 2:
            health_score += 0.7
        elif crash_rate <= 5:
            health_score += 0.4
        
        # User satisfaction (higher is better)
        if user_satisfaction >= 0.9:
            health_score += 1
        elif user_satisfaction >= 0.7:
            health_score += 0.7
        elif user_satisfaction >= 0.5:
            health_score += 0.4
        
        # Normalize score
        health_score = health_score / 7
        
        # Factor in active alerts
        if active_alerts > 5:
            health_score *= 0.5
        elif active_alerts > 2:
            health_score *= 0.7
        
        # Determine health status
        if health_score >= 0.8:
            return "excellent"
        elif health_score >= 0.6:
            return "good"
        elif health_score >= 0.4:
            return "needs_attention"
        else:
            return "critical"
    
    def generate_performance_charts(self) -> Dict[str, str]:
        """Generate performance charts and save as files"""
        conn = sqlite3.connect(self.db_path)
        
        # Get performance data for last 7 days
        df = pd.read_sql_query('''
            SELECT * FROM performance_metrics 
            WHERE timestamp > ? - 604800
            ORDER BY timestamp
        ''', conn, params=(time.time(),))
        
        conn.close()
        
        if df.empty:
            return {"error": "No performance data available"}
        
        # Convert timestamp to datetime
        df['datetime'] = pd.to_datetime(df['timestamp'], unit='s')
        
        charts = {}
        
        # Startup time chart
        plt.figure(figsize=(12, 6))
        plt.plot(df['datetime'], df['startup_time'], marker='o', linewidth=2)
        plt.title('Startup Time Over Time', fontsize=16, fontweight='bold')
        plt.xlabel('Time')
        plt.ylabel('Startup Time (seconds)')
        plt.grid(True, alpha=0.3)
        plt.xticks(rotation=45)
        plt.tight_layout()
        plt.savefig('startup_time_chart.png', dpi=300, bbox_inches='tight')
        plt.close()
        charts['startup_time'] = 'startup_time_chart.png'
        
        # Memory usage chart
        plt.figure(figsize=(12, 6))
        plt.plot(df['datetime'], df['memory_usage'], marker='o', linewidth=2, color='orange')
        plt.title('Memory Usage Over Time', fontsize=16, fontweight='bold')
        plt.xlabel('Time')
        plt.ylabel('Memory Usage (MB)')
        plt.grid(True, alpha=0.3)
        plt.xticks(rotation=45)
        plt.tight_layout()
        plt.savefig('memory_usage_chart.png', dpi=300, bbox_inches='tight')
        plt.close()
        charts['memory_usage'] = 'memory_usage_chart.png'
        
        # UI FPS chart
        plt.figure(figsize=(12, 6))
        plt.plot(df['datetime'], df['ui_fps'], marker='o', linewidth=2, color='green')
        plt.title('UI Frame Rate Over Time', fontsize=16, fontweight='bold')
        plt.xlabel('Time')
        plt.ylabel('FPS')
        plt.grid(True, alpha=0.3)
        plt.xticks(rotation=45)
        plt.tight_layout()
        plt.savefig('ui_fps_chart.png', dpi=300, bbox_inches='tight')
        plt.close()
        charts['ui_fps'] = 'ui_fps_chart.png'
        
        # Network latency chart
        plt.figure(figsize=(12, 6))
        plt.plot(df['datetime'], df['network_latency'], marker='o', linewidth=2, color='red')
        plt.title('Network Latency Over Time', fontsize=16, fontweight='bold')
        plt.xlabel('Time')
        plt.ylabel('Latency (ms)')
        plt.grid(True, alpha=0.3)
        plt.xticks(rotation=45)
        plt.tight_layout()
        plt.savefig('network_latency_chart.png', dpi=300, bbox_inches='tight')
        plt.close()
        charts['network_latency'] = 'network_latency_chart.png'
        
        # Combined performance chart
        plt.figure(figsize=(15, 10))
        
        plt.subplot(2, 2, 1)
        plt.plot(df['datetime'], df['startup_time'], marker='o', linewidth=2)
        plt.title('Startup Time')
        plt.ylabel('Seconds')
        plt.xticks(rotation=45)
        plt.grid(True, alpha=0.3)
        
        plt.subplot(2, 2, 2)
        plt.plot(df['datetime'], df['memory_usage'], marker='o', linewidth=2, color='orange')
        plt.title('Memory Usage')
        plt.ylabel('MB')
        plt.xticks(rotation=45)
        plt.grid(True, alpha=0.3)
        
        plt.subplot(2, 2, 3)
        plt.plot(df['datetime'], df['ui_fps'], marker='o', linewidth=2, color='green')
        plt.title('UI Frame Rate')
        plt.ylabel('FPS')
        plt.xticks(rotation=45)
        plt.grid(True, alpha=0.3)
        
        plt.subplot(2, 2, 4)
        plt.plot(df['datetime'], df['network_latency'], marker='o', linewidth=2, color='red')
        plt.title('Network Latency')
        plt.ylabel('ms')
        plt.xticks(rotation=45)
        plt.grid(True, alpha=0.3)
        
        plt.suptitle('Performance Metrics Dashboard', fontsize=16, fontweight='bold')
        plt.tight_layout()
        plt.savefig('performance_dashboard.png', dpi=300, bbox_inches='tight')
        plt.close()
        charts['dashboard'] = 'performance_dashboard.png'
        
        return charts
    
    def generate_performance_report(self) -> str:
        """Generate comprehensive performance report"""
        summary = self.get_performance_summary()
        
        report = f"""
# 📊 Performance Monitoring Dashboard Report
Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

## 🎯 Performance Summary
- **Overall Health**: {summary['overall_health'].upper()}
- **Active Alerts**: {summary['active_alerts']}
- **Latest Metrics**: {datetime.fromtimestamp(summary['timestamp']).strftime('%Y-%m-%d %H:%M:%S')}

## 📈 Current Performance Metrics
"""
        
        if summary['latest_metrics']:
            metrics = summary['latest_metrics']
            report += f"""
- **Startup Time**: {metrics[2]:.2f} seconds
- **Memory Usage**: {metrics[3]:.2f} MB
- **Battery Drain**: {metrics[4]:.2f}% per hour
- **UI Frame Rate**: {metrics[5]:.2f} FPS
- **Network Latency**: {metrics[6]:.2f} ms
- **Image Load Time**: {metrics[7]:.2f} seconds
- **Database Query Time**: {metrics[8]:.2f} ms
- **Crash Rate**: {metrics[9]:.2f}%
- **User Satisfaction**: {metrics[10]:.2f}
"""
        
        report += """
## 🚨 Active Alerts
"""
        
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            SELECT * FROM performance_alerts 
            WHERE resolved = FALSE
            ORDER BY timestamp DESC
            LIMIT 10
        ''')
        
        active_alerts = cursor.fetchall()
        
        if active_alerts:
            for alert in active_alerts:
                report += f"""
### {alert[3].upper()} Alert: {alert[2]}
- **Message**: {alert[5]}
- **Metric**: {alert[6]}
- **Current Value**: {alert[7]:.2f}
- **Threshold**: {alert[8]:.2f}
- **Time**: {datetime.fromtimestamp(alert[1]).strftime('%Y-%m-%d %H:%M:%S')}
"""
        else:
            report += "No active alerts 🎉"
        
        report += """
## 📊 Performance Trends
"""
        
        cursor.execute('''
            SELECT metric_name, trend_direction, COUNT(*) as count
            FROM performance_trends 
            WHERE timestamp > ? - 86400
            GROUP BY metric_name, trend_direction
            ORDER BY metric_name
        ''', (time.time(),))
        
        trends = cursor.fetchall()
        
        if trends:
            for trend in trends:
                metric_name, direction, count = trend
                emoji = "📈" if direction == "improving" else "📉" if direction == "degrading" else "➡️"
                report += f"- **{metric_name}**: {emoji} {direction} ({count} measurements)\n"
        else:
            report += "No trend data available"
        
        conn.close()
        
        report += """
## 🎯 Recommendations

### High Priority:
1. **Address Critical Alerts**: Resolve any critical performance alerts immediately
2. **Monitor Trends**: Watch for degrading performance trends
3. **Optimize Bottlenecks**: Focus on metrics showing poor performance

### Medium Priority:
1. **Performance Testing**: Implement regular performance testing
2. **Monitoring Setup**: Ensure continuous performance monitoring
3. **Alert Configuration**: Fine-tune alert thresholds

### Low Priority:
1. **Performance Documentation**: Document performance optimization strategies
2. **Team Training**: Train team on performance best practices
3. **Process Improvement**: Implement performance review processes

---
*Report generated by Performance Dashboard*
"""
        
        return report


def main():
    """Test the performance dashboard"""
    dashboard = PerformanceDashboard()
    
    # Simulate some performance data
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
    
    # Generate report
    report = dashboard.generate_performance_report()
    print(report)
    
    # Generate charts
    charts = dashboard.generate_performance_charts()
    print(f"Generated charts: {list(charts.keys())}")


if __name__ == "__main__":
    main()
