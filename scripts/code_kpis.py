#!/usr/bin/env python3
"""
Vyges Code KPIs Analysis Script

This script analyzes code metrics and KPIs for Vyges IP projects including:
- Lines of RTL code
- Documentation coverage
- Test coverage
- Project structure analysis
- Quality metrics

Usage:
    python scripts/code_kpis.py [--detailed] [--output json|csv|text]
"""

import os
import sys
import json
import argparse
from pathlib import Path
from typing import Dict, List, Any
import subprocess
from datetime import datetime


class VygesCodeKPIs:
    """Analyze code KPIs for Vyges IP projects."""
    
    def __init__(self, project_root: str = "."):
        self.project_root = Path(project_root)
        self.kpis = {}
        
    def analyze_project(self, detailed: bool = False) -> Dict[str, Any]:
        """Analyze the entire project and return KPIs."""
        
        # Basic project info
        self.kpis["project_info"] = self._get_project_info()
        
        # File structure analysis
        self.kpis["file_structure"] = self._analyze_file_structure()
        
        # Code metrics
        self.kpis["code_metrics"] = self._analyze_code_metrics()
        
        # Documentation metrics
        self.kpis["documentation_metrics"] = self._analyze_documentation()
        
        # Test metrics
        self.kpis["test_metrics"] = self._analyze_test_coverage()
        
        # Quality metrics
        self.kpis["quality_metrics"] = self._analyze_quality_metrics()
        
        # Metadata analysis
        self.kpis["metadata_analysis"] = self._analyze_metadata()
        
        if detailed:
            self.kpis["detailed_analysis"] = self._detailed_analysis()
        
        # Summary
        self.kpis["summary"] = self._generate_summary()
        
        return self.kpis
    
    def _get_project_info(self) -> Dict[str, Any]:
        """Get basic project information."""
        info = {
            "project_name": self.project_root.name,
            "analysis_date": datetime.now().isoformat(),
            "project_root": str(self.project_root.absolute())
        }
        
        # Try to get git info
        try:
            result = subprocess.run(
                ["git", "rev-parse", "--show-toplevel"],
                cwd=self.project_root,
                capture_output=True,
                text=True
            )
            if result.returncode == 0:
                info["git_repo"] = result.stdout.strip()
                
                # Get git status
                result = subprocess.run(
                    ["git", "status", "--porcelain"],
                    cwd=self.project_root,
                    capture_output=True,
                    text=True
                )
                if result.returncode == 0:
                    info["git_status"] = "clean" if not result.stdout.strip() else "dirty"
                    
        except (subprocess.SubprocessError, FileNotFoundError):
            info["git_repo"] = "not_a_git_repo"
        
        return info
    
    def _analyze_file_structure(self) -> Dict[str, Any]:
        """Analyze project file structure."""
        structure = {
            "total_files": 0,
            "total_directories": 0,
            "file_types": {},
            "directory_structure": {}
        }
        
        for root, dirs, files in os.walk(self.project_root):
            # Skip .git directory
            if ".git" in root:
                continue
                
            rel_root = os.path.relpath(root, self.project_root)
            if rel_root == ".":
                rel_root = "root"
            
            structure["total_directories"] += len(dirs)
            structure["total_files"] += len(files)
            
            # Analyze file types
            for file in files:
                ext = Path(file).suffix.lower()
                if ext:
                    structure["file_types"][ext] = structure["file_types"].get(ext, 0) + 1
                else:
                    structure["file_types"]["no_extension"] = structure["file_types"].get("no_extension", 0) + 1
            
            # Store directory structure
            if rel_root not in structure["directory_structure"]:
                structure["directory_structure"][rel_root] = {
                    "files": files,
                    "subdirectories": dirs
                }
        
        return structure
    
    def _analyze_code_metrics(self) -> Dict[str, Any]:
        """Analyze RTL and code metrics."""
        metrics = {
            "rtl_files": 0,
            "rtl_lines": 0,
            "rtl_modules": 0,
            "testbench_files": 0,
            "testbench_lines": 0,
            "constraint_files": 0,
            "constraint_lines": 0,
            "script_files": 0,
            "script_lines": 0
        }
        
        # RTL analysis
        rtl_patterns = ["*.sv", "*.v", "*.vhdl", "*.vhd"]
        for pattern in rtl_patterns:
            for file_path in self.project_root.rglob(pattern):
                if ".git" not in str(file_path):
                    metrics["rtl_files"] += 1
                    lines = self._count_lines(file_path)
                    metrics["rtl_lines"] += lines
                    
                    # Count modules (basic heuristic)
                    if file_path.suffix in [".sv", ".v"]:
                        modules = self._count_modules(file_path)
                        metrics["rtl_modules"] += modules
        
        # Testbench analysis
        tb_patterns = ["tb_*.sv", "tb_*.v", "*_tb.sv", "*_tb.v", "test_*.py"]
        for pattern in tb_patterns:
            for file_path in self.project_root.rglob(pattern):
                if ".git" not in str(file_path):
                    metrics["testbench_files"] += 1
                    lines = self._count_lines(file_path)
                    metrics["testbench_lines"] += lines
        
        # Constraint files
        constraint_patterns = ["*.sdc", "*.xdc", "*.pcf", "*.tcl"]
        for pattern in constraint_patterns:
            for file_path in self.project_root.rglob(pattern):
                if ".git" not in str(file_path):
                    metrics["constraint_files"] += 1
                    lines = self._count_lines(file_path)
                    metrics["constraint_lines"] += lines
        
        # Script files
        script_patterns = ["*.py", "*.sh", "*.tcl", "*.make", "Makefile"]
        for pattern in script_patterns:
            for file_path in self.project_root.rglob(pattern):
                if ".git" not in str(file_path) and "scripts" in str(file_path):
                    metrics["script_files"] += 1
                    lines = self._count_lines(file_path)
                    metrics["script_lines"] += lines
        
        return metrics
    
    def _analyze_documentation(self) -> Dict[str, Any]:
        """Analyze documentation coverage."""
        docs = {
            "documentation_files": 0,
            "documentation_lines": 0,
            "readme_exists": False,
            "developer_guide_exists": False,
            "architecture_docs": 0,
            "api_docs": 0,
            "tutorial_docs": 0
        }
        
        # Check for key documentation files
        key_docs = [
            "README.md", "README_FIRST.md", "Developer_Guide.md",
            "docs/architecture.md", "docs/api.md", "docs/tutorial.md"
        ]
        
        for doc_file in key_docs:
            doc_path = self.project_root / doc_file
            if doc_path.exists():
                docs["documentation_files"] += 1
                lines = self._count_lines(doc_path)
                docs["documentation_lines"] += lines
                
                if doc_file == "README.md":
                    docs["readme_exists"] = True
                elif doc_file == "Developer_Guide.md":
                    docs["developer_guide_exists"] = True
                elif "architecture" in doc_file:
                    docs["architecture_docs"] += 1
                elif "api" in doc_file:
                    docs["api_docs"] += 1
                elif "tutorial" in doc_file:
                    docs["tutorial_docs"] += 1
        
        # Check docs directory
        docs_dir = self.project_root / "docs"
        if docs_dir.exists():
            for file_path in docs_dir.rglob("*.md"):
                if file_path.name not in ["README.md", "Developer_Guide.md"]:
                    docs["documentation_files"] += 1
                    lines = self._count_lines(file_path)
                    docs["documentation_lines"] += lines
        
        return docs
    
    def _analyze_test_coverage(self) -> Dict[str, Any]:
        """Analyze test coverage and testbench quality."""
        tests = {
            "test_files": 0,
            "test_lines": 0,
            "test_types": {
                "systemverilog": 0,
                "cocotb": 0,
                "uvm": 0,
                "formal": 0
            },
            "coverage_files": 0,
            "test_vectors": 0
        }
        
        # Testbench files
        test_patterns = {
            "systemverilog": ["tb_*.sv", "*_tb.sv"],
            "cocotb": ["test_*.py", "*_test.py"],
            "uvm": ["*_uvm.sv", "uvm_*.sv"],
            "formal": ["*_formal.sv", "formal_*.sv"]
        }
        
        for test_type, patterns in test_patterns.items():
            for pattern in patterns:
                for file_path in self.project_root.rglob(pattern):
                    if ".git" not in str(file_path):
                        tests["test_files"] += 1
                        tests["test_lines"] += self._count_lines(file_path)
                        tests["test_types"][test_type] += 1
        
        # Coverage files
        coverage_patterns = ["*.ucdb", "*.vdb", "coverage_*.html"]
        for pattern in coverage_patterns:
            for file_path in self.project_root.rglob(pattern):
                if ".git" not in str(file_path):
                    tests["coverage_files"] += 1
        
        # Test vectors
        test_vector_patterns = ["*.vec", "*.stim", "test_vectors/*"]
        for pattern in test_vector_patterns:
            for file_path in self.project_root.rglob(pattern):
                if ".git" not in str(file_path):
                    tests["test_vectors"] += 1
        
        return tests
    
    def _analyze_quality_metrics(self) -> Dict[str, Any]:
        """Analyze code quality metrics."""
        quality = {
            "linting_clean": False,
            "synthesis_clean": False,
            "simulation_passing": False,
            "coverage_goals_met": False,
            "documentation_complete": False,
            "metadata_complete": False
        }
        
        # Check for linting results
        lint_files = list(self.project_root.rglob("lint_*.log"))
        if lint_files:
            quality["linting_clean"] = True
        
        # Check for synthesis results
        synth_files = list(self.project_root.rglob("*synthesis*.log"))
        if synth_files:
            quality["synthesis_clean"] = True
        
        # Check for simulation results
        sim_files = list(self.project_root.rglob("*simulation*.log"))
        if sim_files:
            quality["simulation_passing"] = True
        
        # Check for coverage reports
        coverage_files = list(self.project_root.rglob("*coverage*.html"))
        if coverage_files:
            quality["coverage_goals_met"] = True
        
        # Check documentation completeness
        if (self.project_root / "README.md").exists() and \
           (self.project_root / "Developer_Guide.md").exists():
            quality["documentation_complete"] = True
        
        # Check metadata completeness
        metadata_files = list(self.project_root.rglob("vyges-metadata.json"))
        if metadata_files:
            quality["metadata_complete"] = True
        
        return quality
    
    def _analyze_metadata(self) -> Dict[str, Any]:
        """Analyze Vyges metadata completeness and quality."""
        metadata = {
            "metadata_exists": False,
            "required_fields": {},
            "optional_fields": {},
            "validation_status": "unknown",
            "quality_score": 0,
            "catalog_readiness": "unknown",
            "field_completeness": 0,
            "interface_quality": 0,
            "test_coverage_metadata": 0,
            "flow_configuration": 0,
            "documentation_metadata": 0,
            "ai_generation_ready": False,
            "issues": [],
            "recommendations": []
        }
        
        metadata_file = self.project_root / "vyges-metadata.json"
        if metadata_file.exists():
            metadata["metadata_exists"] = True
            
            try:
                with open(metadata_file, 'r') as f:
                    data = json.load(f)
                
                # Check required fields (Vyges schema v1.0.0)
                required_fields = ["name", "version", "description", "license", "target", "design_type", "maturity"]
                required_present = 0
                for field in required_fields:
                    field_present = field in data and data[field] is not None
                    metadata["required_fields"][field] = field_present
                    if field_present:
                        required_present += 1
                
                # Check optional fields
                optional_fields = ["parameters", "interfaces", "files", "test", "flows", "meta", "created", "updated"]
                optional_present = 0
                for field in optional_fields:
                    field_present = field in data and data[field] is not None
                    metadata["optional_fields"][field] = field_present
                    if field_present:
                        optional_present += 1
                
                # Calculate field completeness
                total_fields = len(required_fields) + len(optional_fields)
                metadata["field_completeness"] = (required_present + optional_present) / total_fields * 100
                
                # Interface quality analysis
                if "interfaces" in data and isinstance(data["interfaces"], list):
                    interface_count = len(data["interfaces"])
                    interface_quality = 0
                    for interface in data["interfaces"]:
                        if isinstance(interface, dict):
                            # Check for required interface fields
                            if "type" in interface and "signals" in interface:
                                interface_quality += 1
                            if "protocol" in interface:
                                interface_quality += 0.5
                    metadata["interface_quality"] = (interface_quality / interface_count * 100) if interface_count > 0 else 0
                
                # Test coverage metadata analysis
                if "test" in data and isinstance(data["test"], dict):
                    test_metadata = data["test"]
                    test_score = 0
                    if "coverage" in test_metadata:
                        test_score += 25
                    if "testbenches" in test_metadata:
                        test_score += 25
                    if "simulators" in test_metadata:
                        test_score += 25
                    if "status" in test_metadata:
                        test_score += 25
                    metadata["test_coverage_metadata"] = test_score
                
                # Flow configuration analysis
                if "flows" in data and isinstance(data["flows"], dict):
                    flow_score = 0
                    flow_data = data["flows"]
                    if "asic" in flow_data:
                        flow_score += 25
                    if "fpga" in flow_data:
                        flow_score += 25
                    if "synthesis" in flow_data.get("asic", {}):
                        flow_score += 25
                    if "synthesis" in flow_data.get("fpga", {}):
                        flow_score += 25
                    metadata["flow_configuration"] = flow_score
                
                # Documentation metadata analysis
                if "meta" in data and isinstance(data["meta"], dict):
                    meta_data = data["meta"]
                    doc_score = 0
                    if "generated_by" in meta_data:
                        doc_score += 20
                    if "schema" in meta_data:
                        doc_score += 20
                    if "template" in meta_data:
                        doc_score += 20
                    if "ai_generation" in meta_data:
                        doc_score += 40
                    metadata["documentation_metadata"] = doc_score
                
                # AI generation readiness
                if "meta" in data and isinstance(data["meta"], dict):
                    meta_data = data["meta"]
                    if "ai_generation" in meta_data and isinstance(meta_data["ai_generation"], dict):
                        ai_data = meta_data["ai_generation"]
                        if "mode" in ai_data and ai_data["mode"] in ["full_automation", "assisted"]:
                            metadata["ai_generation_ready"] = True
                
                # Calculate overall quality score
                quality_components = [
                    metadata["field_completeness"] * 0.3,  # 30% weight
                    metadata["interface_quality"] * 0.2,   # 20% weight
                    metadata["test_coverage_metadata"] * 0.2,  # 20% weight
                    metadata["flow_configuration"] * 0.15,     # 15% weight
                    metadata["documentation_metadata"] * 0.15  # 15% weight
                ]
                metadata["quality_score"] = sum(quality_components)
                
                # Determine catalog readiness
                if metadata["quality_score"] >= 80 and required_present == len(required_fields):
                    metadata["catalog_readiness"] = "ready"
                elif metadata["quality_score"] >= 60:
                    metadata["catalog_readiness"] = "needs_improvement"
                else:
                    metadata["catalog_readiness"] = "not_ready"
                
                # Basic validation
                if required_present == len(required_fields):
                    metadata["validation_status"] = "valid"
                elif required_present >= len(required_fields) * 0.8:
                    metadata["validation_status"] = "mostly_valid"
                else:
                    metadata["validation_status"] = "incomplete"
                
                # Generate issues and recommendations
                if required_present < len(required_fields):
                    missing_fields = [field for field in required_fields if not metadata["required_fields"][field]]
                    metadata["issues"].append(f"Missing required fields: {', '.join(missing_fields)}")
                
                if metadata["interface_quality"] < 50:
                    metadata["recommendations"].append("Improve interface definitions with proper type and signal specifications")
                
                if metadata["test_coverage_metadata"] < 50:
                    metadata["recommendations"].append("Add comprehensive test metadata including coverage, testbenches, and simulators")
                
                if metadata["flow_configuration"] < 50:
                    metadata["recommendations"].append("Configure synthesis and implementation flows for target platforms")
                
                if not metadata["ai_generation_ready"]:
                    metadata["recommendations"].append("Add AI generation metadata for automated development support")
                    
            except (json.JSONDecodeError, KeyError) as e:
                metadata["validation_status"] = "invalid"
                metadata["issues"].append(f"JSON parsing error: {str(e)}")
        
        return metadata
    
    def _detailed_analysis(self) -> Dict[str, Any]:
        """Perform detailed analysis."""
        detailed = {
            "largest_files": self._find_largest_files(),
            "complexity_analysis": self._analyze_complexity(),
            "dependencies": self._analyze_dependencies()
        }
        return detailed
    
    def _find_largest_files(self) -> List[Dict[str, Any]]:
        """Find the largest files in the project."""
        files = []
        for file_path in self.project_root.rglob("*"):
            if file_path.is_file() and ".git" not in str(file_path):
                try:
                    size = file_path.stat().st_size
                    lines = self._count_lines(file_path)
                    files.append({
                        "path": str(file_path.relative_to(self.project_root)),
                        "size_bytes": size,
                        "lines": lines
                    })
                except (OSError, UnicodeDecodeError):
                    continue
        
        # Sort by lines and return top 10
        files.sort(key=lambda x: x["lines"], reverse=True)
        return files[:10]
    
    def _analyze_complexity(self) -> Dict[str, Any]:
        """Analyze code complexity."""
        complexity = {
            "avg_module_size": 0,
            "largest_module": "",
            "module_count": 0
        }
        
        modules = []
        for file_path in self.project_root.rglob("*.sv"):
            if ".git" not in str(file_path):
                lines = self._count_lines(file_path)
                modules.append({
                    "file": str(file_path.relative_to(self.project_root)),
                    "lines": lines
                })
        
        if modules:
            complexity["module_count"] = len(modules)
            complexity["avg_module_size"] = sum(m["lines"] for m in modules) / len(modules)
            largest = max(modules, key=lambda x: x["lines"])
            complexity["largest_module"] = largest["file"]
        
        return complexity
    
    def _analyze_dependencies(self) -> Dict[str, Any]:
        """Analyze project dependencies."""
        dependencies = {
            "external_tools": [],
            "libraries": [],
            "frameworks": []
        }
        
        # Check for common EDA tools
        tool_patterns = {
            "external_tools": ["vivado", "quartus", "modelsim", "verilator", "icarus"],
            "libraries": ["uvm", "cocotb", "pytest", "numpy"],
            "frameworks": ["openlane", "yosys", "nextpnr"]
        }
        
        for dep_type, patterns in tool_patterns.items():
            for pattern in patterns:
                # Check in various files
                for file_path in self.project_root.rglob("*"):
                    if file_path.is_file() and file_path.suffix in [".py", ".sh", ".tcl", ".make", ".md"]:
                        try:
                            with open(file_path, 'r', encoding='utf-8') as f:
                                content = f.read().lower()
                                if pattern in content:
                                    dependencies[dep_type].append(pattern)
                                    break
                        except (UnicodeDecodeError, OSError):
                            continue
        
        # Remove duplicates
        for dep_type in dependencies:
            dependencies[dep_type] = list(set(dependencies[dep_type]))
        
        return dependencies
    
    def _generate_summary(self) -> Dict[str, Any]:
        """Generate a summary of all KPIs."""
        summary = {
            "overall_score": 0,
            "strengths": [],
            "areas_for_improvement": [],
            "recommendations": []
        }
        
        # Calculate overall score based on various metrics
        score = 0
        max_score = 100
        
        # Code metrics (30 points)
        code_metrics = self.kpis.get("code_metrics", {})
        if code_metrics.get("rtl_files", 0) > 0:
            score += 10
        if code_metrics.get("testbench_files", 0) > 0:
            score += 10
        if code_metrics.get("rtl_lines", 0) > 100:
            score += 10
        
        # Documentation (25 points)
        doc_metrics = self.kpis.get("documentation_metrics", {})
        if doc_metrics.get("readme_exists", False):
            score += 10
        if doc_metrics.get("developer_guide_exists", False):
            score += 10
        if doc_metrics.get("documentation_lines", 0) > 500:
            score += 5
        
        # Test coverage (25 points)
        test_metrics = self.kpis.get("test_metrics", {})
        if test_metrics.get("test_files", 0) > 0:
            score += 15
        if test_metrics.get("coverage_files", 0) > 0:
            score += 10
        
        # Quality (20 points)
        quality_metrics = self.kpis.get("quality_metrics", {})
        metadata_analysis = self.kpis.get("metadata_analysis", {})
        
        if quality_metrics.get("metadata_complete", False):
            score += 5
        if quality_metrics.get("documentation_complete", False):
            score += 5
        
        # Vyges metadata quality (10 points)
        if metadata_analysis.get("metadata_exists", False):
            metadata_score = metadata_analysis.get("quality_score", 0)
            score += (metadata_score / 100) * 10
        
        summary["overall_score"] = min(score, max_score)
        
        # Generate strengths and areas for improvement
        if code_metrics.get("rtl_files", 0) > 0:
            summary["strengths"].append("RTL implementation present")
        if doc_metrics.get("readme_exists", False):
            summary["strengths"].append("README documentation exists")
        if test_metrics.get("test_files", 0) > 0:
            summary["strengths"].append("Test coverage implemented")
        
        # Metadata quality strengths
        if metadata_analysis.get("metadata_exists", False):
            if metadata_analysis.get("quality_score", 0) >= 80:
                summary["strengths"].append("High-quality Vyges metadata")
            if metadata_analysis.get("catalog_readiness") == "ready":
                summary["strengths"].append("Catalog-ready metadata")
            if metadata_analysis.get("ai_generation_ready", False):
                summary["strengths"].append("AI generation ready")
        
        if code_metrics.get("rtl_files", 0) == 0:
            summary["areas_for_improvement"].append("No RTL implementation found")
        if not doc_metrics.get("readme_exists", False):
            summary["areas_for_improvement"].append("Missing README documentation")
        if test_metrics.get("test_files", 0) == 0:
            summary["areas_for_improvement"].append("No test coverage implemented")
        
        # Metadata quality areas for improvement
        if not metadata_analysis.get("metadata_exists", False):
            summary["areas_for_improvement"].append("Missing vyges-metadata.json")
        elif metadata_analysis.get("quality_score", 0) < 60:
            summary["areas_for_improvement"].append("Low-quality Vyges metadata")
        if metadata_analysis.get("catalog_readiness") == "not_ready":
            summary["areas_for_improvement"].append("Metadata not ready for catalog publication")
        
        # Generate recommendations
        if summary["overall_score"] < 50:
            summary["recommendations"].append("Focus on basic project structure and documentation")
        elif summary["overall_score"] < 75:
            summary["recommendations"].append("Enhance test coverage and quality metrics")
        else:
            summary["recommendations"].append("Consider advanced features like formal verification")
        
        return summary
    
    def _count_lines(self, file_path: Path) -> int:
        """Count lines in a file."""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                return len(f.readlines())
        except (UnicodeDecodeError, OSError):
            return 0
    
    def _count_modules(self, file_path: Path) -> int:
        """Count modules in a SystemVerilog/Verilog file."""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                # Simple heuristic: count "module" keywords
                return content.count("module ")
        except (UnicodeDecodeError, OSError):
            return 0
    
    def print_report(self, output_format: str = "text"):
        """Print the KPI report in the specified format."""
        if output_format == "json":
            print(json.dumps(self.kpis, indent=2))
        elif output_format == "csv":
            self._print_csv_report()
        else:
            self._print_text_report()
    
    def _print_text_report(self):
        """Print a formatted text report."""
        print("=" * 60)
        print("VYGES CODE KPIs ANALYSIS REPORT")
        print("=" * 60)
        
        # Project Info
        project_info = self.kpis.get("project_info", {})
        print(f"\n📁 PROJECT: {project_info.get('project_name', 'Unknown')}")
        print(f"📅 Analysis Date: {project_info.get('analysis_date', 'Unknown')}")
        print(f"🔗 Git Status: {project_info.get('git_status', 'Unknown')}")
        
        # Summary
        summary = self.kpis.get("summary", {})
        print(f"\n📊 OVERALL SCORE: {summary.get('overall_score', 0)}/100")
        
        # Code Metrics
        code_metrics = self.kpis.get("code_metrics", {})
        print(f"\n💻 CODE METRICS:")
        print(f"   RTL Files: {code_metrics.get('rtl_files', 0)}")
        print(f"   RTL Lines: {code_metrics.get('rtl_lines', 0)}")
        print(f"   RTL Modules: {code_metrics.get('rtl_modules', 0)}")
        print(f"   Testbench Files: {code_metrics.get('testbench_files', 0)}")
        print(f"   Testbench Lines: {code_metrics.get('testbench_lines', 0)}")
        
        # Documentation
        doc_metrics = self.kpis.get("documentation_metrics", {})
        print(f"\n📚 DOCUMENTATION:")
        print(f"   Documentation Files: {doc_metrics.get('documentation_files', 0)}")
        print(f"   Documentation Lines: {doc_metrics.get('documentation_lines', 0)}")
        print(f"   README Exists: {'✅' if doc_metrics.get('readme_exists', False) else '❌'}")
        print(f"   Developer Guide: {'✅' if doc_metrics.get('developer_guide_exists', False) else '❌'}")
        
        # Test Coverage
        test_metrics = self.kpis.get("test_metrics", {})
        print(f"\n🧪 TEST COVERAGE:")
        print(f"   Test Files: {test_metrics.get('test_files', 0)}")
        print(f"   Test Lines: {test_metrics.get('test_lines', 0)}")
        print(f"   Coverage Files: {test_metrics.get('coverage_files', 0)}")
        
        # Quality
        quality_metrics = self.kpis.get("quality_metrics", {})
        print(f"\n✅ QUALITY METRICS:")
        print(f"   Metadata Complete: {'✅' if quality_metrics.get('metadata_complete', False) else '❌'}")
        print(f"   Documentation Complete: {'✅' if quality_metrics.get('documentation_complete', False) else '❌'}")
        print(f"   Linting Clean: {'✅' if quality_metrics.get('linting_clean', False) else '❌'}")
        print(f"   Synthesis Clean: {'✅' if quality_metrics.get('synthesis_clean', False) else '❌'}")
        
        # Vyges Metadata Analysis
        metadata_analysis = self.kpis.get("metadata_analysis", {})
        if metadata_analysis.get("metadata_exists", False):
            print(f"\n📋 VYGES METADATA ANALYSIS:")
            print(f"   Quality Score: {metadata_analysis.get('quality_score', 0):.1f}/100")
            print(f"   Catalog Readiness: {metadata_analysis.get('catalog_readiness', 'unknown').upper()}")
            print(f"   Field Completeness: {metadata_analysis.get('field_completeness', 0):.1f}%")
            print(f"   Interface Quality: {metadata_analysis.get('interface_quality', 0):.1f}%")
            print(f"   Test Coverage Metadata: {metadata_analysis.get('test_coverage_metadata', 0):.1f}%")
            print(f"   Flow Configuration: {metadata_analysis.get('flow_configuration', 0):.1f}%")
            print(f"   AI Generation Ready: {'✅' if metadata_analysis.get('ai_generation_ready', False) else '❌'}")
            
            # Show metadata issues if any
            if metadata_analysis.get("issues"):
                print(f"\n⚠️  METADATA ISSUES:")
                for issue in metadata_analysis["issues"]:
                    print(f"   ⚠️  {issue}")
            
            # Show metadata recommendations if any
            if metadata_analysis.get("recommendations"):
                print(f"\n💡 METADATA RECOMMENDATIONS:")
                for rec in metadata_analysis["recommendations"]:
                    print(f"   💡 {rec}")
        else:
            print(f"\n📋 VYGES METADATA: ❌ No vyges-metadata.json found")
        
        # Strengths and Areas for Improvement
        if summary.get("strengths"):
            print(f"\n💪 STRENGTHS:")
            for strength in summary["strengths"]:
                print(f"   ✅ {strength}")
        
        if summary.get("areas_for_improvement"):
            print(f"\n🔧 AREAS FOR IMPROVEMENT:")
            for area in summary["areas_for_improvement"]:
                print(f"   ⚠️  {area}")
        
        if summary.get("recommendations"):
            print(f"\n💡 RECOMMENDATIONS:")
            for rec in summary["recommendations"]:
                print(f"   💡 {rec}")
        
        print("\n" + "=" * 60)
    
    def _print_csv_report(self):
        """Print a CSV report."""
        # This would generate a CSV format report
        # For brevity, just print the summary as CSV
        summary = self.kpis.get("summary", {})
        print("metric,value")
        print(f"overall_score,{summary.get('overall_score', 0)}")
        
        code_metrics = self.kpis.get("code_metrics", {})
        print(f"rtl_files,{code_metrics.get('rtl_files', 0)}")
        print(f"rtl_lines,{code_metrics.get('rtl_lines', 0)}")
        print(f"testbench_files,{code_metrics.get('testbench_files', 0)}")
        
        doc_metrics = self.kpis.get("documentation_metrics", {})
        print(f"documentation_files,{doc_metrics.get('documentation_files', 0)}")
        print(f"documentation_lines,{doc_metrics.get('documentation_lines', 0)}")


def main():
    """Main function."""
    parser = argparse.ArgumentParser(description="Analyze Vyges IP project KPIs")
    parser.add_argument("--project-root", default=".", help="Project root directory")
    parser.add_argument("--detailed", action="store_true", help="Include detailed analysis")
    parser.add_argument("--output", choices=["text", "json", "csv"], default="text", 
                       help="Output format")
    
    args = parser.parse_args()
    
    # Analyze project
    analyzer = VygesCodeKPIs(args.project_root)
    kpis = analyzer.analyze_project(detailed=args.detailed)
    
    # Print report
    analyzer.print_report(args.output)


if __name__ == "__main__":
    main() 