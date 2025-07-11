# Packaging Directory

This directory contains files related to chiplet packaging and multi-die integration.

## Purpose

The packaging directory is used for IP blocks that are designed for chiplet integration, containing:

- **Interposer constraints** - Design rules and routing constraints for interposer-based integration
- **Bump maps** - Physical bump assignments for die-to-die connections
- **Thermal analysis** - Thermal constraints and analysis for multi-die systems
- **Power domain configuration** - Power management and domain isolation requirements
- **Signal conformance validation** - Protocol compliance and verification results
- **Lifecycle metadata** - Supply chain tracking and certification information
- **Multi-die testing** - Test access methods and coverage requirements
- **Packaging requirements** - Documentation of packaging considerations

## When to Use

This directory is created when:
- IP is designed for chiplet integration (`chiplet_ready: true` in metadata)
- Multi-die system design is required
- Die-to-die interface protocols are used (UCIe, BoW, AIB, EMIB)
- Advanced packaging technologies are employed (2.5D interposer, 3D stacking)
- Supply chain tracking and certification are required

## Files

### Core Packaging Files
- `interposer_constraints.json` - Interposer design constraints (technology, routing layers, pitch, spacing)
- `bump_map.csv` - Bump assignments for die-to-die connections
- `thermal_constraints.json` - Thermal analysis constraints (power limits, temperature, cooling)
- `packaging_requirements.md` - Documentation of packaging considerations

### Advanced Integration Files
- `power_domains.json` - Power domain configuration (voltage, isolation, retention, current limits)
- `signal_conformance.json` - Protocol compliance validation and verification results
- `lifecycle_metadata.json` - Supply chain tracking, trusted fabricator status, certifications
- `multi_die_testing.json` - Test access methods, coverage requirements, test vectors

### Documentation Files
- `thermal_analysis.md` - Detailed thermal analysis and cooling requirements
- `power_management.md` - Power domain design and management guidelines
- `chiplet_integration.md` - Comprehensive chiplet integration guide

## Integration with Vyges CLI

Use the `vyges chiplet` commands to manage packaging files:

### Basic Commands
```bash
vyges chiplet validate --ip my-ip
vyges chiplet generate-interface --protocol ucie --ip my-ip
vyges chiplet generate-docs --packaging --ip my-ip
```

### Advanced Commands
```bash
# Constraint generation and validation
vyges chiplet generate-constraints --interposer --ip my-ip
vyges chiplet generate-constraints --bump-map --ip my-ip
vyges chiplet validate --constraints interposer --ip my-ip
vyges chiplet validate --constraints thermal --ip my-ip

# Analysis and configuration
vyges chiplet analyze-thermal --ip my-ip
vyges chiplet configure-power-domains --ip my-ip
vyges chiplet validate-conformance --protocol ucie --ip my-ip

# Lifecycle and supply chain
vyges chiplet track-lifecycle --origin vyges/partner-x --ip my-ip

# Multi-die testing
vyges chiplet create-testbench --multi-die --ip1 cpu --ip2 my-ip
```

## AI-Assisted Development

The packaging directory supports AI-assisted development through the `.vyges-ai-context.json` file:

- **Generate interposer constraints** using `generate_interposer_constraints` prompt
- **Create bump constraints** using `create_bump_constraints` prompt
- **Analyze thermal constraints** using `analyze_thermal_constraints` prompt
- **Configure power domains** using `configure_power_domains` prompt
- **Validate signal conformance** using `validate_signal_conformance` prompt
- **Track lifecycle metadata** using `track_lifecycle_metadata` prompt

## Metadata Integration

All packaging files are automatically integrated with the `vyges-metadata.json` schema:

- Chiplet metadata section includes all packaging constraints
- Interface definitions support chiplet protocol types
- Power domain configuration is tracked in metadata
- Lifecycle and supply chain information is maintained
- Test coverage and validation results are documented 