# iotops - IoT Operations

This repository contains Ansible automation for managing IoT infrastructure, including devices, gateways, and servers.

## Overview

The iotops project provides a comprehensive Ansible framework for deploying and managing IoT infrastructure at scale. It follows Ansible best practices and provides a flexible, modular structure for managing various IoT components.

## Prerequisites

- Ansible 2.9 or higher
- Python 3.8+
- SSH access to target hosts
- Sudo privileges on target hosts

## Quick Start

### 1. Install Ansible

```bash
pip install ansible
```

### 2. Install Required Collections

```bash
ansible-galaxy install -r requirements.yml
```

### 3. Configure Inventory

Edit the inventory file to match your infrastructure:

```bash
vim inventory/hosts.yml
```

### 4. Configure Variables

Update group variables for your environment:

```bash
vim inventory/group_vars/all.yml
vim inventory/group_vars/production.yml
vim inventory/group_vars/staging.yml
```

### 5. Run Playbooks

Run the entire site configuration:

```bash
ansible-playbook playbooks/site.yml
```

Or run specific playbooks:

```bash
# Configure only IoT devices
ansible-playbook playbooks/iot_devices.yml

# Configure only gateways
ansible-playbook playbooks/iot_gateways.yml

# Configure only servers
ansible-playbook playbooks/iot_servers.yml
```

## Project Structure

```
.
├── ansible.cfg                 # Ansible configuration
├── inventory/                  # Inventory files
│   ├── hosts.yml              # Main inventory
│   ├── group_vars/            # Group variables
│   │   ├── all.yml           # Variables for all hosts
│   │   ├── production.yml    # Production environment vars
│   │   └── staging.yml       # Staging environment vars
│   └── host_vars/            # Host-specific variables
├── playbooks/                  # Playbook files
│   ├── site.yml              # Master playbook
│   ├── iot_devices.yml       # IoT device playbook
│   ├── iot_gateways.yml      # Gateway playbook
│   └── iot_servers.yml       # Server playbook
├── roles/                      # Ansible roles
│   └── iot_device/           # Example IoT device role
│       ├── defaults/         # Default variables
│       ├── files/            # Static files
│       ├── handlers/         # Handlers
│       ├── meta/             # Role metadata
│       ├── tasks/            # Tasks
│       ├── templates/        # Jinja2 templates
│       └── vars/             # Role variables
├── files/                      # Global files
├── templates/                  # Global templates
├── filter_plugins/            # Custom filter plugins
├── library/                    # Custom modules
└── requirements.yml           # Galaxy requirements
```

## Common Tasks

### Check Connectivity

```bash
ansible all -m ping
```

### Run in Check Mode (Dry Run)

```bash
ansible-playbook playbooks/site.yml --check
```

### Run with Tags

```bash
# Only run setup tasks
ansible-playbook playbooks/iot_devices.yml --tags setup

# Skip specific tasks
ansible-playbook playbooks/iot_devices.yml --skip-tags packages
```

### Limit to Specific Hosts

```bash
ansible-playbook playbooks/site.yml --limit iot-device-01
ansible-playbook playbooks/site.yml --limit production
```

### View Available Tags

```bash
ansible-playbook playbooks/site.yml --list-tags
```

## Configuration

### Ansible Configuration

The `ansible.cfg` file contains project-wide Ansible settings. Key configurations:

- Inventory location
- SSH settings
- Logging configuration
- Performance tuning

### Inventory Management

The inventory is organized by environment (production, staging) and component type (devices, gateways, servers). Each host can have specific variables defined in `host_vars/`.

### Variable Precedence

Variables can be defined at multiple levels (from lowest to highest precedence):

1. Role defaults (`roles/*/defaults/main.yml`)
2. Group vars all (`inventory/group_vars/all.yml`)
3. Group vars specific (`inventory/group_vars/<group>.yml`)
4. Host vars (`inventory/host_vars/<host>.yml`)
5. Playbook vars
6. Extra vars (command line `-e`)

## Roles

### iot_device

Configures and manages IoT devices. See `roles/iot_device/README.md` for detailed documentation.

**Usage:**

```yaml
- hosts: iot_devices
  roles:
    - role: iot_device
      vars:
        iot_device_type: sensor
        iot_device_mqtt_broker: mqtt.example.com
```

## Security

### Ansible Vault

Sensitive data should be encrypted using Ansible Vault:

```bash
# Create encrypted file
ansible-vault create inventory/group_vars/production/vault.yml

# Edit encrypted file
ansible-vault edit inventory/group_vars/production/vault.yml

# Run playbook with vault
ansible-playbook playbooks/site.yml --ask-vault-pass
```

### Best Practices

- Never commit sensitive data unencrypted
- Use Ansible Vault for passwords, API keys, certificates
- Limit SSH access to specific users
- Use sudo for privilege escalation
- Keep Ansible and collections up to date

## Testing

### Syntax Check

```bash
ansible-playbook playbooks/site.yml --syntax-check
```

### Lint Playbooks

```bash
ansible-lint playbooks/*.yml
```

### Verify Connectivity

```bash
ansible all -m ping -i inventory/hosts.yml
```

## Troubleshooting

### Enable Verbose Output

```bash
ansible-playbook playbooks/site.yml -v    # verbose
ansible-playbook playbooks/site.yml -vv   # more verbose
ansible-playbook playbooks/site.yml -vvv  # very verbose
ansible-playbook playbooks/site.yml -vvvv # debug level
```

### Check Variable Values

```bash
ansible all -m debug -a "var=hostvars[inventory_hostname]"
```

### View Gathered Facts

```bash
ansible all -m setup
```

## Contributing

When adding new roles or playbooks:

1. Follow the existing directory structure
2. Document all variables in role README files
3. Use meaningful task names
4. Add appropriate tags for selective execution
5. Test changes in staging before production

## License

MIT

## Support

For issues and questions, please open an issue in the repository.
