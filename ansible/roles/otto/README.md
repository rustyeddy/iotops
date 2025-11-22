# Otto Role

This Ansible role manages the deployment and configuration of Otto IoT devices.

## Requirements

- Ansible 2.9 or higher
- SSH access to Otto devices
- Python 3 installed on target devices

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

```yaml
otto_user: otto
otto_home: /home/otto
otto_config_dir: /etc/otto
otto_log_dir: /var/log/otto
```

## Dependencies

None

## Example Playbook

```yaml
- hosts: otto_devices
  roles:
    - otto
```

## License

See repository LICENSE file

## Author Information

Created for iotops project
