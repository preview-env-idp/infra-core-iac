# Runbook 003: Cryptographic String Generation (Passwords & Salts)

## 1. Objective

Securely generate cryptographically strong random strings using the Linux kernel's pseudo-random number generator (`/dev/urandom`).

## 2. Execution Steps

### 2.1. Generate Infrastructure Password

Generates a high-entropy password utilizing a broad character set (including symbols) to maximize resistance against brute-force and dictionary attacks.

```bash
tr -dc 'A-Za-z0-9_!@#$%^&*()-+=' < /dev/urandom | head -c <string_lenght_in_chars> ; echo ''
```

### 2.2. Generate Cryptographic Salt (SHA-512 / crypt)

Generates a strict, POSIX-compliant salt required for Linux `/etc/shadow` password hashing (the `$6$` format). The character set is strictly limited to alphanumeric characters, periods, and slashes.

```bash
tr -dc 'A-Za-z0-9./' < /dev/urandom | head -c <string_lenght_in_chars> ; echo ''
```
