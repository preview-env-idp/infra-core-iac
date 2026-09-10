# ADR-005: Cryptographic Hashing Algorithm Selection for IaC Secret Management

## Status

Accepted

## Context

The target hypervisor (Proxmox VE) defaults to the `yescrypt` algorithm for password hashing via PAM. Within our GitOps pipeline, Ansible is responsible for declaratively provisioning the `alcambic` service account and injecting its vault-encrypted password into `/etc/shadow`.
Modern local execution environments (Python 3.13+) have completely removed the built-in `crypt` module. Attempting to force `yescrypt` via local shell execution (e.g., using `mkpasswd`) generates a new salt on every run, which fundamentally breaks Ansible's state reconciliation (idempotency) and pollutes audit logs with false-positive `changed` states.

## Decision

We establish the following parameters for password hashing during Day-0/Day-1 provisioning:

* **Algorithm Selection:** We strictly mandate the use of `sha512` (via the Ansible `password_hash('sha512')` filter) for all OS-level passwords managed via IaC.
* **Idempotency Enforcement:** We reject local shell workarounds. Password state evaluation must be natively handled by the Ansible `user` module to ensure zero configuration drift.
* **Cryptographic Mitigation:** To offset SHA-512's lack of memory-hard protections (vulnerability to GPU-accelerated brute-force attacks), we mandate that the plaintext input password for the `alcambic` account must be a minimum of 32 characters, machine-generated via `/dev/urandom` (yielding >190 bits of entropy); also salt has to be minimum 12 charactes long.

## Consequences

### Positive

* **Guaranteed Idempotency:** The pipeline will correctly recognize unchanged passwords and report a clean `ok` state, preserving the integrity of GitOps drift detection.
* **Reduced Dependency Hell:** Operators only require the standard `passlib` Python package on their Bastion host, avoiding complex C-based cryptographic library compilations.
* **Native Compatibility:** Proxmox/Debian PAM fully supports and authenticates `$6$` (SHA-512) prefixed hashes out-of-the-box.

### Trade-offs

* **Perceived Cryptographic Downgrade:** Utilizing SHA-512 instead of the OS-default `yescrypt` deviates from modern baseline defaults, requiring explicit justification during security audits.
* **Hard Dependency on Entropy:** The security model relies entirely on the strict enforcement of the high-entropy input rule; a weak human-generated password would immediately render the SHA-512 hash vulnerable.
