# ADR-002: Declarative State Management for Day-0 Bare-Metal Provisioning

## Status

Accepted

## Context

Layer 1 (Underlay) provisioning requires configuring the Proxmox VE hypervisor, establishing the DMZ virtual bridge (`vmbr1`), and enforcing OS-level hardening. Initially, POSIX Bash scripts were considered to minimize toolchain dependencies. However, implementing robust idempotency and state verification in Bash requires building complex, custom logic, leading to unmaintainable procedural debt ("poor man's Ansible").

## Decision

We adopt **Ansible** as the declarative configuration management engine for all Day-0 bare-metal provisioning and OS-level hardening.

## Consequences

### Positive

* **Idempotency by Design:** Built-in state checking executes changes only when the actual state drifts from the declared state.
* **Declarative Hardening:** Security policies become readable, auditable YAML code instead of imperative command sequences.

### Trade-offs

* **Execution Environment:** Requires Python and Ansible Core to be installed on the operator's local workstation, adding a dependency to the Day-0 bootstrap process.
