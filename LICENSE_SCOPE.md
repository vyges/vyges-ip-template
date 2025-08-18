# License Scope and Usage Guidelines

## Overview

The `vyges-ip-template` uses the Apache License, Version 2.0 for licensing. However, it's important to understand the scope of what this license covers and what it doesn't.

**Important:** All non-Apache-2.0 components are provided under a limited-use, non-commercial license solely for use within this repository's IP development framework.

## What the Apache-2.0 License Covers

The Apache-2.0 license applies to **hardware IP content** that you create using this template:

### ✅ Licensed Content
- **RTL Files**: SystemVerilog, Verilog, VHDL source code
- **Documentation**: IP specifications, design documents, user guides
- **Testbenches**: Verification code, test vectors, simulation scripts
- **Constraints**: Timing constraints, synthesis constraints, physical constraints
- **Configuration**: IP configuration files, parameter definitions
- **Generated Content**: Synthesis reports, simulation results, analysis outputs
- **Standardized Reports**: Automated build process reports (test harness reports, synthesis reports, verification reports)
- **Integration Examples**: Example integration code and usage demonstrations

### Example Licensed Files
```
rtl/
├── your_ip_top.sv          # ✅ Licensed (your RTL)
├── your_ip_core.sv         # ✅ Licensed (your RTL)
└── your_ip_pkg.sv          # ✅ Licensed (your RTL)

docs/
├── your_ip_spec.md         # ✅ Licensed (your documentation)
└── your_ip_arch.md         # ✅ Licensed (your documentation)

tb/
├── your_ip_tb.sv           # ✅ Licensed (your testbench)
└── test_vectors/           # ✅ Licensed (your test data)

reports/
├── test_harness_report.md  # ✅ Licensed (generated from your IP)
├── synthesis_report.txt    # ✅ Licensed (generated from your IP)
└── verification_report.md  # ✅ Licensed (generated from your IP)
```

## Build Process and Report Generation

### Standardized Report Generation

The `vyges-ip-template` includes automated build processes that generate standardized reports:

#### ✅ Licensed Generated Reports
- **Test Harness Reports**: Automated test coverage and verification reports
- **Synthesis Reports**: Tool-generated synthesis results and timing analysis
- **Verification Reports**: Formal verification and simulation results
- **Coverage Reports**: Code coverage and functional coverage analysis
- **Documentation Reports**: Auto-generated documentation and API references

#### ❌ Not Licensed (Template Framework)
- **Report Templates**: Standardized report formats and templates
- **Build Scripts**: Automated report generation scripts and workflows
- **Report Configuration**: Report formatting and output configuration
- **CI/CD Integration**: Automated report generation in CI/CD pipelines

### Report Generation Usage

**✅ What You CAN Do:**
- Use generated reports in your IP documentation
- Distribute reports as part of your IP deliverables
- Customize report content for your specific IP
- Include reports in commercial products

**❌ What You CANNOT Do:**
- Redistribute the report generation framework
- Extract and reuse report templates commercially
- Modify and distribute the automated build scripts
- Include report generation tools in derivative works

## What the Apache-2.0 License Does NOT Cover

The template structure, build processes, and tooling are provided as-is:

### ❌ Not Licensed Under Apache-2.0
- **Template Structure**: Directory organization and file naming conventions
- **Build Processes**: Makefiles, build scripts, CI/CD workflows
- **Tool Integration**: Tool installation scripts and configuration
- **Template Metadata**: Template JSON files and configuration templates
- **Vyges CLI**: The Vyges command-line interface and related tools
- **Documentation Templates**: Template documentation structure and examples
- **AI Context and Processing Engine**:
  - `.vyges-ai-context.json` - AI development context and prompts
  - `.vyges-ai-context.sha256` - AI context integrity verification
  - `.copilot-chat-context.md` - GitHub Copilot integration context
  - `.cursorrules` - Cursor editor AI rules and conventions
  - `update_ai_context.sh` - AI context update and processing scripts
  - AI-generated code patterns and development workflows
  - AI prompt engineering and context management systems
  - AI-assisted development methodologies and best practices

### Example Non-Licensed Files
```
Makefile                    # ❌ Template build process
.github/workflows/          # ❌ CI/CD template
scripts/                    # ❌ Template tooling scripts
vyges-metadata.template.json # ❌ Template metadata structure
Developer_Guide.md          # ❌ Template documentation structure
.vyges-ai-context.json      # ❌ AI context and prompts
.copilot-chat-context.md    # ❌ GitHub Copilot integration
.cursorrules                # ❌ Cursor editor AI rules
```

## AI Components and Licensing

### AI Context and Processing Engine

The `vyges-ip-template` includes sophisticated AI context and processing components that are **not licensed under Apache-2.0**:

#### AI Context Files
- **`.vyges-ai-context.json`**: Comprehensive AI development context with conventions, patterns, and prompts
- **`.copilot-chat-context.md`**: GitHub Copilot integration context and workflows
- **`.cursorrules`**: Cursor editor AI rules and development conventions

#### AI Processing Components
- **AI Development Workflows**: AI-assisted development methodologies
- **Prompt Engineering**: Context management and prompt optimization
- **Code Generation Patterns**: AI-generated code templates and patterns

### AI Component Usage

