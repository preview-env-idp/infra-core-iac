# Runbook 004: Filling the src/ansible/group_vars/proxmox_cluster/vars.yaml

## 1. Objective

Fill the proxmox-cluster file so that pve hosts have special variables

## 2. Execution Steps

### 2.1. Fill the Gaps

Open `src/ansible/inventory/group_vars/proxmox_cluster/vars.yaml` in your preferred text editor. You need to replace the placeholder values with actual values.

* **`dmz_bridge_comment`** (optional): The comment of the proxmox brigde wich will be shown in your GUI - how it will be named is realised by `PVE_BRIGDE_NAME` in .env file.
  * *How to fill:* If you want to change it just type something alse instead of existing value.
