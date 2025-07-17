# Vyges IP Template Scripts

This directory contains utility scripts for Vyges IP development.

## Code KPIs Analysis Script

The `code_kpis.py` script analyzes code metrics and KPIs for Vyges IP projects.

### Features

- **Code Metrics**: Lines of RTL, testbench, and constraint files
- **Documentation Analysis**: Coverage of README, Developer Guide, and other docs
- **Test Coverage**: Analysis of test files, coverage reports, and test vectors
- **Quality Metrics**: Linting, synthesis, and simulation status
- **Metadata Analysis**: Comprehensive Vyges metadata quality assessment including:
  - Field completeness and validation
  - Interface quality analysis
  - Test coverage metadata evaluation
  - Flow configuration assessment
  - AI generation readiness
  - Catalog publication readiness
- **Project Structure**: File organization and directory analysis

### Usage

```bash
# Basic analysis
python scripts/code_kpis.py

# Detailed analysis with file breakdowns
python scripts/code_kpis.py --detailed

# Output in different formats
python scripts/code_kpis.py --output json
python scripts/code_kpis.py --output csv
python scripts/code_kpis.py --output text

# Analyze a specific project directory
python scripts/code_kpis.py --project-root /path/to/project
```

### Output

The script provides:

1. **Overall Score**: 0-100 score based on project completeness
2. **Code Metrics**: RTL files, lines, modules, testbenches
3. **Documentation**: File counts, README status, guide coverage
4. **Test Coverage**: Test files, coverage reports, test types
5. **Quality Metrics**: Linting, synthesis, simulation status
6. **Vyges Metadata Analysis**: Quality score, catalog readiness, AI generation readiness
7. **Strengths**: What the project does well
8. **Areas for Improvement**: What needs work
9. **Recommendations**: Specific next steps

### Example Output

```
============================================================
VYGES CODE KPIs ANALYSIS REPORT
============================================================

📁 PROJECT: uart-controller
�� Analysis Date: 2025-07-17T03:03:25Z
🔗 Git Status: clean

📊 OVERALL SCORE: 85/100

💻 CODE METRICS:
   RTL Files: 3
   RTL Lines: 450
   RTL Modules: 3
   Testbench Files: 2
   Testbench Lines: 320

📚 DOCUMENTATION:
   Documentation Files: 5
   Documentation Lines: 1200
   README Exists: ✅
   Developer Guide: ✅

🧪 TEST COVERAGE:
   Test Files: 2
   Test Lines: 320
   Coverage Files: 1

✅ QUALITY METRICS:
   Metadata Complete: ✅
   Documentation Complete: ✅
   Linting Clean: ✅
   Synthesis Clean: ✅

📋 VYGES METADATA ANALYSIS:
   Quality Score: 85.5/100
   Catalog Readiness: READY
   Field Completeness: 92.3%
   Interface Quality: 90.0%
   Test Coverage Metadata: 100.0%
   Flow Configuration: 75.0%
   AI Generation Ready: ✅

💪 STRENGTHS:
   ✅ RTL implementation present
   ✅ README documentation exists
   ✅ Test coverage implemented

💡 RECOMMENDATIONS:
   💡 Consider advanced features like formal verification
============================================================
```

### Integration

This script can be integrated into:

- **CI/CD pipelines** for automated quality checks
- **Development workflows** for progress tracking
- **Project reviews** for completeness assessment
- **Catalog validation** for publication readiness

### Requirements

- Python 3.7+
- No external dependencies (uses standard library only)
- Git repository (optional, for git status analysis) 