# Quick Start Guide

Get started with the iotops Ansible project in 5 minutes!

## Prerequisites

- Ansible 2.9+ installed
- SSH access to target hosts
- Python 3.8+ on control machine

## Step 1: Install Dependencies

```bash
# Using pip
pip install ansible ansible-lint

# Or using the Makefile
make install
```

## Step 2: Configure Your Inventory

Edit `inventory/hosts.yml` to match your infrastructure:

```yaml
all:
  children:
    production:
      children:
        iot_devices:
          hosts:
            your-device-01:
              ansible_host: 192.168.1.101
```

## Step 3: Set Your Variables

Edit `inventory/group_vars/all.yml` for common settings:

```yaml
ansible_user: your_user
timezone: America/New_York
```

## Step 4: Test Connectivity

```bash
# Using Ansible
ansible all -m ping

# Or using Makefile
make ping
```

## Step 5: Run Playbooks

```bash
# Check what would change (dry-run)
ansible-playbook playbooks/site.yml --check

# Apply configuration
ansible-playbook playbooks/site.yml

# Or use Makefile shortcuts
make check  # Dry-run
make site   # Apply all
make devices  # Only devices
```

## Common Commands

### Using Make (Recommended)

```bash
make help         # Show all available commands
make syntax       # Check syntax
make lint         # Lint playbooks
make test         # Run syntax and lint
make list-hosts   # Show all hosts
make list-tags    # Show available tags
```

### Using Ansible Directly

```bash
# Run specific playbook
ansible-playbook playbooks/iot_devices.yml

# Run with tags
ansible-playbook playbooks/site.yml --tags setup

# Limit to specific hosts
ansible-playbook playbooks/site.yml --limit iot-device-01

# Verbose output
ansible-playbook playbooks/site.yml -vv
```

## Project Structure Overview

```
iotops/
├── ansible.cfg              # Configuration
├── inventory/
│   ├── hosts.yml           # Your infrastructure
│   └── group_vars/         # Variables
├── playbooks/              # What to run
│   └── site.yml           # Main playbook
└── roles/                  # Reusable components
    └── iot_device/        # Example role
```

## Next Steps

1. **Customize Variables**: Edit `inventory/group_vars/*.yml` for your environment
2. **Modify Playbooks**: Adjust `playbooks/*.yml` for your needs
3. **Create Roles**: Add new roles in `roles/` directory
4. **Add Secrets**: Use Ansible Vault for sensitive data

## Getting Help

- Read [README.md](README.md) for complete documentation
- Check [ANSIBLE_GUIDE.md](ANSIBLE_GUIDE.md) for best practices
- Review role documentation in `roles/*/README.md`

## Troubleshooting

### Connection Issues

```bash
# Test SSH access
ssh user@host

# Check Ansible configuration
ansible-config dump
```

### Permission Issues

```bash
# Verify sudo access
ansible all -m shell -a "sudo whoami" --ask-become-pass
```

### Debug Playbook

```bash
# Very verbose output
ansible-playbook playbooks/site.yml -vvv

# Check mode with diff
ansible-playbook playbooks/site.yml --check --diff
```

## Security Best Practices

1. **Use Vault for Secrets**
   ```bash
   ansible-vault create inventory/group_vars/production/vault.yml
   ansible-playbook playbooks/site.yml --ask-vault-pass
   ```

2. **Use SSH Keys** (not passwords)
   ```bash
   ssh-copy-id user@host
   ```

3. **Limit Access**
   - Use dedicated Ansible user
   - Configure sudo properly
   - Restrict SSH access

## Tips

- Always test in staging before production
- Use check mode (`--check`) before applying changes
- Tag your tasks for selective execution
- Keep playbooks idempotent
- Version control everything (except secrets)

Happy automating! 🚀
