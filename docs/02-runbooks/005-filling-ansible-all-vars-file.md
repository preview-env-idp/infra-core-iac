# Runbook 005: Filling the src/ansible/group_vars/all/vars.yaml file

## 1. Objective

Populate the file with necessary variables and change optional ones.

## 2. Execution Steps

### 2.1. Fill the Gaps

Open `src/ansible/inventory/group_vars/all/vars.yaml` in your preferred text editor. You need to replace the placeholder empty strings `""` with actual values.

* **`management_subnet_cidr`**: The internal network IP address pool with its subnet mask.
  * *How to fill:* Between the quotes, type your internal management subnet in CIDR notation (e.g., `"192.168.0.0/24"`). This is crucial so as not to deprive yourself of access to Proxmox after the firewall is set up. Only the subnet specified here will maintain administrative access to the Proxmox GUI and SSH.
* **`management_subnet_gateway`**: The default gateway IP address for your management network.
  * *How to fill:* Between the quotes, type the IP address of your router or firewall gateway for the management subnet (e.g., `"192.168.0.1"`). This is required for the DevBox provisioning process to correctly set up network routing and internet access for the bootstrap node.
