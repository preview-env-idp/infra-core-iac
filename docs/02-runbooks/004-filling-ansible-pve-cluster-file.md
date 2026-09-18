# Runbook 002: Filling the src/ansible/group_vars/all/vault.yaml file

## 1. Objective

Fill the proxmox-cluster file so that pve hosts have special variables

## 2. Execution Steps

### 2.1. Fill the Gaps

Open `src/ansible/inventory/group_vars/proxmox_cluster/vars.yaml` in your preferred text editor. You need to replace the placeholder values with actual values.

* **`management_subnet_cidr`**: The internal network IP with its mask.
  * *How to fill:* In brackets type your internal CIDR (like 192.168.0.0/24) - it's cruicial so as not to deprive yourself of access to proxmox after firewall set up. Only IPs specified here will have access to proxmox after.

* **`dmz_bridge_comment`**: The comment of the proxmox brigde wich will be shown in your GUI - how it will be named is realised by `PVE_BRIGDE_NAME` in .env file.
  * *How to fill:* You don't have to change it if you accept brigde will be commented as it says. If you want to change it just type something alse instead.
