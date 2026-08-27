# Filling .env File

## 1. Objective

Fill the .env file so that ansible scripts would know what to do exactly as you want.

## 2. Execution Steps

### 2.1 Copy .env.example file to .env

Run in your terminal `cp .env.example .env` to copy example file with it's content co dedicated .env file.

### 2.2 Fill the gaps

`PVE_NODE_01_IP` - static proxmox IP adress given in instalation. Ansible will use it to connect to the appropriate machine.
