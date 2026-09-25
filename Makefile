include .env
export

.DEFAULT_GOAL := help

.PHONY: help bootstrap-pve check-bootstrap-pve bootstrap-devbox check-bootstrap-devbox

help:
	@echo "Available targets:"
	@echo "  help                - Show this help message"
	@echo "  bootstrap-pve          - Bootstrap Proxmox VE (Phase 1: Hardening) and trigger Phase 2"
	@echo "  bootstrap-devbox       - Bootstrap DevBox VM (Phase 2: Provisioning & Tooling)"
	@echo "  check-bootstrap-pve    - Dry-run for Bootstrap Proxmox VE"
	@echo "  check-bootstrap-devbox - Dry-run for Bootstrap DevBox VM"

# Day-0: Phase 1: Proxmox hardening
bootstrap-pve:
	@echo "Verifying cryptographic identity..."
	@if ssh-add -l >/dev/null 2>&1; then \
		echo "[SECURITY OK] Cryptographic identity loaded and verified."; \
	else \
		echo "[SECURITY FATAL] Cryptographic identity not established (ssh-agent unavailable or empty)."; \
		echo "Run first: eval \"\$$(ssh-agent -s)\" && ssh-add ~/.ssh/proxmox_ve"; \
		exit 1; \
	fi
	@echo "Starting Ansible (Phase 1: Proxmox Hardening)..."
	@ANSIBLE_CONFIG=src/ansible/ansible.cfg ansible-playbook src/ansible/playbooks/01-proxmox-hardening.yaml --vault-id pve_core@prompt
	@echo "Phase 1 completed. Triggering Phase 2: DevBox Provisioning..."
	@$(MAKE) bootstrap-devbox

# Day-0 Phase 1: Dry-run check for Proxmox hardening
check-bootstrap-pve:
	@echo "Verifying cryptographic identity..."
	@if ssh-add -l >/dev/null 2>&1; then \
		echo "[SECURITY OK] Cryptographic identity loaded and verified."; \
	else \
		echo "[SECURITY FATAL] Cryptographic identity not established (ssh-agent unavailable or empty)."; \
		echo "Run first: eval \"\$$(ssh-agent -s)\" && ssh-add ~/.ssh/proxmox_ve"; \
		exit 1; \
	fi
	@echo "DRY RUN: Checking hypervisor hardening."
	@echo "Starting Ansible (Phase 1: Proxmox Hardening) in check mode..."
	@ANSIBLE_CONFIG=src/ansible/ansible.cfg ansible-playbook src/ansible/playbooks/01-proxmox-hardening.yaml --vault-id pve_core@prompt --check --diff
	@echo "Phase 1 check completed. Triggering Phase 2 check: DevBox Provisioning..."
	@$(MAKE) check-bootstrap-devbox

# Day-0 Phase 2: DevBox provisioning and configuration
bootstrap-devbox:
	@echo "Starting Ansible (Phase 2: DevBox Provisioning)..."
	@ANSIBLE_CONFIG=src/ansible/ansible.cfg ansible-playbook src/ansible/playbooks/02-devbox-bootstrap.yaml --vault-id pve_core@prompt --vault-id management_plane@prompt
	@echo "Phase 2 completed."

# Day-0 Phase 2: Dry-run check for DevBox provisioning and configuration
check-bootstrap-devbox:
	@echo "DRY RUN: Checking DevBox provisioning."
	@echo "Starting Ansible (Phase 2: DevBox Provisioning) in check mode..."
	@ANSIBLE_CONFIG=src/ansible/ansible.cfg ansible-playbook src/ansible/playbooks/02-devbox-bootstrap.yaml --vault-id pve_core@prompt --vault-id management_plane@prompt --check --diff
	@echo "Phase 2 check completed."
