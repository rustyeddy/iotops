# Host Variables

This directory contains host-specific variable files for individual IoT devices.

## Usage

Create a file named after your host (as defined in inventory) to set host-specific variables.

Example: `host_vars/otto-01.yml`

```yaml
---
# Host-specific variables for otto-01

otto_port: 8081
otto_log_level: debug

# Custom configuration for this specific device
device_location: "Living Room"
device_description: "Main Otto controller"
```

## File Naming

- File name must match the hostname in your inventory
- Use YAML format (.yml or .yaml extension)
- Variables defined here override group_vars and defaults
