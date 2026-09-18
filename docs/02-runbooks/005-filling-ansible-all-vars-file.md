# Runbook 005: Filling the src/ansible/group_vars/all/vars.yaml file

## 1. Objective

Populate the file with neccessary variables and change optional.

## 2. Execution Steps

### 2.1. Fill the Gaps

Open `src/ansible/inventory/group_vars/all/vars.yaml` in your preferred text editor. You need to replace the placeholder values with actual values.

* **`management_subnet_cidr`**: The internal network IP with its mask.
  * *How to fill:* In brackets type your internal CIDR (like 192.168.0.0/24) - it's cruicial so as not to deprive yourself of access to proxmox after firewall set up. Only IPs specified here will have access to proxmox after.
