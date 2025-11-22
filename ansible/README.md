# IoT Operations - Ansible Deployment

This directory contains Ansible playbooks and roles for managing local deployment of Otto and other IoT devices.

## Directory Structure

```
ansible/
├── ansible.cfg           # Ansible configuration
├── inventory/            # Inventory files
│   └── hosts.yml        # Main inventory file
├── playbooks/           # Ansible playbooks
│   ├── site.yml         # Main site playbook
│   ├── deploy_otto.yml  # Otto deployment
│   ├── deploy_iot_devices.yml
│   ├── ping.yml         # Connectivity test
│   ├── gather_facts.yml # Device information
│   └── update_system.yml # System updates
├── roles/               # Ansible roles
│   ├── otto/           # Otto device role
│   └── iot_common/     # Common IoT device role
├── group_vars/         # Group variables
│   ├── all.yml
│   ├── otto_devices.yml
│   └── iot_devices.yml
└── host_vars/          # Host-specific variables
```

## Prerequisites

1. **Install Ansible**
   ```bash
   # Ubuntu/Debian
   sudo apt update
   sudo apt install ansible
   
   # macOS
   brew install ansible
   
   # Python pip
   pip install ansible
   ```

2. **SSH Access**
   - Ensure you have SSH access to all IoT devices
   - Configure SSH keys for passwordless authentication:
     ```bash
     ssh-copy-id user@device-ip
     ```

3. **Python on Target Devices**
   - Python 3 must be installed on all target IoT devices

## Configuration

### 1. Update Inventory

Edit `inventory/hosts.yml` to define your IoT devices:

```yaml
otto_devices:
  hosts:
    otto-01:
      ansible_host: 192.168.1.101
      ansible_user: otto
```

### 2. Configure Variables

- **Group Variables**: Edit files in `group_vars/` for group-wide settings
- **Host Variables**: Create files in `host_vars/` for device-specific settings

### 3. Customize Roles

- **Otto Role**: Modify `roles/otto/` for Otto-specific configuration
- **IoT Common Role**: Modify `roles/iot_common/` for common device settings

## Usage

All commands should be run from the `ansible/` directory:

```bash
cd ansible/
```

### Test Connectivity

```bash
ansible-playbook playbooks/ping.yml
```

### Gather Device Information

```bash
ansible-playbook playbooks/gather_facts.yml
```

### Deploy All Devices

```bash
ansible-playbook playbooks/site.yml
```

### Deploy Only Otto Devices

```bash
ansible-playbook playbooks/deploy_otto.yml
```

### Deploy Only Generic IoT Devices

```bash
ansible-playbook playbooks/deploy_iot_devices.yml
```

### Update System Packages

```bash
ansible-playbook playbooks/update_system.yml
```

### Target Specific Hosts

```bash
# Target single host
ansible-playbook playbooks/deploy_otto.yml --limit otto-01

# Target multiple hosts
ansible-playbook playbooks/deploy_otto.yml --limit otto-01,otto-02

# Target specific group
ansible-playbook playbooks/site.yml --limit otto_devices
```

### Use Tags

```bash
# Run only specific tags
ansible-playbook playbooks/deploy_otto.yml --tags otto

# Skip specific tags
ansible-playbook playbooks/deploy_otto.yml --skip-tags firewall
```

### Check Mode (Dry Run)

```bash
ansible-playbook playbooks/site.yml --check
```

### Verbose Output

```bash
# Increase verbosity (use -v, -vv, -vvv, or -vvvv)
ansible-playbook playbooks/site.yml -vv
```

## Common Tasks

### Add a New Otto Device

1. Add the device to `inventory/hosts.yml`:
   ```yaml
   otto_devices:
     hosts:
       otto-02:
         ansible_host: 192.168.1.102
         ansible_user: otto
   ```

2. (Optional) Create host-specific variables in `host_vars/otto-02.yml`

3. Deploy to the new device:
   ```bash
   ansible-playbook playbooks/deploy_otto.yml --limit otto-02
   ```

### Add a New IoT Device Type

1. Create a new role:
   ```bash
   mkdir -p roles/my_device/{tasks,handlers,templates,defaults,meta}
   ```

2. Define role tasks in `roles/my_device/tasks/main.yml`

3. Create a playbook in `playbooks/deploy_my_device.yml`

4. Update inventory and variables as needed

### Update Otto Configuration

1. Modify `roles/otto/defaults/main.yml` or group/host variables

2. Re-run the playbook:
   ```bash
   ansible-playbook playbooks/deploy_otto.yml
   ```

## Troubleshooting

### SSH Connection Issues

```bash
# Test SSH connection manually
ssh user@device-ip

# Check Ansible can reach host
ansible otto-01 -m ping

# Use verbose mode to debug
ansible-playbook playbooks/ping.yml -vvv
```

### Permission Issues

- Ensure the ansible user has sudo privileges on target devices
- Check `ansible.cfg` for privilege escalation settings

### Fact Gathering Failures

- Verify Python 3 is installed on target devices
- Check firewall settings allow SSH connections

## Security Best Practices

1. **Use SSH Keys**: Never use password authentication in production
2. **Limit sudo Access**: Grant only necessary privileges
3. **Encrypt Sensitive Data**: Use Ansible Vault for passwords and keys
   ```bash
   ansible-vault encrypt group_vars/otto_devices.yml
   ```
4. **Regular Updates**: Keep devices and packages up to date
5. **Firewall Configuration**: Enable firewalls on all devices

## Advanced Topics

### Using Ansible Vault

Encrypt sensitive variables:

```bash
# Encrypt a file
ansible-vault encrypt group_vars/otto_devices.yml

# Edit encrypted file
ansible-vault edit group_vars/otto_devices.yml

# Run playbook with vault
ansible-playbook playbooks/site.yml --ask-vault-pass
```

### Dynamic Inventory

For large deployments, consider using dynamic inventory scripts or plugins.

### Ansible Galaxy Roles

Install community roles:

```bash
ansible-galaxy install -r requirements.yml
```

## Support

For issues or questions:
- Check Ansible documentation: https://docs.ansible.com
- Review role README files in `roles/*/README.md`
- Open an issue in the repository

## License

See repository LICENSE file
