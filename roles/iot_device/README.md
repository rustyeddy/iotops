# IoT Device Role

This role configures and manages IoT devices in the iotops infrastructure.

## Requirements

- Ansible 2.9 or higher
- Target systems running Ubuntu, Debian, or RHEL-based distributions

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

### Device Configuration

```yaml
iot_device_name: "{{ inventory_hostname }}"
iot_device_type: sensor
iot_device_enabled: true
```

### Network Configuration

```yaml
iot_device_mqtt_broker: localhost
iot_device_mqtt_port: 1883
iot_device_mqtt_qos: 1
```

### Data Collection

```yaml
iot_device_collection_interval: 60  # seconds
iot_device_data_format: json
```

## Dependencies

None.

## Example Playbook

```yaml
- hosts: iot_devices
  roles:
    - role: iot_device
      vars:
        iot_device_type: actuator
        iot_device_mqtt_broker: mqtt.example.com
```

## License

MIT

## Author Information

IoTOps Team
