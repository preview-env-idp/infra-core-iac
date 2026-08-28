include .env
export

.DEFAULT_GOAL := help

.PHONY: help, bootstrap-pve

help:
	@echo "Available targets:"
	@echo "  help          - Show this help message"
	@echo "  bootstrap-pve - Bootstrap Proxmox VE"

# Day-0: Proxmox hardening and DevBox provisioning (Run ONLY from Operator's workstation)
bootstrap-pve:
	@echo "Verifying cryptographic identity..."
	@ssh-add -l >/dev/null || (echo "FATAL: No keys loaded in ssh-agent. Run first: ssh-add ~/.ssh/proxmox_ve" && exit 1)
	@echo "Starting hypervisor hardening and DevBox creation on $(PVE_NODE_01_IP)..."
	ansible-playbook -i src/ansible/inventory/hosts.yaml src/ansible/playbooks/01-proxmox-hardening.yaml --vault-id pve_core@prompt
