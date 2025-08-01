#!/usr/bin/env python3
"""
Comprehensive Report Generation Script for Vyges IP Template
===========================================================
This script orchestrates the enhanced Python tools to generate a complete analysis report
including code KPIs, synthesis metrics, and gate analysis.
This is a template version that should be customized for specific IP projects.
"""

import os
import sys
import json
import argparse
from pathlib import Path
from datetime import datetime
from typing import Dict, Any

def run_code_kpis_analysis(project_root: str = ".") -> Dict[str, Any]:
    """Run code KPIs analysis and return results."""
    try:
        # Import the code KPIs module
        sys.path.insert(0, str(Path(project_root) / "scripts"))
        from code_kpis import VygesCodeKPIs
        
        analyzer = VygesCodeKPIs(project_root)
        kpis = analyzer.analyze_project(detailed=True)
        return kpis
    except Exception as e:
        print(f"Warning: Code KPIs analysis failed: {e}")
        return {}

def run_gate_analysis(project_root: str = ".", output_dir: str = "reports") -> str:
    """Run gate analysis and return the report path."""
    try:
        gate_analysis_script = Path(project_root) / "flow" / "yosys" / "gate_analysis.py"
        if gate_analysis_script.exists():
            import subprocess
            
            # Create output directory
            os.makedirs(output_dir, exist_ok=True)
            output_file = Path(output_dir) / "gate_analysis_report.md"
            
            # Run gate analysis
            cmd = [
                sys.executable, str(gate_analysis_script),
                "--comprehensive",
                "--synthesis-dir", str(Path(project_root) / "flow" / "synthesis"),
                "--output", str(output_file)
            ]
            
            result = subprocess.run(cmd, capture_output=True, text=True, cwd=project_root)
            
            if result.returncode == 0:
                print(f"✅ Gate analysis completed: {output_file}")
                return str(output_file)
            else:
                print(f"Warning: Gate analysis failed: {result.stderr}")
                return ""
        else:
            print(f"Warning: Gate analysis script not found: {gate_analysis_script}")
            return ""
    except Exception as e:
        print(f"Warning: Gate analysis failed: {e}")
        return ""

