# Infrastructure & Underlay as Code (`infra-core-iac`)

## Purpose & Scope
This repository governs Layer 1 (Underlay) of the **Alcambic** Internal Developer Platform. It is strictly dedicated to bare-metal hypervisor configuration, OS-level security hardening, virtual networking topology, and infrastructure provisioning.

By enforcing strict Separation of Duties (SoD), this repository forms an isolated security boundary. Application workloads and Kubernetes control plane operators have **zero write access** to these definitions, preventing lateral movement or unauthorized privilege escalation to the physical hypervisor layer.

## Repository Taxonomy (Directory Structure)

```text
infra-core-iac/
├── README.md
├── docs/
│   ├── 01-architecture/       # Lokalne ADR-y dla pod warstwy sprzętowej (Underlay)
│   ├── 02-runbooks/           # Standard Operating Procedures, node bootstrapping, and recovery
│   └── 03-security/           # Bare-metal storage limits, OS hardening baselines, and firewall rules
├── src/
│   ├── proxmox/               # Host-level scripts, networking bridges, and systemd overrides
│   │   ├── hardening/         # OS hardening (journald limits, kernel cleanup, SSH rules)
│   │   └── network/           # Linux L2/L3 bridge topologies and declarative firewalls
│   └── tofu/                  # OpenTofu HCL definitions for automated VM/LXC provisioning
└── .gitignore                 # Exclusions for OpenTofu state, secrets, and local logs
```
