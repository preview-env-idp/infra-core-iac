# Runbook 003: Random String Generation

## 1. Objective

Securely generate a cryptographically strong, high-entropy password (≥32 characters) for the `alcambic` machine identity and store it within an encrypted Ansible Vault, satisfying the constraints defined in ADR-005.

## 2. Execution Steps

### 2.1. Generate High-Entropy String

Generate a 32-character random string utilizing the kernel's cryptographic pseudo-random number generator (`/dev/urandom`).

```bash
tr -dc 'A-Za-z0-9_!@#$%^&*()-+=' < /dev/urandom | head -c 32 ; echo ''
```