def generate_comprehensive_report(project_root: str = ".", output_dir: str = "reports") -> str:
    """Generate a comprehensive report combining all analyses."""
    
    print("🔍 Starting comprehensive IP analysis (template)...")
    print(f"📁 Project root: {project_root}")
    print(f"📁 Output directory: {output_dir}")
    
    # Create output directory
    os.makedirs(output_dir, exist_ok=True)
    
    # Run code KPIs analysis
    print("\n📊 Running code KPIs analysis...")
    kpis = run_code_kpis_analysis(project_root)
    
    # Run gate analysis
    print("\n🔧 Running gate analysis...")
    gate_report_path = run_gate_analysis(project_root, output_dir)
    
    # Generate comprehensive report
    print("\n📝 Generating comprehensive report...")
    report_path = Path(output_dir) / "comprehensive_analysis_report.md"
    
    with open(report_path, 'w') as f:
        f.write("# IP Comprehensive Analysis Report (Template)\n")
        f.write("=" * 50 + "\n\n")
        f.write(f"**Generated:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"**Project:** {Path(project_root).name}\n\n")
        
        # Code KPIs Summary
        if kpis:
            f.write("## 📊 Code KPIs Summary\n\n")
            
            summary = kpis.get("summary", {})
            f.write(f"**Overall Score:** {summary.get('overall_score', 0):.1f}/100\n\n")
            
            # Code metrics
            code_metrics = kpis.get("code_metrics", {})
            f.write("### Code Metrics\n")
            f.write(f"- **RTL Files:** {code_metrics.get('rtl_files', 0)}\n")
            f.write(f"- **RTL Lines:** {code_metrics.get('rtl_lines', 0):,}\n")
            f.write(f"- **RTL Modules:** {code_metrics.get('rtl_modules', 0)}\n")
            f.write(f"- **Testbench Files:** {code_metrics.get('testbench_files', 0)}\n")
            f.write(f"- **Testbench Lines:** {code_metrics.get('testbench_lines', 0):,}\n\n")
            
            # Quality metrics
            quality_metrics = kpis.get("quality_metrics", {})
            f.write("### Quality Metrics\n")
            f.write(f"- **Synthesis Clean:** {'✅' if quality_metrics.get('synthesis_clean', False) else '❌'}\n")
            f.write(f"- **Synthesis Stats Available:** {'✅' if quality_metrics.get('synthesis_stats_available', False) else '❌'}\n")
            f.write(f"- **Modules Synthesized:** {quality_metrics.get('synthesis_modules_count', 0)}\n")
            
            # Synthesis metrics
            if quality_metrics.get('synthesis_stats_available', False):
                f.write(f"- **Total Gate Count:** {quality_metrics.get('total_gate_count', 0):,} cells\n")
                if quality_metrics.get('module_gate_counts'):
                    f.write("- **Module Breakdown:**\n")
                    for module, gates in quality_metrics['module_gate_counts'].items():
                        f.write(f"  - {module}: {gates:,} cells\n")
            
            f.write("\n")
            
            # Metadata analysis
            metadata_analysis = kpis.get("metadata_analysis", {})
            if metadata_analysis.get("metadata_exists", False):
                f.write("### Vyges Metadata Analysis\n")
                f.write(f"- **Quality Score:** {metadata_analysis.get('quality_score', 0):.1f}/100\n")
                f.write(f"- **Catalog Readiness:** {metadata_analysis.get('catalog_readiness', 'unknown').upper()}\n")
                f.write(f"- **Field Completeness:** {metadata_analysis.get('field_completeness', 0):.1f}%\n")
                f.write(f"- **AI Generation Ready:** {'✅' if metadata_analysis.get('ai_generation_ready', False) else '❌'}\n\n")
        
        # Gate Analysis Summary
        if gate_report_path and Path(gate_report_path).exists():
            f.write("## 🔧 Gate Analysis Summary\n\n")
            f.write(f"Detailed gate analysis report: `{gate_report_path}`\n\n")
            
            # Try to extract key metrics from gate report
            try:
                with open(gate_report_path, 'r') as gate_file:
                    gate_content = gate_file.read()
                    
                    # Extract total gate count
                    import re
                    total_match = re.search(r'Reported Modules.*?~(\d+) cells', gate_content)
                    if total_match:
                        f.write(f"**Total Gate Count:** ~{total_match.group(1)} cells\n\n")
                    
                    # Extract die size estimates
                    area_match = re.search(r'Total Estimated Area.*?~([\d.]+) mm²', gate_content)
                    if area_match:
                        f.write(f"**Estimated Die Area:** ~{area_match.group(1)} mm² (45nm process)\n\n")
            except Exception as e:
                f.write(f"Could not extract detailed metrics from gate report: {e}\n\n")
        
        # Recommendations
        f.write("## 🎯 Key Recommendations\n\n")
        
        if kpis:
            summary = kpis.get("summary", {})
            if summary.get("recommendations"):
                for rec in summary["recommendations"]:
                    f.write(f"- {rec}\n")
            else:
                f.write("- Implement comprehensive test coverage\n")
                f.write("- Add synthesis constraints for timing optimization\n")
                f.write("- Perform power analysis with realistic workloads\n")
                f.write("- Optimize memory interface for production use\n")
        
        f.write("\n## 📋 Generated Reports\n\n")
        f.write("The following reports were generated:\n")
        f.write(f"- **Code KPIs:** Available in JSON format\n")
        if gate_report_path:
            f.write(f"- **Gate Analysis:** {gate_report_path}\n")
        f.write(f"- **Comprehensive Report:** {report_path}\n")
        
        f.write("\n## 🏆 Conclusion\n\n")
        f.write("The FFT IP demonstrates good synthesis quality and is ready for further development.\n")
        f.write("Key areas for improvement include memory interface optimization and comprehensive testing.\n")
    
    print(f"✅ Comprehensive report generated: {report_path}")
    return str(report_path)

def main():
    """Main function with command line argument parsing."""
    parser = argparse.ArgumentParser(description='Generate comprehensive FFT IP analysis report')
    parser.add_argument('--project-root', default='.', 
                       help='Project root directory')
    parser.add_argument('--output-dir', default='reports',
                       help='Output directory for reports')
    parser.add_argument('--code-kpis-only', action='store_true',
                       help='Generate only code KPIs analysis')
    parser.add_argument('--gate-analysis-only', action='store_true',
                       help='Generate only gate analysis')
    
    args = parser.parse_args()
    
    if args.code_kpis_only:
        print("📊 Running code KPIs analysis only...")
        kpis = run_code_kpis_analysis(args.project_root)
        if kpis:
            output_file = Path(args.output_dir) / "code_kpis.json"
            os.makedirs(args.output_dir, exist_ok=True)
            with open(output_file, 'w') as f:
                json.dump(kpis, f, indent=2)
            print(f"✅ Code KPIs saved to: {output_file}")
    elif args.gate_analysis_only:
        print("🔧 Running gate analysis only...")
        gate_report_path = run_gate_analysis(args.project_root, args.output_dir)
        if gate_report_path:
            print(f"✅ Gate analysis completed: {gate_report_path}")
    else:
        # Generate comprehensive report
        report_path = generate_comprehensive_report(args.project_root, args.output_dir)
        print(f"\n🎉 Analysis complete! Comprehensive report: {report_path}")

if __name__ == "__main__":
    main() 