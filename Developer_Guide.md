# Vyges IP Template — Comprehensive Developer Guide

## Overview

The Vyges IP Template is a production-ready, open-source starting point for developing reusable SystemVerilog functional IP blocks for ASIC and FPGA projects. It is designed to maximize developer productivity by combining a minimal, extensible structure with powerful CLI and AI-driven automation.

This comprehensive guide covers:
- Repository setup and naming conventions (one repository = one functional IP)
- Step-by-step and fully automated (GOD-mode) development flows
- Design, pinout, and interface documentation
- Example metadata, RTL, testbenches, and flow configurations
- Validation, CI/CD, and catalog publication
- Code quality analysis and KPIs assessment
- Best practices for quality, maintainability, and catalog readiness

Whether you are a new user looking for a quickstart or an advanced developer seeking full automation, this guide will help you “Build IP, Not Boilerplate.”

## Prerequisites
- Git installed
- Python 3.8+ (for cocotb testing)
- Verilator (for simulation)
- Vyges CLI tool (for project initialization and metadata generation)
- Basic knowledge of SystemVerilog
- AI-enabled editor (Cursor, VSCode with Copilot, or similar)

## AI-Assisted Development Mode

The Vyges IP Template includes comprehensive AI context to accelerate development across multiple AI-enabled environments. This section explains how to leverage AI assistance in your preferred development environment.

### AI Context Structure

The template includes several AI context files designed for different environments:

- **`.vyges-ai-context.json`** — Comprehensive development context with conventions, patterns, and AI prompts
- **`.cursorrules`** — Cursor-specific development rules and conventions
- **`.copilot-chat-context.md`** — GitHub Copilot chat context for VSCode
- **`Developer_Guide.md`** — This comprehensive guide with AI prompts and workflows

### Using AI Mode in Different Environments

#### 1. Cursor Editor
- Open the repository in Cursor. Cursor will automatically detect `.cursorrules` and load Vyges conventions.
- The AI context from `.vyges-ai-context.json` is available for reference.
- Use prompts like:
  - "Create a SystemVerilog UART transmitter module following Vyges conventions"
  - "What vyges expand command should I use to add FPGA support to this project?"
  - "Create a cocotb testbench for the PWM controller following Vyges patterns"
  - "Check if this module follows Vyges conventions and suggest improvements"
  - "Generate README.md following Vyges documentation structure"
- Best practices:
  - Reference `.vyges-ai-context.json` explicitly in complex prompts
  - Use the specific AI prompts listed in the context file
  - Verify generated code follows Vyges naming conventions
  - Ask for validation and improvement suggestions

#### 2. VSCode with GitHub Copilot
- Install GitHub Copilot extension in VSCode.
- Open the repository and reference `.copilot-chat-context.md` for Vyges conventions.
- Use Copilot Chat for guided development:
  - "Generate SystemVerilog module following Vyges conventions"
  - "What CLI commands should I use to initialize this UART controller project?"
  - "Create README.md following Vyges documentation structure"
  - "Validate this code for Vyges Catalog readiness"
- Best practices:
  - Use Copilot Chat for complex queries
  - Reference the context file in your prompts
  - Verify generated code matches Vyges patterns
  - Ask for explanations of generated code

#### 3. GitHub Copilot (Standalone)
- Ensure you have GitHub Copilot access.
- Open the repository in any supported editor.
- Reference `.vyges-ai-context.json` for conventions.
- Use comments to guide generation:
  - `// Create UART controller following Vyges conventions`
- Best practices:
  - Use descriptive comments to guide Copilot
  - Accept suggestions that follow Vyges patterns
  - Manually verify generated code quality

#### 4. Windsurf (JetBrains AI Assistant)
- Install Windsurf in your JetBrains IDE.
- Open the repository and reference `.vyges-ai-context.json` for context.
- Use prompts like:
  - "Generate SystemVerilog module following Vyges conventions from .vyges-ai-context.json"
  - "Analyze this project structure and suggest Vyges compliance improvements"
  - "Refactor this module to follow Vyges naming and structure conventions"
- Best practices:
  - Explicitly reference the AI context file
  - Use Windsurf's project-aware features
  - Leverage JetBrains IDE integration for better code generation

#### 5. Custom LLM Integration
- Copy relevant sections from `.vyges-ai-context.json`.
- Include Vyges conventions in your LLM system prompt.
- Use the AI prompts from the context file.
- Example system prompt:
  - "You are an AI assistant for Vyges IP development. Follow these conventions: Use SystemVerilog for RTL, snake_case naming, required module headers, place RTL in rtl/, testbenches in tb/, use vyges CLI commands, follow metadata-driven generation from vyges-metadata.json."
- Best practices:
  - Include complete context in system prompts
  - Use specific AI prompts from the context file
  - Validate generated code against Vyges conventions
  - Iterate and improve prompts based on results

### AI-Assisted Development Workflow

1. **Project Initialization**
   - Use CLI for initial setup: `vyges init --interactive`
   - Use AI to customize and expand: "Customize this project for a UART controller with APB interface"
2. **RTL Development**
   - Generate RTL with AI assistance: "Create UART controller RTL following Vyges conventions"
   - Add features: "Add FIFO support to the UART controller"
3. **Testbench Development**
   - Generate testbenches: "Create SystemVerilog testbench for UART controller"
   - Advanced: "Generate cocotb testbench with coverage and assertions"
4. **Documentation Generation**
   - Generate documentation: "Generate README.md following Vyges documentation structure"
   - Architecture: "Create architecture documentation for UART controller"
   - Pinout: "Generate pinout table from interface definitions"
5. **Validation and Quality Assurance**
   - Use AI for validation: "Check this code for Vyges Catalog readiness"
   - Improve: "Suggest improvements to raise catalog quality score"
   - Interface: "Validate interface compliance with Vyges standards"

### AI Context File Details

- `.vyges-ai-context.json` includes:
  - Code generation rules (RTL, testbench, documentation)
  - Project structure and naming conventions
  - CLI integration and workflow suggestions
  - Validation rules and catalog readiness criteria
  - Specific AI prompts for common tasks

### Best Practices for AI-Assisted Development
- Always reference the Vyges context in your prompts
- Use specific AI prompts from `.vyges-ai-context.json`
- Verify generated code follows Vyges conventions
- Start with CLI initialization, then use AI for customization and expansion
- Use AI for validation and improvement suggestions
- Test AI-generated components thoroughly
- Refine AI prompts based on results
- Adapt prompts for your specific AI environment

This AI-assisted development approach transforms the Vyges IP Template from a structural skeleton into an intelligent development environment that guides developers through every aspect of IP creation while maintaining consistency and quality standards.

## Step 1: Repository Creation and Setup

### 🚀 Quick Start (Recommended Workflow)

**For most users, follow this simple 3-step process:**

