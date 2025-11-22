# Quick Start Guide - IoT Operations

This guide will help you get started with managing your Otto and IoT devices using Ansible in just a few minutes.

## Prerequisites

Before you begin, ensure you have:

1. **Ansible installed** (version 2.9+)
2. **SSH access** to your IoT devices
3. **Python 3** installed on target devices
4. **SSH keys** configured for passwordless authentication

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/rustyeddy/iotops.git
cd iotops
```

### 2. Run the Setup Script

```bash
cd ansible
./setup.sh
```

This will:
- Verify Ansible installation
- Install required Ansible Galaxy collections
- Check connectivity to your devices

### 3. Configure Your Devices

Edit the inventory file to add your devices:

```bash
vim ansible/inventory/hosts.yml
```

Example configuration:

```yaml
otto_devices:
  hosts:
    otto-01:
      ansible_host: 192.168.1.101
      ansible_user: otto
      ansible_ssh_private_key_file: ~/.ssh/id_rsa
```

### 4. Test Connectivity

```bash
cd ansible
make ping
# or
ansible-playbook playbooks/ping.yml
```

### 5. Deploy Your Devices

Deploy all devices:
```bash
make deploy-all
# or
ansible-playbook playbooks/site.yml
```

Deploy only Otto devices:
```bash
make deploy-otto
# or
ansible-playbook playbooks/deploy_otto.yml
```

## Common Commands

### Using Makefile (Recommended)

```bash
cd ansible

# Test connectivity
make ping

# Gather device information
make facts

# Deploy all devices
make deploy-all

# Deploy only Otto devices
make deploy-otto

# Deploy only IoT devices
make deploy-iot

# Update system packages
make update

# Dry run (check mode)
make check

# Target specific device
make deploy-otto LIMIT=otto-01

# Use specific tags
make deploy-otto TAGS=firewall
```

### Using ansible-playbook Directly

```bash
cd ansible

# Test connectivity
ansible-playbook playbooks/ping.yml

# Deploy Otto devices
ansible-playbook playbooks/deploy_otto.yml

# Target specific host
ansible-playbook playbooks/deploy_otto.yml --limit otto-01

# Dry run
ansible-playbook playbooks/site.yml --check

# Verbose output
ansible-playbook playbooks/site.yml -vv
```

## Configuration

### Group Variables

Edit configuration for all devices in a group:

```bash
# Otto devices
vim ansible/group_vars/otto_devices.yml

# Generic IoT devices
vim ansible/group_vars/iot_devices.yml

# All devices
vim ansible/group_vars/all.yml
```

### Host-Specific Variables

Create device-specific configuration:

```bash
cp ansible/host_vars/otto-01.yml.example ansible/host_vars/otto-01.yml
vim ansible/host_vars/otto-01.yml
```

## Customization

### Modify Otto Role Defaults

```bash
vim ansible/roles/otto/defaults/main.yml
```

Common settings:
- `otto_port`: Application port (default: 8080)
- `otto_log_level`: Logging level (default: info)
- `otto_version`: Otto version to deploy

### Add New Devices

1. Add to inventory:
   ```bash
   vim ansible/inventory/hosts.yml
   ```

2. (Optional) Create host variables:
   ```bash
   vim ansible/host_vars/new-device.yml
   ```

3. Deploy:
   ```bash
   ansible-playbook playbooks/deploy_otto.yml --limit new-device
   ```

## Troubleshooting

### SSH Connection Failed

```bash
# Test SSH manually
ssh user@device-ip

# Check Ansible can reach the host
ansible device-name -m ping

# Use verbose mode
ansible-playbook playbooks/ping.yml -vvv
```

### Python Not Found on Target

Install Python 3 on the target device:
```bash
ssh user@device-ip
sudo apt install python3  # Ubuntu/Debian
sudo yum install python3  # RedHat/CentOS
```

### Permission Denied

Ensure your user has sudo privileges:
```bash
# On target device
sudo usermod -aG sudo username
```

## Next Steps

- Read the full [Ansible documentation](ansible/README.md)
- Explore the [Otto role](ansible/roles/otto/README.md)
- Customize playbooks for your specific needs
- Set up automated deployments

## Getting Help

- Check [ansible/README.md](ansible/README.md) for detailed documentation
- Review role documentation in `ansible/roles/*/README.md`
- Consult [Ansible documentation](https://docs.ansible.com)

## Security Tips

1. Use SSH keys instead of passwords
2. Don't commit sensitive data to git
3. Use Ansible Vault for secrets:
   ```bash
   ansible-vault encrypt group_vars/sensitive.yml
   ```
4. Keep your devices updated:
   ```bash
   make update
   ```
