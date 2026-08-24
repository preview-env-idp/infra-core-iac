# ADR-003: Layer 1 Security, Secrets Management & IaC Structure

## Status

Accepted

## Context

Layer 1 provisioning requires a secure methodology for handling sensitive credentials and structuring infrastructure code. A monolithic codebase combined with interactive credential injection increases the operational blast radius and introduces risks of accidental credential leakage or privilege escalation.

## Decision

We establish the following strict engineering boundaries for Layer 1 operations:

* **Cryptographic State Separation:** We adopt `ansible-vault` to encrypt credentials at rest. Public configuration state (`vars.yaml`) is strictly decoupled from cryptographic state (`vault.yaml`).
* **Modular Role Architecture:** We reject monolithic roles (e.g., `underlay_baseline`). Infrastructure logic is fragmented into single-responsibility modules (`initial_setup`, `secure_ssh`, `networking`, `pve_firewall`).
* **Variable Isolation:** We enforce `private_role_vars = True` in the execution engine to prevent variable bleeding and unintended shadowing between roles.
* **Log Leakage Mitigation:** We reject persistent, plaintext static audit logging (`log_path`) on the operator's local workstation to prevent accidental credential leakage in the event of module execution failures.

## Consequences

### Positive

* Enables 100% GitOps compliance for Layer 1 configuration by allowing safe commits of encrypted credentials.
* Reduces the blast radius during Day-2 operations by enabling granular role execution.
* Closes local plaintext data leak vectors.

### Trade-offs

* Introduces operational complexity, requiring the operator to securely generate and manage a local master vault password.
