# iotops
IoT Operations

A comprehensive project for managing local deployment of Otto and
other IoT devices using Ansible.

## Overview

This repository provides automated deployment and configuration
management for IoT devices using Ansible. It includes:

- **Otto Device Management**: Dedicated role for deploying and managing Otto IoT devices
- **Generic IoT Device Support**: Common role for managing various IoT devices
- **Automated Configuration**: Playbooks for deployment, updates, and maintenance
- **Flexible Inventory**: Easy-to-configure inventory system for managing multiple devices

## Quick Start

### Prerequisites

- Ansible 2.9 or higher
- SSH access to IoT devices
- Python 3 on target devices

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/rustyeddy/iotops.git
   cd iotops
   ```

2. Install Ansible (if not already installed):
   ```bash
   # Ubuntu/Debian
   sudo apt update && sudo apt install ansible
   
   # macOS
   brew install ansible
   ```

3. Install required Ansible collections:
   ```bash
   cd ansible
   ansible-galaxy install -r requirements.yml
   ```

### Configuration

1. Update the inventory file with your device information:
   ```bash
   vim ansible/inventory/hosts.yml
   ```

2. Configure device-specific settings in group_vars and host_vars:
   ```bash
   vim ansible/group_vars/otto_devices.yml
   ```

3. Test connectivity to your devices:
   ```bash
   cd ansible
   ansible-playbook playbooks/ping.yml
   ```

### Usage

Deploy all devices:
```bash
cd ansible
ansible-playbook playbooks/site.yml
```

Deploy only Otto devices:
```bash
ansible-playbook playbooks/deploy_otto.yml
```

For detailed documentation, see [ansible/README.md](ansible/README.md)

## Project Structure

```
iotops/
├── ansible/                 # Ansible automation
│   ├── ansible.cfg         # Ansible configuration
│   ├── inventory/          # Device inventory
│   ├── playbooks/          # Deployment playbooks
│   ├── roles/              # Ansible roles
│   │   ├── otto/          # Otto device role
│   │   └── iot_common/    # Common IoT role
│   ├── group_vars/        # Group variables
│   ├── host_vars/         # Host-specific variables
│   └── README.md          # Detailed Ansible documentation
└── README.md              # This file
```

## Features

### Otto Device Management
- Automated installation and configuration
- System service management
- Log rotation and monitoring
- Security hardening

### Generic IoT Device Support
- Common system configuration
- NTP synchronization
- SSH security
- Package management

### Playbooks
- **site.yml**: Deploy all devices
- **deploy_otto.yml**: Deploy Otto devices
- **deploy_iot_devices.yml**: Deploy generic IoT devices
- **ping.yml**: Test device connectivity
- **gather_facts.yml**: Collect device information
- **update_system.yml**: Update system packages

## Documentation

- [Ansible Setup Guide](ansible/README.md) - Comprehensive guide for the Ansible setup
- [Otto Role Documentation](ansible/roles/otto/README.md) - Otto-specific role details
- [IoT Common Role Documentation](ansible/roles/iot_common/README.md) - Common IoT device role

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

See [LICENSE](LICENSE) file for details.
