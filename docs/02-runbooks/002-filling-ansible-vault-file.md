# Runbook 002: Filling the src/ansible/group_vars/all/vault.yaml file

## 1. Objective

Initialize the Ansible Vault file from an example template, populate it with required secrets, and encrypt the file to secure sensitive data before executing infrastructure pipelines.

## 2. Execution Steps

### 2.1. Copy Template

Create the actual vault file by copying the provided example.

```bash
cp src/ansible/group_vars/all/vault.example.yaml src/ansible/group_vars/all/vault.yaml
```

### 2.2. Fill the Secrets

Open `src/ansible/group_vars/all/vault.yaml` in your preferred text editor. You need to replace the placeholder values with actual secrets.

* **`vault_alcambic_password`**: The password for the automation service account.
  * *Requirement:* Must be at least 32 characters long.
  * *How to generate:* If you do not have a secure generation method, follow [infra-core-iac/runbook 003](./003-generating-random-string.md). Paste the generated string *PASTE_GENERATED_PASSWORD_HERE*.

* **`vault_alcaambic_salt`**: The salt for the provided password above.
  * *Requirement:* Must be at least 12 characters long.
  * *How to generate:* If you do not have a secure generation method, follow [infra-core-iac/runbook 003](./003-generating-random-string.md). Paste generated string replacing the *PASTE_GENERATED_SALT_HERE*.

### 2.3. Encrypt the Vault

Once all variables are filled and the file is saved, encrypt it using Ansible Vault IDs. You will be prompted to create a Master Password for the vault. **Store this Master Password securely.**

```bash
ansible-vault encrypt src/ansible/group_vars/all/vault.yaml --vault-id pve_core@prompt
```

To verify the file is successfully encrypted, you can run `cat src/ansible/group_vars/all/vault.yaml`. You should see the `$ANSIBLE_VAULT;1.2;AES256;pve_core` header instead of plaintext YAML.

## 3. Decrypting the Vault

If from some reason you would wish to decrypt vault file (for eg. to change some values) run:

```bash
ansible-vault decrypt src/ansible/group_vars/all/vault.yaml --vault-id pve_core@prompt
```
