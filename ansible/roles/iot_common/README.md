# IoT Common Role

This Ansible role provides common configuration and management for generic IoT devices.

## Requirements

- Ansible 2.9 or higher
- SSH access to IoT devices
- Python 3 installed on target devices

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

```yaml
iot_common_packages: []
iot_timezone: UTC
iot_ntp_enabled: yes
```

## Dependencies

None

## Example Playbook

```yaml
- hosts: iot_devices
  roles:
    - iot_common
```

## License

See repository LICENSE file

## Author Information

Created for iotops project