1. **Create Repository from Template**
   - Go to [https://github.com/vyges/vyges-ip-template/generate](https://github.com/vyges/vyges-ip-template/generate)
   - Click "Use this template"
   - Name your repository (e.g., `uart-controller`)
   - Create repository

2. **Clone and Start Development**
   ```bash
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
   ```

3. **Begin Development**
   ```bash
   # Your repository is ready for development
   # Start with Step 2: Design Your IP Block
   ```

**✅ This approach avoids all remote configuration issues!**

### 1.1 Create Repository from Template

1. Navigate to [https://github.com/vyges/vyges-ip-template/generate](https://github.com/vyges/vyges-ip-template/generate)
2. Click "Use this template"
3. Fill in repository details:
   - Repository name: `uart-controller` (e.g., `uart-controller` or `pwm-generator`)
   - Description: `UART Controller IP block with configurable baud rate and FIFO support`
   - Make it Public or Private as preferred
4. Click "Create repository from template"

**Note:** The repository name follows the standard GitHub naming format and represents one functional IP:

- Organization: `{orgname}/{repo-name}` (e.g., `vyges/uart-controller`)
- Personal account: `{username}/{repo-name}` (e.g., `janedoe/uart-controller`)
- Each repository represents one functional IP in the catalog (e.g., `uart-controller` contains UART Master, FIFO, and other components as one functional unit)

### 1.2 Create New Repository and Clone Template

**Step 1: Create New Repository on GitHub**
1. Go to [https://github.com/vyges/vyges-ip-template](https://github.com/vyges/vyges-ip-template)
2. Click "Use this template" button
3. Fill in repository details:
   - Repository name: `uart-controller` (e.g., `uart-controller` or `pwm-generator`)
   - Description: `UART Controller IP block with configurable baud rate and FIFO support`
   - Make it Public or Private as preferred
4. Click "Create repository from template"

**Step 2: Clone Your New Repository**
```bash
# Clone your newly created repository (not the template)
git clone --depth=1 https://github.com/vyges/uart-controller.git
cd uart-controller

# For personal repositories
git clone --depth=1 https://github.com/janedoe/uart-controller.git
cd uart-controller
```

**✅ That's it! Your repository is ready for development.**

**⚠️ IMPORTANT: Repository Setup Best Practices**

**✅ RECOMMENDED APPROACH: Use GitHub Template Feature**
- Always use GitHub's "Use this template" feature for new repositories
- This creates a clean repository with proper history
- No remote conflicts or template references to clean up
- Simplest and most reliable approach

**❌ AVOID: Manual Template Cloning**
- **Do not clone the template repository manually**
- This leads to remote conflicts and push errors
- Template references persist in metadata
- Requires complex cleanup procedures
- **Use GitHub's template feature instead**

**🔄 If You Encounter Push Issues:**
If you get errors when pushing to your repository:

```bash
# Check current remote configuration
git remote -v

# If remote points to template, fix it:
git remote remove origin
git remote add origin https://github.com/your-username/your-repo.git

# If repository doesn't exist on GitHub, create it first:
# 1. Go to GitHub.com
# 2. Click "New repository"
# 3. Name it (e.g., uart-controller)
# 4. Don't initialize with README (you already have one)
# 5. Create repository

# Then push your code:
git add .
git commit -m "Initial commit from Vyges template"
git push -u origin main

# If you get "remote contains work" errors, force push (use with caution):
git push -u origin main --force
```

**Important:** You must create the new repository on GitHub before pushing your code. The Vyges CLI will warn you if the remote points to the template repository.

### 1.4 Troubleshooting Repository Setup

**Common Issues and Solutions:**

**Issue 1: "Remote contains work that you don't have locally"**
```bash
# This happens when the remote repository has content (like README.md)
# Solution: Force push your local content (use with caution)
git push -u origin main --force
```

**Issue 2: "Repository not found" or "Authentication failed"**
```bash
# Check if repository exists on GitHub
# Verify your remote URL is correct
git remote -v

# If URL is wrong, fix it:
git remote set-url origin https://github.com/your-username/your-repo.git
```

**Issue 3: "Template references in metadata"**
```bash
# If vyges-metadata.json still references template
# Regenerate metadata with correct repository info:
vyges init --fix-metadata
```

**Issue 4: "Branch name conflicts"**
```bash
# If your local branch is 'master' but remote expects 'main':
git branch -M main
git push -u origin main
```

**✅ SUCCESS INDICATORS:**
- `git remote -v` shows your repository URL (not template)
- `git push` works without errors
- Repository appears on GitHub with your content
- No template references in commit history

### 1.3 Initial Repository State
**Expected Structure:**

```console
{repository-name}/
├── rtl/
├── tb/
│   ├── sv_tb/
│   └── cocotb/
├── flow/
│   ├── openlane/
│   └── openlane2/
├── test/
│   └── vectors/
├── docs/
├── integration/
├── vyges-metadata.template.json
├── .vyges-ai-context.json
├── README.md
├── Developer_Guide.md
├── NOTICE
└── LICENSE
```

> **Note:** For advanced projects (ASIC+FPGA, analog/mixed-signal, or multi-IP), use the Vyges CLI to expand the directory structure:
>
> ```bash
> vyges expand --platform asic,fpga --add-analog
> ```
> This will create:
> ```plaintext
> rtl/
>   asic/
>     digital/
>     analog/
>   fpga/
>     digital/
> constraints/
>   asic/
>   fpga/
> flow/
>   asic/
>   fpga/
> ```

**Naming Examples (standard GitHub format):**
- `vyges/uart-controller` (organization repository - one functional IP)
- `janedoe/uart-controller` (personal repository - one functional IP)
- `vyges/my-uart` (descriptive name - one functional IP)
- `janedoe/uart-16550` (specific implementation - one functional IP)
- `vyges/custom-uart` (custom name - one functional IP)

**✅ DESIGN CHOICE:** The template includes `vyges-metadata.template.json` to prevent developers from accidentally committing generic metadata. The Vyges CLI will generate the correct `vyges-metadata.json` dynamically.

## Licensing & Attribution

### License Overview

The `vyges-ip-template` uses the Apache License, Version 2.0 for licensing. **Important**: This license applies specifically to the **hardware IP content** (RTL, documentation, testbenches, etc.) that you create using this template, not to the template structure and build processes themselves.

### What's Licensed Under Apache-2.0
- **Your RTL Files**: SystemVerilog, Verilog, VHDL source code
- **Your Documentation**: IP specifications, design documents, user guides
- **Your Testbenches**: Verification code, test vectors, simulation scripts
- **Your Generated Content**: Synthesis reports, simulation results, analysis outputs

### What's NOT Licensed Under Apache-2.0
- **Template Structure**: Directory organization and file naming conventions
- **Build Processes**: Makefiles, build scripts, CI/CD workflows
- **Tool Integration**: Tool installation scripts and configuration
- **Template Metadata**: Template JSON files and configuration templates
- **AI Context and Processing Engine**:
  - `.vyges-ai-context.json` - AI development context and prompts
  - `.copilot-chat-context.md` - GitHub Copilot integration context
  - `.cursorrules` - Cursor editor AI rules and conventions
  - AI-generated code patterns and development workflows

### Attribution Requirements

The `NOTICE` file includes Vyges template and ecosystem attribution. When publishing your own IP, add your own copyright, maintainer, and project information to the bottom of the `NOTICE` file. This ensures proper attribution for both Vyges and your IP.

### Example Attribution in RTL

```systemverilog
// Copyright (c) 2025 Your Name
// Licensed under the Apache License, Version 2.0
// See LICENSE file for details
module your_ip_top (
    // Your IP implementation
);
```

### Detailed Licensing Information

For comprehensive licensing guidance, including practical examples and legal considerations, see [LICENSE_SCOPE.md](LICENSE_SCOPE.md).

**Note**: This template is designed to help you create properly licensed hardware IP. The Apache-2.0 license is widely used in the open hardware community and provides good protection while allowing commercial use.

## Step 2: Design Your IP Block

### 2.1 Understanding the Design Flow

**🎯 Before Implementation: Design First**

```ascii
┌─────────────────────────────────────────────────────────────┐
│                    IP Design Flow                           │
│                                                             │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐      │
│  │   SPECIFY   │───▶│   DESIGN    │───▶│ IMPLEMENT   │      │
│  │ Requirements│    │ Architecture│    │   RTL       │      │
│  └─────────────┘    └─────────────┘    └─────────────┘      │
│         │                   │                   │           │
│         ▼                   ▼                   ▼           │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐      │
│  │   VERIFY    │◀───│   TEST      │◀───│  VALIDATE   │      │
│  │  Coverage   │    │  Testbench  │    │  Synthesis  │      │
│  └─────────────┘    └─────────────┘    └─────────────┘      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**Design Considerations for UART Controller:**

### 2.2 Functional Requirements
- **Baud Rate**: Configurable (9600 to 921600 bps)
- **Data Format**: 8-bit data, 1 stop bit, no parity (configurable)
- **FIFO Support**: TX/RX FIFOs for buffering
- **Interrupts**: TX empty, RX full, error conditions
- **APB Interface**: Standard APB slave for register access
- **Clock Domain**: Single clock domain operation

### 2.3 Interface Design

```ascii
┌─────────────────────────────────────┐
│         UART_CONTROLLER             │
│                                     │
│  ┌─────────┐    ┌─────────┐         │
│  │ APB     │    │ UART    │         │
│  │ Slave   │    │ Master  │         │
│  └─────────┘    └─────────┘         │
│                                     │
│  ┌─────────┐    ┌─────────┐         │
│  │ Clock   │    │ Reset   │         │
│  │ Domain  │    │ Domain  │         │
│  └─────────┘    └─────────┘         │
└─────────────────────────────────────┘
```

### 2.4 Architecture Design

```ascii
┌─────────────────────────────────────────────────────────────┐
│                    UART Controller Architecture             │
│                                                             │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐      │
│  │   APB       │    │   Control   │    │   UART      │      │
│  │  Slave      │◀──▶│  Registers  │◀──▶│  Interface  │      │
│  │ Interface   │    │             │    │             │      │
│  └─────────────┘    └─────────────┘    └─────────────┘      │
│         │                   │                   │           │
│         ▼                   ▼                   ▼           │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐      │
│  │   TX        │    │   RX        │    │   Interrupt │      │
│  │  FIFO       │    │  FIFO       │    │  Controller │      │
│  └─────────────┘    └─────────────┘    └─────────────┘      │
│         │                   │                   │           │
│         ▼                   ▼                   ▼           │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐      │
│  │   UART      │    │   UART      │    │   Error     │      │
│  │ Transmitter │    │  Receiver   │    │  Detection  │      │
│  └─────────────┘    └─────────────┘    └─────────────┘      │
│         │                   │                      │        |
│         └───────────────────┴──────────────────────┘        |
│                           │                                 |
│                    ┌─────────────┐                          |
│                    │   UART      │                          |
│                    │  TX/RX      │                          |
│                    └─────────────┘                          |
└─────────────────────────────────────────────────────────────┘
```

### 2.5 Register Map Design

```ascii
APB Register Map (8-bit address space):
┌─────────┬─────────┬─────────┬─────────────────────────────┐
│ Address │  Name   │ Access  │        Description          │
├─────────┼─────────┼─────────┼─────────────────────────────┤
│  0x00   │  CTRL   │  R/W    │ Control Register            │
│  0x04   │  STAT   │   R     │ Status Register             │
│  0x08   │  TXDATA │   W     │ TX Data Register            │
│  0x0C   │  RXDATA │   R     │ RX Data Register            │
│  0x10   │  BAUD   │  R/W    │ Baud Rate Configuration     │
│  0x14   │  FIFO   │  R/W    │ FIFO Configuration          │
│  0x18   │  INT    │  R/W    │ Interrupt Configuration     │
└─────────┴─────────┴─────────┴─────────────────────────────┘
```

### 2.6 Timing Design

```ascii
UART Timing (115200 baud, 50MHz clock):
┌─────────────────────────────────────────────────────────────┐
│                    Timing Requirements                      │
│                                                             │
│  Clock Frequency: 50 MHz                                    │
│  Baud Rate: 115200 bps                                      │
│  Clock Divider: 50MHz / 115200 = 434.03 (round to 434)      │
│  Bit Time: 434 clock cycles                                 │
│  Sample Point: Middle of bit (217 cycles)                   │
│                                                             │
│  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐    │
│  │Start│ │ D0  │ │ D1  │ │ D2  │ │ D3  │ │ D4  │ │ D5  │    │
│  └─────┘ └─────┘ └─────┘ └─────┘ └─────┘ └─────┘ └─────┘    │
│                                                             │
│  ┌─────┐ ┌─────┐ ┌─────┐                                    │
│  │ D6  │ │ D7  │ │Stop │                                    │
│  └─────┘ └─────┘ └─────┘                                    │
└─────────────────────────────────────────────────────────────┘
```

### 2.7 IP Block Pinout Design

```ascii
┌─────────────────────────────────────────────────────────────┐
│                    UART Controller IP Block                 │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                 APB Slave Interface                 │   │
│  │                                                     │   │
│  │  PCLK_i     ────┐                                   │   │
│  │  PRESETn_i  ────┤                                   │   │
│  │  PSEL_i     ────┤                                   │   │
│  │  PENABLE_i  ────┤                                   │   │
│  │  PWRITE_i   ────┤                                   │   │
│  │  PADDR_i[7:0]───┤                                   │   │
│  │  PWDATA_i[31:0]─┤                                   │   │
│  │  PRDATA_o[31:0]─┤                                   │   │
│  │  PREADY_o   ────┤                                   │   │
│  │  PSLVERR_o  ────┘                                   │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                 UART Interface                      │   │
│  │                                                     │   │
│  │  UART_TX_o   ────┐                                 │   │
│  │  UART_RX_i   ────┘                                 │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │               Interrupt Interface                   │   │
│  │                                                     │   │
│  │  IRQ_TX_EMPTY_o ────┐                              │   │
│  │  IRQ_RX_FULL_o  ────┘                              │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Configuration Interface                │   │
│  │                                                     │   │
│  │  CLOCK_FREQUENCY: 50 MHz (parameter)                │   │
│  │  BAUD_RATE: 115200 bps (parameter)                  │   │
│  │  FIFO_DEPTH: 16 entries (parameter)                 │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

**Pinout Table:**
The following table summarizes all external signals for the UART Controller IP block:

| Name             | Function    | Direction | Description                         |
|------------------|-------------|-----------|-------------------------------------|
| PCLK_i           | clock       | input     | APB clock input (50 MHz)            |
| PRESETn_i        | reset       | input     | APB reset input (active low)        |
| PSEL_i           | control     | input     | APB select input                    |
| PENABLE_i        | control     | input     | APB enable input                    |
| PWRITE_i         | control     | input     | APB write input                     |
| PADDR_i[7:0]     | data        | input     | APB address input (8-bit)           |
| PWDATA_i[31:0]   | data        | input     | APB write data input (32-bit)       |
| PRDATA_o[31:0]   | data        | output    | APB read data output (32-bit)       |
| PREADY_o         | status      | output    | APB ready output                    |
| PSLVERR_o        | status      | output    | APB slave error output              |
| UART_TX_o        | data        | output    | UART transmit output                |
| UART_RX_i        | data        | input     | UART receive input                  |
| IRQ_TX_EMPTY_o   | interrupt   | output    | Transmit FIFO empty interrupt       |
| IRQ_RX_FULL_o    | interrupt   | output    | Receive FIFO full interrupt         |

**Pinout Details:**

**APB Slave Interface (10 pins):**
- `PCLK_i`: APB clock input (50 MHz)
- `PRESETn_i`: APB reset input (active low)
- `PSEL_i`: APB select input
- `PENABLE_i`: APB enable input
- `PWRITE_i`: APB write input
- `PADDR_i[7:0]`: APB address input (8-bit)
- `PWDATA_i[31:0]`: APB write data input (32-bit)
- `PRDATA_o[31:0]`: APB read data output (32-bit)
- `PREADY_o`: APB ready output
- `PSLVERR_o`: APB slave error output

**UART Interface (2 pins):**
- `UART_TX_o`: UART transmit output
- `UART_RX_i`: UART receive input

**Interrupt Interface (2 pins):**
- `IRQ_TX_EMPTY_o`: Transmit FIFO empty interrupt
- `IRQ_RX_FULL_o`: Receive FIFO full interrupt

**Configuration Parameters:**
- `CLOCK_FREQUENCY`: System clock frequency (default: 50 MHz)
- `BAUD_RATE`: UART baud rate (default: 115200 bps)
- `FIFO_DEPTH`: FIFO depth for TX/RX (default: 16)

**Interface Summary:**
- **Total Pins**: 14 (10 APB + 2 UART + 2 Interrupt)
- **Input Pins**: 8 (7 APB + 1 UART)
- **Output Pins**: 6 (3 APB + 1 UART + 2 Interrupt)
- **Bidirectional Pins**: 0
- **Clock Domains**: 1 (single clock domain)

### 2.8 Design Validation Checklist
- ✅ **Functional Requirements**: All requirements captured?
- ✅ **Interface Design**: APB and UART interfaces defined?
- ✅ **Architecture**: Block diagram and data flow clear?
- ✅ **Register Map**: All registers and bit fields defined?
- ✅ **Timing**: Clock domains and timing requirements clear?
- ✅ **Error Handling**: Error conditions and recovery defined?
- ✅ **Pinout Design**: Complete pinout diagram with signal details?
- ✅ **Test Strategy**: How will you verify the design?

## Step 3: Choose Your Development Path

### 3.1 Development Path Decision Tree

**🎯 Choose Your Approach:**

```ascii
┌─────────────────────────────────────────────────────────────┐
│                    Vyges IP Development                     │
│                                                             │
│  ┌─────────────────┐              ┌─────────────────┐       │
│  │   GOD-MODE      │              │  STEP-BY-STEP   │       │
│  │   (Section 11)  │              │  (Sections 2-10)│       │
│  └─────────────────┘              └─────────────────┘       │
│           │                              │                  │
│           ▼                              ▼                  │
│  ┌─────────────────┐              ┌─────────────────┐       │
│  │ "Describe IP,   │              │ "Learn & Build  │       │
│  │  Get Everything"│              │  Incrementally" │       │
│  └─────────────────┘              └─────────────────┘       │
│                                                             │
│  ✅ Single metadata file          ✅ Progressive learning    │
│  ✅ Complete automation           ✅ Manual control          │
│  ✅ Production ready              ✅ Understanding           │
│  ✅ Time efficient                ✅ Customization           │
│                                                             │
│  🎯 Best for:                     🎯 Best for:               │
│  • Rapid prototyping             • Learning Vyges           │
│  • Standard IP types             • Custom requirements      │
│  • Time constraints              • Understanding details    │
│  • Team standards                • Educational purposes     │
│  • Proof of concept              • Complex IP blocks        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**🚀 GOD-MODE (Recommended for experienced users):**
- **Time**: 5-10 minutes
- **Effort**: Minimal (just configure metadata)
- **Output**: Complete, production-ready IP
- **Control**: High-level specification only
- **Learning**: Limited (AI handles everything)

**📚 STEP-BY-STEP (Recommended for learning):**
- **Time**: 30-60+ minutes
- **Effort**: Moderate (manual + AI assistance)
- **Output**: Custom, well-understood IP
- **Control**: Full control over each step
- **Learning**: Comprehensive (understand every aspect)

### 3.2 Quick Decision Guide

**Choose GOD-MODE if you:**
- ✅ Want to skip all manual steps
- ✅ Are building standard IP types (UART, SPI, I2C, etc.)
- ✅ Have time constraints
- ✅ Trust AI to generate production-quality code
- ✅ Want consistent, Vyges-compliant output
- ✅ Are prototyping or proof-of-concept

**Choose STEP-BY-STEP if you:**
- ✅ Want to learn Vyges development process
- ✅ Have custom or complex requirements
- ✅ Want full control over implementation
- ✅ Are building educational or research IP
- ✅ Want to understand every component
- ✅ Need to customize beyond standard templates

### 3.3 Path Selection

**For GOD-MODE (Skip to Section 12):**

```bash
# Jump directly to full automation
# Go to Section 12: Full AI Automation
```

**For STEP-BY-STEP (Continue with Section 3.4):**

```bash
# Continue with manual/AI-assisted development
# Proceed to Section 3.4: Project Initialization
```

## Step 3.4: Project Initialization (STEP-BY-STEP Path)

### 3.4.1 Read Documentation

```bash
cat README_FIRST.md
```

**Expected Content:**
- Quick start guide with multiple setup options
- Template structure explanation
- CLI-driven development workflow
- AI-assisted development guidance

**✅ IMPROVED:** `README_FIRST.md` now provides clear next steps and explains the minimal structure approach with progressive expansion.

### 3.4.2 Initialize Project with Vyges CLI (Recommended)
**Design:** Use the Vyges CLI for guided project initialization.

**✅ RECOMMENDED APPROACH:** Use Vyges CLI for automated setup:

```bash
# Interactive initialization (recommended)
vyges init --interactive

# Expected CLI interaction:
# Welcome to Vyges IP Development!
# Build IP, Not Boilerplate
# 
# Let's set up your functional IP project:
# IP name: uart-controller (auto-detected from Git Repo name: github.com/janedoe/uart-controller)
# Author: John Doe (auto-detected from Git: github.com/janedoe)
# License: [MIT] Apache-2.0 BSD-3-Clause GPL-3.0 CERN-OHL-S Proprietary
# Target platforms: [ASIC] FPGA (space to select, enter to confirm)
# Design type: [digital] analog mixed-signal
# 
# Tool configuration (auto-selected based on choices):
# - Simulation: Verilator ✓
# - Synthesis: OpenLane (ASIC) ✓
# - Testbench: SystemVerilog + cocotb ✓
# 
# Change tools? [y/N]: n
# 
# Creating project structure in current directory...
# ✓ Generated vyges-metadata.json
# ✓ Created basic RTL template
# ✓ Set up testbench structure
# ✓ Configured build system
# ✓ Added license files (MIT)

# Alternative: Quick setup from template
vyges setup --from-template uart-controller --name my-uart --baud-rate 230400
```

### 3.4.3 Manual Setup (Alternative)
If CLI is not available, manually create metadata:

```bash
# Copy template and customize
cp vyges-metadata.template.json vyges-metadata.json
# Edit vyges-metadata.json with UART Controller details
```

**Minimal UART Controller Metadata (Schema v1.0.0) - STEP-BY-STEP Example (Based on Design):**

```json
{
  "name": "janedoe/uart-controller",
  "x-version": "1.0.0",
  "version": "0.7.0",
  "description": "UART controller with APB interface",
  "license": "MIT",
  "target": ["asic"],
  "design_type": ["digital"],
  "maturity": "beta",
  "template": "vyges-ip-template@1.0.0",
  "interfaces": [
    {
      "type": "bus",
      "direction": "input",
      "protocol": "APB",
      "signals": [
        {"name": "PCLK", "direction": "input", "type": "clock"},
        {"name": "PRESETn", "direction": "input", "type": "reset"},
        {"name": "PADDR", "direction": "input", "type": "data"},
        {"name": "PWDATA", "direction": "input", "type": "data"},
        {"name": "PRDATA", "direction": "output", "type": "data"}
      ]
    },
    {
      "type": "io",
      "direction": "output",
      "protocol": "UART",
      "signals": [
        {"name": "UART_TX", "direction": "output", "type": "data"},
        {"name": "UART_RX", "direction": "input", "type": "data"}
      ]
    }
  ],
  "parameters": [
    {"name": "CLOCK_FREQUENCY", "type": "int", "default": 50000000},
    {"name": "BAUD_RATE", "type": "int", "default": 115200}
  ]
}
```

## Step 4: RTL Development

### 4.1 AI-Assisted RTL Generation (Recommended)
**Design:** Use AI with Vyges context for guided RTL development.

**✅ RECOMMENDED APPROACH:** Use AI to generate RTL following Vyges conventions:

```bash
# AI can generate RTL from metadata specifications
# "Generate a UART controller with APB interface following Vyges conventions"
```

**AI will generate:**

- Proper module header with Vyges conventions
- Interface signals following Vyges Standardized Interface Catalog
- Basic functionality structure
- Comments and documentation

### 4.2 Manual RTL Creation (Alternative)
**File:** `rtl/uart_controller.sv`

**✅ IMPROVED:** AI context provides comprehensive guidance for RTL development.

**Developer creates with Vyges conventions:**

```systemverilog
//=============================================================================
// Module Name: uart_controller
//=============================================================================
// Description: UART controller with APB interface
//
// Features:
// - Configurable baud rate
// - APB slave interface
// - UART TX/RX interface
//
// Author: janedoe
// License: MIT
//=============================================================================

module uart_controller #(
    parameter int CLOCK_FREQUENCY = 50_000_000,
    parameter int BAUD_RATE = 115_200
)(
    // APB Interface
    input  logic        PCLK,      // APB clock
    input  logic        PRESETn,   // APB reset (active low)
    input  logic [7:0]  PADDR,     // APB address
    input  logic [31:0] PWDATA,    // APB write data
    output logic [31:0] PRDATA,    // APB read data
    
    // UART Interface
    output logic        UART_TX,   // UART transmit
    input  logic        UART_RX    // UART receive
);

    // Implementation here...
    
endmodule
```

### 4.3 Create Supporting Modules (Optional)

**For the minimal UART controller, no additional modules are needed.**
**However, for more complex implementations, you might need:**

- `rtl/uart_transmitter.sv` - UART transmission logic (component of the functional IP)
- `rtl/uart_receiver.sv` - UART reception logic (component of the functional IP)
- `rtl/apb_slave.sv` - APB slave interface wrapper (component of the functional IP)

**✅ IMPROVED:** AI can generate supporting modules when needed:

```bash
# AI prompts for modular design:
# "Create a UART transmitter module following Vyges conventions"
# "Create an APB slave interface wrapper"
# "Generate UART receiver with proper timing"
# "Generate FIFO component for the UART functional IP"
```

## Step 5: Testbench Development

### 5.1 AI-Assisted Testbench Generation (Recommended)
**Design:** Use AI to generate comprehensive testbenches.

**✅ RECOMMENDED APPROACH:** Use AI to generate testbenches from metadata:

```bash
# Generate SystemVerilog testbench
vyges generate testbench --lang systemverilog

# Generate cocotb testbench
vyges generate testbench --lang cocotb

# AI can also generate testbenches directly:
# "Create a SystemVerilog testbench for the UART controller"
# "Generate a cocotb testbench with coverage and assertions"
```

**AI will generate:**
- Clock and reset generation
- DUT instantiation
- Test stimulus generation
- Response checking
- Coverage collection

### 5.2 Manual Testbench Creation (Alternative)
**File:** `tb/sv_tb/tb_uart_controller.sv`

**✅ IMPROVED:** AI context provides comprehensive testbench guidance.

**Developer creates with Vyges conventions:**

```systemverilog
module tb_uart_controller;
    // Clock and reset generation
    logic PCLK;
    logic PRESETn;
    
    // DUT instantiation
    uart_controller dut (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PADDR(8'h00),
        .PWDATA(32'h00000000),
        .PRDATA(),
        .UART_TX(),
        .UART_RX(1'b0)
    );
    
    // Test stimulus and checking
    initial begin
        // Test implementation
    end
    
endmodule
```

### 5.3 Cocotb Testbench
**File:** `tb/cocotb/test_uart_controller.py`

**✅ IMPROVED:** AI can generate comprehensive cocotb testbenches:

```bash
# Generate cocotb testbench with advanced features
vyges cocotb generate --ip uart-controller

# AI can generate cocotb testbenches with:
# - Coverage collection and assertions
# - Waveform generation and analysis
# - Python ecosystem integration (pytest, numpy, pandas)
# - Mixed-signal testing capabilities
# - AI-driven test generation
```

**Developer creates with Vyges conventions:**

```python
import cocotb
from cocotb.triggers import RisingEdge, Timer
from cocotb.clock import Clock

@cocotb.test()
async def test_uart_basic_transmission(dut):
    # Test implementation
    pass
```

### 5.4 Test Makefile
**File:** `tb/Makefile`

**✅ IMPROVED:** CLI auto-generates build system and test infrastructure:

```bash
# CLI automatically creates:
# - Makefile with simulation targets
# - Build scripts for different simulators
# - Test infrastructure setup
# - CI/CD integration hooks
```

## Step 6: Flow Configuration

### 6.1 AI-Assisted Flow Generation (Recommended)
**Design:** Use AI to generate tool configurations from metadata.

**✅ RECOMMENDED APPROACH:** Use AI to generate flow configurations:

```bash
# Generate OpenLane configuration
vyges generate flow --tool openlane

# Generate Vivado configuration
vyges generate flow --tool vivado

# AI can generate configurations based on:
# - IP metadata specifications
# - Target platform requirements
# - Tool requirements from metadata
```

**AI will generate:**

- Tool-specific configuration files
- Synthesis and implementation scripts
- Constraint files
- Build automation

### 6.2 Manual Flow Configuration (Alternative)
**File:** `flow/openlane/config.json`

**✅ IMPROVED:** AI context provides comprehensive flow configuration guidance.

**Developer configures with Vyges conventions:**

```json
{
    "DESIGN_NAME": "uart_controller",
    "VERILOG_FILES": "dir::../../rtl/*.sv",
    "CLOCK_PORT": "PCLK",
    "CLOCK_PERIOD": 20,
    "FP_CORE_UTIL": 40,
    "PL_TARGET_DENSITY": 0.4
}
```

### 6.3 Synthesis Scripts
**✅ IMPROVED:** CLI and AI auto-generate synthesis and implementation scripts:

```bash
# CLI automatically creates:
# - Synthesis scripts for different tools
# - Implementation scripts
# - Constraint generation
# - Build automation
```

## Step 7: Documentation

### 7.1 AI-Assisted Documentation Generation (Recommended)
**Design:** Use AI to generate comprehensive documentation from metadata and code.

**✅ RECOMMENDED APPROACH:** Use AI to generate documentation:

```bash
# Generate specification document
vyges generate spec

# Generate comprehensive README
vyges generate readme

# AI can generate documentation from:
# - IP metadata specifications
# - RTL code analysis
# - Interface definitions
# - Test specifications
```

**AI will generate:**
- Architecture documentation
- API documentation
- Usage examples
- Integration guides
- README with proper structure

### 7.2 Manual Documentation Creation (Alternative)
**File:** `docs/architecture.md`

**✅ IMPROVED:** AI context provides comprehensive documentation guidance.

**Developer creates with Vyges conventions:**

```markdown
# UART Controller Architecture

## Overview
This document describes the architecture of the UART Controller IP block.

## Block Diagram
[Insert block diagram]

## Interfaces
[Describe interfaces]

## Parameters
[Describe parameters]
```

### 7.3 ASCII Block Diagrams
**✅ NEW FEATURE:** Generate visual block diagrams:

```bash
# Generate single IP block diagram
vyges diagram block --ip uart-controller

# Generate connection diagram between IPs
vyges diagram connections --ip1 cpu --ip2 uart-controller

# AI can generate ASCII diagrams showing:
# - All pins grouped by interface type
# - Signal directions and descriptions
# - Pin-to-pin connections between IPs
# - Interface compatibility validation
```

### 7.4 API Documentation
**✅ IMPROVED:** AI can generate comprehensive API documentation from RTL code and metadata.

## Step 8: Testing and Validation

### 8.1 CLI-Driven Testing (Recommended)
**Design:** Use Vyges CLI for comprehensive testing and validation.

**✅ RECOMMENDED APPROACH:** Use CLI for automated testing:

```bash
# Run basic tests and validation
vyges test --simulation

# Run synthesis checks
vyges test --synthesis

# Run linting checks
vyges test --lint

# Validate project structure and metadata
vyges validate --strict
```

**CLI automatically handles:**
- Simulation setup and execution
- Test vector generation
- Validation and linting
- Coverage collection
- Build automation

### 8.2 Manual Testing Setup (Alternative)
**✅ IMPROVED:** CLI provides comprehensive testing infrastructure.

**Developer can create custom tests:**
- `test/vectors/uart_tests.json`
- `sim/run_simulation.sh`
- `sim/Makefile`

### 8.3 Code Quality Analysis and KPIs
**✅ NEW FEATURE:** Use the built-in code KPIs analysis script for comprehensive project quality assessment.

**The `scripts/code_kpis.py` script provides detailed analysis of:**
- **Code Metrics**: Lines of RTL, testbench, and constraint files
- **Documentation Analysis**: Coverage of README, Developer Guide, and other docs
- **Test Coverage**: Analysis of test files, coverage reports, and test vectors
- **Quality Metrics**: Linting, synthesis, and simulation status
- **Vyges Metadata Analysis**: Comprehensive metadata quality assessment including:
  - Field completeness and validation
  - Interface quality analysis
  - Test coverage metadata evaluation
  - Flow configuration assessment
  - AI generation readiness
  - Catalog publication readiness
- **Project Structure**: File organization and directory analysis

**Usage:**
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

**Integration:**
- **CI/CD pipelines** for automated quality checks
- **Development workflows** for progress tracking
- **Project reviews** for completeness assessment
- **Catalog validation** for publication readiness

**See `scripts/README.md` for detailed documentation and examples.**

## Step 9: Integration and Packaging

### 9.1 AI-Assisted Integration (Recommended)
**Design:** Use AI to generate integration examples and wrapper modules.

**✅ RECOMMENDED APPROACH:** Use AI for integration support:

```bash
# AI can generate:
# - Integration examples for OpenTitan, RocketChip, Caravel
# - Wrapper modules for different SoC platforms
# - Interface compatibility validation
# - Pin connection diagrams
```

**AI will generate:**
- SoC-specific integration examples
- Wrapper modules with proper interfaces
- Integration documentation
- Compatibility validation

### 9.2 Package Configuration
**✅ IMPROVED:** CLI handles packaging and distribution setup:

```bash
# Validate for catalog publication
vyges publish --dry-run

# Publish to Vyges catalog
vyges publish
```

## Step 10: CI/CD Setup

### 10.1 CLI-Generated CI/CD (Recommended)
**Design:** Use Vyges CLI to generate CI/CD configuration.

**✅ RECOMMENDED APPROACH:** Use CLI for automated CI/CD setup:

```bash
# CLI automatically generates:
# - GitHub Actions workflows
# - CI/CD configuration
# - Automated testing pipelines
# - Synthesis and validation workflows
```

**CLI generates:**
- `.github/workflows/test.yml`
- `.github/workflows/synthesis.yml`
- Automated testing and validation
- Coverage reporting
- Artifact generation

## Step 11: Catalog Publication

### 11.1 CLI-Driven Validation (Recommended)
**Design:** Use Vyges CLI for comprehensive validation and publication.

**✅ RECOMMENDED APPROACH:** Use CLI for validation and publication:

```bash
# Validate IP for catalog readiness
vyges validate --strict

# Check catalog readiness
vyges publish --dry-run

# Publish to Vyges catalog
vyges publish
```

**CLI handles:**
- Metadata validation
- Structure validation
- Code quality checks
- Catalog compatibility validation
- Publication workflow

### 11.2 AI-Assisted Quality Improvement
**✅ NEW FEATURE:** Use AI to improve catalog quality:

```bash
# AI can improve:
# - Metadata completeness
# - Documentation quality
# - Test coverage
# - Code quality
# - Discoverability tags
```

## Summary of Current Capabilities

### ✅ Implemented Features (CLI-Driven Development)
1. **Vyges CLI tool** - Automated project initialization and metadata generation
2. **AI-assisted development** - Comprehensive AI context with guided prompts
3. **Template system** - Pre-built templates for common IP types
4. **Automated build system** - CLI-generated Makefiles and scripts
5. **Documentation generation** - AI-generated documentation from metadata

### ✅ Implemented Features (Quality Assurance)
6. **CI/CD automation** - CLI-generated GitHub Actions workflows
7. **Validation tools** - Comprehensive validation with `vyges validate`
8. **Integration support** - AI-generated integration examples
9. **Testing infrastructure** - CLI-generated simulation and test scripts
10. **Flow configuration** - AI-generated tool configurations
11. **Code KPIs analysis** - Comprehensive project quality assessment with `scripts/code_kpis.py`

### ✅ Implemented Features (Developer Experience)
11. **Interactive setup** - Guided initialization with `vyges init --interactive`
12. **Progressive complexity** - `vyges expand` commands for structure evolution
13. **ASCII diagrams** - Visual block diagrams with `vyges diagram`
14. **Cocotb integration** - Advanced Python-based verification
15. **Catalog integration** - Automated publication with `vyges publish`

### 🔄 Remaining Gaps (Future Enhancements)
16. **Web interface** - Web-based template selection and customization
17. **Template marketplace** - Community-contributed templates
18. **Advanced analytics** - Detailed project analytics and insights
19. **Collaboration features** - Multi-user development support
20. **Performance profiling** - Performance analysis and optimization

## Implementation Status

### ✅ Completed Features
1. **Vyges CLI tool** - Core CLI with init, setup, generate, validate, and publish commands
2. **AI context system** - Comprehensive `.vyges-ai-context.json` with development guidance
3. **Template system** - Template-based project generation with customization
4. **Build automation** - CLI-generated Makefiles and build scripts
5. **Documentation generation** - AI-assisted documentation creation

### ✅ Completed Features (Quality Assurance)
6. **CI/CD automation** - GitHub Actions workflow generation
7. **Validation framework** - Comprehensive project validation
8. **Integration support** - AI-generated integration examples
9. **Testing infrastructure** - Simulation and verification setup
10. **Flow configuration** - Tool-specific configuration generation
11. **Code KPIs analysis** - Project quality assessment and metadata validation

### 🔄 In Progress Features
11. **Interactive CLI** - Enhanced interactive mode with guided setup
12. **Progressive expansion** - `vyges expand` commands for structure evolution
13. **ASCII diagrams** - Visual block diagram generation
14. **Advanced cocotb** - Enhanced Python verification features
15. **Catalog integration** - Automated publication workflow

### 📋 Future Enhancements
16. **Web interface** - Web-based template selection and customization
17. **Template marketplace** - Community-contributed templates
18. **Advanced analytics** - Project analytics and insights
19. **Collaboration features** - Multi-user development support
20. **Performance profiling** - Performance analysis and optimization

## Conclusion

The Vyges IP template has evolved from a basic structural skeleton into a comprehensive, CLI-driven development environment that truly embodies the "Build IP, Not Boilerplate" philosophy. The template now provides:

### ✅ What's Working Well
- **CLI-driven development** - Automated project initialization and setup
- **AI-assisted development** - Comprehensive guidance through `.vyges-ai-context.json`
- **Template system** - Pre-built templates for common IP types
- **Progressive complexity** - Start minimal, expand as needed
- **Quality assurance** - Automated validation, testing, and CI/CD

### 🎯 Key Success Factors
- **Developer productivity** - Focus on IP logic, not infrastructure
- **Consistency** - Standardized conventions and interfaces
- **Automation** - CLI handles repetitive tasks
- **Guidance** - AI provides context-aware assistance
- **Quality** - Built-in validation and testing

### 🚀 Impact
The template now enables developers to:
1. **Start immediately** - `vyges init --interactive` gets you coding
2. **Focus on design** - Infrastructure is handled automatically
3. **Maintain quality** - Built-in validation and testing
4. **Scale complexity** - Progressive structure expansion
5. **Publish easily** - Automated catalog integration

This transformation from a structural template to a comprehensive development environment demonstrates the power of combining CLI automation with AI assistance to create a truly productive IP development experience.

## Section 12: Full AI Automation (GOD-MODE)

> **🎯 This is the GOD-MODE path from Step 2.1 Decision Tree**
> 
> If you chose GOD-MODE, this section will generate everything automatically from a single metadata file.
> If you want to learn step-by-step, go back to Section 3.4.

### 12.1 One-Shot AI Generation
**Design:** Configure metadata for complete AI automation, skipping all manual steps.

**✅ RECOMMENDED APPROACH:** Create a comprehensive metadata file and let AI handle everything:

```bash
# Single command to generate complete IP
vyges generate all --from-metadata vyges-metadata.json

# AI will automatically:
# - Generate all RTL modules
# - Create testbenches (SystemVerilog + cocotb)
# - Set up build systems and Makefiles
# - Generate documentation
# - Configure synthesis flows
# - Set up CI/CD
# - Create ASCII diagrams
# - Validate everything
```

### 12.2 Comprehensive Metadata for Full Automation
**File:** `vyges-metadata.json` (AI-Ready Configuration)

```json
{
  "name": "janedoe/uart-controller",
  "x-version": "1.0.0",
  "version": "0.7.0",
  "description": "UART controller with APB interface",
  "license": "MIT",
  "target": ["asic"],
  "design_type": ["digital"],
  "maturity": "beta",
  "template": "vyges-ip-template@1.0.0",
  "created": "2025-07-17T03:03:25Z",
  "updated": "2025-07-17T03:03:25Z",
  "maintainers": [
    {
      "name": "Jane Doe",
      "email": "jane.doe@example.com",
      "github": "janedoe"
    }
  ],
  "branding": {
    "provider": "Jane Doe",
    "website": "https://github.com/janedoe"
  },
  "source": {
    "type": "git",
    "url": "https://github.com/janedoe/janedoe-uart-controller",
    "commit": "main",
    "private": false,
    "containsEncryptedPayload": false,
    "indexing": true
  },
  "meta": {
    "generated_by": "vyges-cli",
    "schema": {
      "version": "1.0.0",
      "compatible_versions": ["1.0.0"],
      "generated_with": "vyges-cli"
    },
    "template": {
      "generator": "vyges-cli",
      "init_tool": "vyges-cli",
      "template_version": "1.0.0",
      "generated_at": "2025-07-17T03:03:25Z"
    },
    "ai_generation": {
      "mode": "full_automation",
      "generate_rtl": true,
      "generate_testbenches": true,
      "generate_documentation": true,
      "generate_build_system": true,
      "generate_flows": true,
      "generate_ci_cd": true,
      "generate_diagrams": true,
      "validate_complete": true,
      "complexity_level": "production_ready",
      "include_examples": true,
      "include_integration_tests": true,
      "include_performance_tests": true
    }
  },
  "interfaces": [
    {
      "type": "bus",
      "direction": "input",
      "protocol": "APB",
      "width": 32,
      "signals": [
        {
          "name": "PCLK",
          "direction": "input",
          "type": "clock",
          "description": "APB clock signal"
        },
        {
          "name": "PRESETn",
          "direction": "input",
          "type": "reset",
          "active_level": "low",
          "description": "APB reset signal"
        },
        {
          "name": "PSEL",
          "direction": "input",
          "type": "control",
          "description": "APB select signal"
        },
        {
          "name": "PENABLE",
          "direction": "input",
          "type": "control",
          "description": "APB enable signal"
        },
        {
          "name": "PWRITE",
          "direction": "input",
          "type": "control",
          "description": "APB write signal"
        },
        {
          "name": "PADDR",
          "direction": "input",
          "width": 8,
          "type": "data",
          "description": "APB address bus"
        },
        {
          "name": "PWDATA",
          "direction": "input",
          "width": 32,
          "type": "data",
          "description": "APB write data bus"
        },
        {
          "name": "PRDATA",
          "direction": "output",
          "width": 32,
          "type": "data",
          "description": "APB read data bus"
        },
        {
          "name": "PREADY",
          "direction": "output",
          "type": "control",
          "description": "APB ready signal"
        },
        {
          "name": "PSLVERR",
          "direction": "output",
          "type": "control",
          "description": "APB slave error signal"
        }
      ]
    },
    {
      "type": "io",
      "direction": "output",
      "protocol": "UART",
      "signals": [
        {
          "name": "UART_TX",
          "direction": "output",
          "type": "data",
          "description": "UART transmit signal"
        },
        {
          "name": "UART_RX",
          "direction": "input",
          "type": "data",
          "description": "UART receive signal"
        }
      ]
    },
    {
      "type": "interrupt",
      "direction": "output",
      "signals": [
        {
          "name": "IRQ_TX_EMPTY",
          "direction": "output",
          "type": "interrupt",
          "description": "Transmit FIFO empty interrupt"
        },
        {
          "name": "IRQ_RX_FULL",
          "direction": "output",
          "type": "interrupt",
          "description": "Receive FIFO full interrupt"
        }
      ]
    }
  ],
  "parameters": [
    {
      "name": "CLOCK_FREQUENCY",
      "type": "int",
      "default": 50000000,
      "description": "System clock frequency in Hz",
      "units": "Hz",
      "required": true,
      "range": {"min": 1000000, "max": 200000000}
    },
    {
      "name": "BAUD_RATE",
      "type": "int",
      "default": 115200,
      "description": "UART baud rate",
      "units": "bps",
      "required": true,
      "range": {"min": 9600, "max": 921600}
    },
    {
      "name": "FIFO_DEPTH",
      "type": "int",
      "default": 16,
      "description": "FIFO depth for TX and RX buffers",
      "units": "entries",
      "required": false,
      "range": {"min": 8, "max": 256}
    }
  ],
  "test": {
    "coverage": true,
    "testbenches": ["cocotb", "SystemVerilog"],
    "simulators": ["verilator", "icarus"],
    "status": {
      "functional": "passed",
      "coverage": "passed",
      "linting": "passed"
    },
    "ai_generation": {
      "generate_basic_tests": true,
      "generate_advanced_tests": true,
      "generate_coverage_tests": true,
      "generate_performance_tests": true,
      "generate_integration_tests": true,
      "test_scenarios": [
        "basic_transmission",
        "baud_rate_configuration",
        "fifo_operations",
        "interrupt_handling",
        "apb_interface_validation",
        "error_conditions",
        "performance_benchmarks"
      ]
    }
  },
  "flows": {
    "asic": {
      "synthesis": {
        "toolchain": "openlane",
        "status": "passed",
        "pdks": ["sky130"],
        "ai_generation": {
          "generate_config": true,
          "generate_constraints": true,
          "generate_scripts": true,
          "optimize_for_area": true,
          "optimize_for_speed": true
        }
      }
    },
    "fpga": {
      "synthesis": {
        "toolchain": "vivado",
        "status": "untested",
        "ai_generation": {
          "generate_config": true,
          "generate_constraints": true,
          "generate_scripts": true
        }
      }
    }
  },
  "documentation": {
    "ai_generation": {
      "generate_readme": true,
      "generate_architecture_doc": true,
      "generate_api_doc": true,
      "generate_integration_guide": true,
      "generate_examples": true,
      "generate_diagrams": true,
      "include_code_examples": true,
      "include_timing_diagrams": true,
      "include_interface_specs": true
    }
  },
  "build_system": {
    "ai_generation": {
      "generate_makefiles": true,
      "generate_build_scripts": true,
      "generate_ci_cd": true,
      "generate_docker_config": true,
      "include_simulation_targets": true,
      "include_synthesis_targets": true,
      "include_validation_targets": true
    }
  },
  "automation": {
    "automation_level": "full",
    "minimal_required": ["name", "version", "license", "interfaces", "template", "target", "design_type", "maturity", "description", "source", "asic", "fpga", "test", "flows"],
    "recommended_for_automation": ["parameters", "dependencies", "toolRequirements", "performance", "reliability", "packaging", "community"],
    "ai_capabilities": {
      "code_generation": "complete",
      "test_generation": "complete",
      "documentation_generation": "complete",
      "build_system_generation": "complete",
      "validation_generation": "complete"
    }
  }
}
```

### 12.3 AI Generation Commands

```bash
# Generate everything from metadata
vyges generate all --from-metadata vyges-metadata.json

# Or generate specific components
vyges generate rtl --from-metadata vyges-metadata.json
vyges generate testbench --from-metadata vyges-metadata.json
vyges generate documentation --from-metadata vyges-metadata.json
vyges generate build-system --from-metadata vyges-metadata.json
vyges generate flows --from-metadata vyges-metadata.json
vyges generate ci-cd --from-metadata vyges-metadata.json
vyges generate diagrams --from-metadata vyges-metadata.json

# Validate the complete generated project
vyges validate --complete --from-metadata vyges-metadata.json
```

### 12.4 Expected AI Output
**AI will automatically generate:**

**RTL Files:**
- `rtl/uart_controller.sv` - Main UART controller module
- `rtl/uart_transmitter.sv` - UART transmission logic
- `rtl/uart_receiver.sv` - UART reception logic
- `rtl/apb_slave.sv` - APB slave interface wrapper
- `rtl/fifo.sv` - Configurable FIFO module

**Testbench Files:**
- `tb/sv_tb/tb_uart_controller.sv` - SystemVerilog testbench
- `tb/cocotb/test_uart_controller.py` - Cocotb testbench
- `tb/cocotb/test_uart_advanced.py` - Advanced test scenarios
- `tb/cocotb/test_uart_performance.py` - Performance tests
- `test/vectors/uart_tests.json` - Test vectors

**Documentation:**
- `README.md` - Comprehensive project documentation
- `docs/architecture.md` - Architecture documentation
- `docs/api.md` - API documentation
- `docs/integration.md` - Integration guide
- `docs/timing.md` - Timing diagrams

**Build System:**
- `Makefile` - Main build system
- `tb/Makefile` - Testbench build system
- `scripts/build.sh` - Build scripts
- `scripts/simulate.sh` - Simulation scripts

**Flow Configuration:**
- `flow/openlane/config.json` - OpenLane configuration
- `flow/openlane/constraints.sdc` - Synthesis constraints
- `flow/vivado/uart_controller.xdc` - Vivado constraints

**CI/CD:**
- `.github/workflows/test.yml` - GitHub Actions test workflow
- `.github/workflows/synthesis.yml` - Synthesis workflow
- `.github/workflows/validate.yml` - Validation workflow

**Diagrams:**
- `docs/diagrams/uart_controller_block.svg` - Block diagram
- `docs/diagrams/uart_controller_timing.svg` - Timing diagram
- `docs/diagrams/apb_interface.svg` - Interface diagram

### 12.5 Benefits of Full AI Automation
- **Time Savings**: Skip all manual steps (sections 2-10)
- **Consistency**: AI ensures all components follow Vyges conventions
- **Completeness**: All necessary files generated automatically
- **Quality**: Built-in validation and best practices
- **Production Ready**: Complete project structure from metadata
- **Maintainable**: Consistent code style and documentation

### 12.6 When to Use Full AI Automation
- **Rapid Prototyping**: Quick IP development for proof of concept
- **Standard IP**: Common IP types with well-defined interfaces
- **Learning**: Students learning IP development concepts
- **Team Standards**: Enforcing consistent project structure
- **Time Constraints**: When manual development time is limited

This approach transforms the "Build IP, Not Boilerplate" philosophy into "Describe IP, Get Everything" - the ultimate automation experience.
