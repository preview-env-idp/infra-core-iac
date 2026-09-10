# Runbook 003: Random String Generation

## 1. Objective

Securely generate a cryptographically strong random string.

## 2. Execution Steps

### 2.1. Generate  String

Generate a x-character random string utilizing the kernel's cryptographic pseudo-random number generator (`/dev/urandom`).

```bash
tr -dc 'A-Za-z0-9_!@#$%^&*()-+=' < /dev/urandom | head -c <string_lenght_in_chars> ; echo ''
```
