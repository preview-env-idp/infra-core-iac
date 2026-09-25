# ADR-006: Bootstrap Node (DevBox) Provisioning Tool Selection

## Status

Accepted

## Context

The Project Alcambic architecture designates a central virtual machine (DevBox) to act as the management plane and execution environment for subsequent Infrastructure as Code (IaC) operations via OpenTofu.
Using OpenTofu to provision its own execution environment introduces a fundamental "chicken-and-egg" circular dependency. If an operator runs OpenTofu locally to create the DevBox, the resulting `.tfstate` file is stranded on the operator's local workstation. Migrating this local state to a centralized backend (which might also be hosted within the cluster) after the fact is complex, fragile, and violates our stateless workstation principle.

## Decision

We establish the following strategy for provisioning the management plane:

* **Tool Selection:** We strictly mandate the use of Ansible (specifically the `community.general.proxmox_kvm` module) to provision the initial DevBox instance directly via the Proxmox REST API during the Day-0 phase.
* **Scope Boundary:** OpenTofu is strictly reserved for Day-1+ operations (provisioning standard cluster workloads and networks) and will execute *exclusively* from within the already-bootstrapped DevBox.
* **State Management:** The DevBox will not have a Terraform/OpenTofu `.tfstate` file. Its lifecycle and state reconciliation will rely entirely on Ansible's native idempotency capabilities against the Proxmox API.

## Consequences

### Positive

* **Dependency Resolution:** Completely eliminates the circular dependency of needing an IaC execution environment to build the IaC execution environment.
* **Stateless Local Execution:** Operators can bootstrap the entire management plane from their local machines without leaving orphaned state files behind.
* **Unified Day-0 Tooling:** Consolidates the early bootstrapping phase (template generation, initial M2M cryptography, and DevBox creation) into a single, cohesive Ansible playbook execution.

### Trade-offs

* **Tooling Fragmentation:** Infrastructure provisioning logic is split between two paradigms. The management node (DevBox) is imperative/idempotent via Ansible, while the rest of the cluster infrastructure is declarative via OpenTofu.
* **State Drift Risks:** Because the DevBox lacks a declarative state file, preventing configuration drift relies heavily on perfectly crafted Ansible assertions and idempotent module parameters (e.g., injecting stable password hashes instead of plain text).
