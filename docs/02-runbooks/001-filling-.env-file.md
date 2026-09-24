# Filling .env File

## 1. Objective

Fill the .env file so that ansible scripts would know what to do exactly as you want.

## 2. Execution Steps

### 2.1 Copy .env.example file to .env

Create the actual .env file by copying the provided example.

```bash
cp .env.example .env
```

### 2.2 Fill the gaps

Open src/ansible/group_vars/all/vault.yaml in your preferred text editor. You need to fill values with apriopriate data:

* **`PVE_NODE_01_IP`**: static proxmox IP adress given in instalation. Ansible will use it to connect to the appropriate machine.

* **`DEVBOX_IP`**: static IP adress for management machine which will be created on proxmox. This machine will be used for example for OpenTofu.

* **`PVE_DMZ_BRIDGE_NAME`** (optional): name of proxmox bridge that will be created to make DMZ to prevent potential intrusion from machines that will be created by developers. Don't have to be changed unless you already have such bridge or wish to make it on bridge named other.
