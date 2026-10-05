# Runbook 006: Filling the infrastructure_matrix.yaml File

## 1. Objective

Define the architecture mapping and assign unique VMIDs for Cloud-Init base templates in the Proxmox cluster. This matrix acts as the central configuration for both the Ansible provisioning pipeline and OpenTofu clones, ensuring nodes only build templates they physically support.

## 2. Execution Steps

### 2.1. Open the Matrix File

Open the `infrastructure_matrix.yaml` file located in the root directory of the repository in your preferred text editor.

### 2.2. Configure Architecture VMIDs

You need to assign a unique Proxmox Virtual Machine ID (VMID) for each architecture present in your cluster. If an architecture is not used in your physical environment, leave it empty (`{}`) to safely skip its provisioning.

* **`amd64`** (x86_64, Intel, AMD processors):
  * *Action:* If your cluster contains standard PC/Server processors, leave this at `9000` (unless this ID is already taken in your Proxmox environment).

* **`arm64`** (aarch64, Ampere, Raspberry Pi processors):
  * *Action:* If your cluster contains ARM-based nodes, you must explicitly assign a VMID by replacing `{}` with `vmid: <YOUR_NUMBER>` (e.g., `vmid: 9100`). If you do not have ARM nodes, leave it as `{}`.

*Note on VMID Selection:* Always use a high registry range (e.g., 9000+) for templates to avoid collisions with dynamically created virtual machines, which typically start from 100.
