# ADR-001: Underlay Infrastructure Tool Stack Selection

## Status

Accepted

## Context

This repository governs Layer 1 (Underlay) of the **Alcambic** Internal Developer Platform. It is strictly responsible for bare-metal hypervisor management, OS-level security hardening, virtual network topology, and programmatic infrastructure provisioning.

Operating ephemeral preview environments on owned hardware requires technologies designed for resource efficiency, programmatic automation, and licensing safety. Selecting proprietary virtualization platforms or legacy IaC engines introduces licensing instability and unnecessary overhead for ephemeral workloads.

## Decision: Tool Stack Selection & Justification

We adopt a strictly evaluated **Open-Source / Cloud Native Computing Foundation (CNCF)** tool stack for all Layer 1 infrastructure operations:

| Tool | Role | Justification |
| :--- | :--- | :--- |
| **Proxmox VE** | Bare-Metal Hypervisor | Fully open-source (Debian/KVM-based), eliminating public cloud operational expenditure (OpEx) for ephemeral workloads and insulating the platform from proprietary virtualization licensing changes (e.g., VMware/Broadcom). Provides native API access for automated storage and network provisioning. |
| **OpenTofu** | Infrastructure as Code | A Linux Foundation / CNCF-backed open-source engine chosen over HashiCorp Terraform following its transition to the proprietary Business Source License (BSL). Guarantees permanent open-source governance and 100% HCL feature compatibility. |
| **K3s** | Kubernetes Engine | A CNCF-certified, highly optimized Kubernetes distribution. By stripping out legacy cloud-provider modules and condensing control plane components into a single binary, it achieves a significantly lower memory and CPU footprint compared to upstream Kubernetes distributions, maximizing hardware resources for tenant workloads. |
| **SOPS + Age** | Secrets Management | Eliminates the operational overhead of managing and backing up a stateful external secrets server (e.g., HashiCorp Vault) on bare-metal. Secrets are safely committed as encrypted ciphertext directly inside Git, fully adhering to GitOps principles. |
| **ArgoCD** | Continuous Delivery / GitOps | Operates on a secure Pull-based reconciliation loop inside the isolated cluster DMZ. It eliminates the need to expose cluster admin credentials to external CI/CD runners and automatically corrects configuration drift. |

## Consequences

### Positive

* **License & Vendor Independence:** The entire Underlay stack relies on Apache 2.0, MIT, and Linux Foundation projects, insulating the platform from commercial licensing changes and vendor lock-in.
* **Maximum Compute Density:** Lightweight distributions like K3s and native KVM virtualization leave over 90% of bare-metal RAM and CPU compute cycles available for actual tenant preview environments.
* **Declarative Reproducibility:** Every host configuration, virtual network bridge, and VM template is defined as code, allowing rapid disaster recovery and node rebuilding from scratch.

### Trade-offs

* **Operational Overhead:** The platform engineer must maintain local runbooks (`02-runbooks/`) and automated scripts to manage host security updates, disk cleanups, and storage limits directly on the physical machines.
