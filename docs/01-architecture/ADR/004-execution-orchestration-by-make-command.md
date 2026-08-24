# ADR-004: Execution Orchestration & Operator Environment Isolation

## Status

Accepted

## Context

Executing multi-parameter infrastructure-as-code commands (e.g., `ansible-playbook` with dynamic inventories and vault integrations) directly from the operator's terminal introduces operational friction and human error. Furthermore, manual execution risks interactive prompt hangs (e.g., missing SSH keys) and pollutes the operator's local shell history (`.bash_history`/`.zsh_history`) with execution contexts. A deterministic, decoupled entrypoint is required to standardize Day-0 bootstrapping.

## Decision

We establish the following execution boundaries for the operator's workstation using `make`:

* **Universal Command Wrapper:** We adopt a single `Makefile` as the exclusive entrypoint for Day-0 infrastructure provisioning, abstracting complex CLI arguments away from the operator.
* **Fail-Fast Cryptographic Validation:** We enforce pre-flight identity checks (`ssh-add -l`) within the Makefile targets. The execution pipeline will immediately abort if the operator's decrypted Ed25519 key is absent from the `ssh-agent`, preventing interactive connection timeouts.
* **Subshell Environment Isolation:** We utilize Make's `include` and `export` directives to dynamically inject non-versioned configuration (from `.env`) strictly into the ephemeral memory (RAM) of a subshell. This prevents environment variable bleeding into the operator's persistent OS session.
* **Filesystem Conflict Mitigation:** We enforce `.PHONY` declarations for all execution targets to guarantee deterministic execution, regardless of potential naming collisions in the local filesystem.

## Consequences

### Positive

* Eliminates human error related to CLI flag omissions and typos during infrastructure initialization.
* Prevents potential credential/parameter leakage into persistent shell histories.
* Enforces strict SSH-agent usage, eliminating interactive passphrase prompts during automated runs.
* Standardizes the "Golden Path" for new engineers onboarding to the platform.

### Trade-offs

* Introduces `make` as a hard system dependency on the operator's local workstation.
* Obscures the underlying toolchain complexity (Ansible/OpenTofu) from junior operators who only interact with the `make` commands.
