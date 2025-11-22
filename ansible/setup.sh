#!/bin/bash
# Setup script for IoT Operations Ansible project

set -e

echo "=========================================="
echo "IoT Operations - Ansible Setup"
echo "=========================================="
echo ""

# Check if Ansible is installed
if ! command -v ansible &> /dev/null; then
    echo "Error: Ansible is not installed."
    echo "Please install Ansible first:"
    echo "  Ubuntu/Debian: sudo apt install ansible"
    echo "  macOS: brew install ansible"
    echo "  pip: pip install ansible"
    exit 1
fi

echo "✓ Ansible version: $(ansible --version | head -n1)"
echo ""

# Install Ansible Galaxy requirements
echo "Installing Ansible Galaxy requirements..."
if [ -f requirements.yml ]; then
    ansible-galaxy install -r requirements.yml
    echo "✓ Ansible Galaxy requirements installed"
else
    echo "⚠ requirements.yml not found, skipping"
fi
echo ""

# Check inventory file
if [ -f inventory/hosts.yml ]; then
    echo "✓ Inventory file exists: inventory/hosts.yml"
else
    echo "⚠ Warning: inventory/hosts.yml not found"
fi
echo ""

# Test connectivity
echo "Testing connectivity to devices..."
echo "Running: ansible all -m ping"
echo ""
if ansible all -m ping 2>/dev/null; then
    echo ""
    echo "✓ Successfully connected to all devices!"
else
    echo ""
    echo "⚠ Could not connect to some devices."
    echo "Please check:"
    echo "  1. Device IP addresses in inventory/hosts.yml"
    echo "  2. SSH access to devices"
    echo "  3. SSH keys are configured (ssh-copy-id user@device)"
fi
echo ""

echo "=========================================="
echo "Setup complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Edit inventory/hosts.yml with your device information"
echo "  2. Customize variables in group_vars/ and host_vars/"
echo "  3. Run: make ping (or ansible-playbook playbooks/ping.yml)"
echo "  4. Deploy: make deploy-all (or ansible-playbook playbooks/site.yml)"
echo ""
echo "For more information, see README.md"
echo ""