**✅ What You Can Do:**
- Use the AI context files to enhance your development experience
- Leverage AI-assisted development workflows in your projects
- Reference AI-generated patterns and conventions in your code
- Use the AI context with compatible AI tools (Cursor, Copilot, etc.)

**❌ What You Cannot Do:**
- Redistribute the AI context files under Apache-2.0
- Modify and distribute the AI processing scripts
- Extract and reuse AI prompts and context patterns commercially
- Include AI context files in derivative works without permission

### AI Component Attribution

When using AI-assisted development features:
- The AI context is provided as-is for enhanced development experience
- AI-generated code patterns are suggestions, not licensed content
- AI context files remain proprietary Vyges components
- Your hardware IP content remains your own and can be licensed as you choose

## Proprietary Components and Usage Rights

### AI Context and Processing Engine

The following components are **proprietary Vyges components** provided under a **limited-use, non-commercial license**:

#### AI Context Files
- **`.vyges-ai-context.json`**: AI development context and prompts
- **`.copilot-chat-context.md`**: GitHub Copilot integration context
- **`.cursorrules`**: Cursor editor AI rules and conventions
- **`update_ai_context.sh`**: AI context update and processing scripts

#### Usage Rights for Proprietary Components

**✅ What You CAN Do:**
- Use these files within this IP development template
- Leverage the AI context for your hardware IP development
- Reference AI-generated patterns and conventions
- Use the AI context with compatible AI tools (Cursor, Copilot, etc.)

**❌ What You CANNOT Do:**
- Redistribute these files under Apache-2.0 or any other license
- Modify and distribute the AI context files
- Extract and reuse AI prompts and context patterns commercially
- Include these files in derivative works or forked repositories
- Use these files outside of this IP development framework

**📋 Licensing Terms:**
- **License Type**: Limited-use, non-commercial
- **Scope**: Use only within this repository's IP development framework
- **Redistribution**: Not permitted
- **Commercial Use**: Not permitted
- **Modification**: Not permitted for redistribution

### Template Structure and Build Processes

The following template components are also **proprietary Vyges components**:

- **Directory Structure**: Template organization and file naming conventions
- **Build Processes**: Makefiles, build scripts, CI/CD workflows
- **Tool Integration**: Tool installation scripts and configuration
- **Template Metadata**: Template JSON files and configuration templates

**Usage Rights:**
- Use within this IP development framework
- Cannot redistribute or modify for distribution
- Cannot include in derivative works

## Practical Implications

### For IP Developers
- You can freely license your hardware IP content under Apache-2.0
- You can modify and distribute your RTL, documentation, and testbenches
- You can use your IP in commercial products
- You can create derivative works of your IP content

### For Template Users
- The template provides a framework for IP development
- You can use the template structure to organize your IP
- The build processes and tooling are provided as-is
- You're not required to license the template structure itself

### For Commercial Use
- Your hardware IP content can be used commercially under Apache-2.0
- You can sell products incorporating your IP
- You can license your IP to others
- You must include the Apache-2.0 license text and attribution

## Attribution Requirements

When using Apache-2.0 licensed content, you must:

1. **Include the License**: Copy the Apache-2.0 license text
2. **State Changes**: Note any modifications you made
3. **Preserve Notices**: Keep copyright and license notices
4. **Include NOTICE**: Include the NOTICE file if present

## Example Attribution

```verilog
// Copyright (c) 2025 Your Name
// Licensed under the Apache License, Version 2.0
// See LICENSE file for details
module your_ip_top (
    // Your IP implementation
);
```

## Questions and Clarifications

If you have questions about licensing scope:

1. **Hardware IP Content**: Generally covered by Apache-2.0
2. **Template Structure**: Generally not covered by Apache-2.0
3. **Build Processes**: Generally not covered by Apache-2.0
4. **Tool Integration**: Generally not covered by Apache-2.0

When in doubt, focus on whether the content is your **hardware IP** (licensed) versus the **template framework** (not licensed).

## Forking and Repository Usage

### Can I Fork This Repository?

**✅ Yes, you can fork this repository**, but with important restrictions:

**What You CAN Do:**
- Fork the repository for your own IP development
- Use the template structure for organizing your IP projects
- Leverage AI context and tools for your hardware development
- Create and modify hardware IP content within the template

**What You CANNOT Do:**
- Redistribute the proprietary components (AI context, template structure)
- Use proprietary components outside of this IP development framework
- Include proprietary components in derivative works
- Commercialize or redistribute the template structure

### Repository Usage Guidelines

**For Personal/Educational Use:**
- ✅ Fork and use the template
- ✅ Leverage AI context for learning
- ✅ Create your own hardware IP content
- ✅ Use pre-configured build processes and workflows

**For Commercial/Redistribution:**
- ❌ Cannot redistribute proprietary components
- ❌ Cannot commercialize the template structure
- ❌ Cannot include AI context in commercial products
- ❌ Cannot modify and redistribute template configuration

**For Open Source Projects:**
- ✅ Can use the template for IP development
- ✅ Can create open source hardware IP within the template
- ❌ Cannot include proprietary components in your open source project
- ❌ Cannot redistribute the template structure

## Legal Disclaimer

This document provides guidance but is not legal advice. For specific legal questions about licensing, consult with a qualified attorney familiar with open source licensing and hardware IP.

---

**Note**: This template is designed to help you create properly licensed hardware IP. The Apache-2.0 license is widely used in the open hardware community and provides good protection while allowing commercial use.