# Development Machine Role

This Ansible role configures development machines with essential tools, programming languages, and development environments.

## Requirements

- Ansible 2.9 or higher
- SSH access to target machines
- Python 3 installed on target machines
- sudo privileges on target machines

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

### User Configuration

```yaml
dev_user: "{{ ansible_user }}"
dev_group: "{{ ansible_user }}"
dev_user_home: "/home/{{ ansible_user }}"
```

### Core Development Packages

```yaml
dev_packages:
  - build-essential
  - git
  - curl
  - wget
  - vim
  - htop
  - tree
  - tmux
  - jq
  # ... and more
```

### Programming Languages

```yaml
dev_install_languages: yes
dev_language_packages:
  - python3
  - python3-pip
  - nodejs
  - npm
  - golang-go
  - ruby
```

### Container Tools

```yaml
dev_install_containers: yes
dev_container_packages:
  - podman
  - podman-compose
  - buildah
  - skopeo
```

### Database Clients

```yaml
dev_install_databases: yes
dev_database_packages:
  - postgresql-client
  - mysql-client
  - redis-tools
  - sqlite3
```

### Python Packages

```yaml
dev_install_pip_packages: yes
dev_pip_packages:
  - ansible
  - black
  - pytest
  - virtualenv
  # ... and more
```

### Node.js Packages

```yaml
dev_install_npm_packages: yes
dev_npm_packages:
  - yarn
  - typescript
  - eslint
  - prettier
```

### Git Configuration

```yaml
dev_configure_git: yes
dev_git_config:
  - name: core.editor
    value: vim
  - name: color.ui
    value: auto
```

### Development Directories

```yaml
dev_directories:
  - "{{ dev_user_home }}/projects"
  - "{{ dev_user_home }}/workspace"
  - "{{ dev_user_home }}/.config"
```

### Shell Configuration

```yaml
dev_configure_shell: yes
dev_bash_aliases:
  - "alias ll='ls -lah'"
  - "alias gs='git status'"
  - "alias k='kubectl'"
  - "alias p='podman'"
  - "alias pc='podman-compose'"
```

## Dependencies

None

## Example Playbook

Basic usage:

```yaml
- hosts: dev_machines
  become: yes
  roles:
    - dev_machine
```

Customized configuration:

```yaml
- hosts: dev_machines
  become: yes
  roles:
    - role: dev_machine
      vars:
        dev_install_containers: yes
        dev_install_databases: no
        dev_git_config:
          - name: user.name
            value: "John Doe"
          - name: user.email
            value: "john@example.com"
```

## Features

### Development Tools
- Essential build tools and utilities
- Text editors (vim, nano)
- Terminal multiplexers (tmux, screen)
- System monitoring tools (htop)

### Programming Languages
- Python 3 with pip and virtualenv
- Node.js with npm
- Go
- Ruby

### Container Technology
- Podman (rootless container runtime)
- Podman Compose
- Buildah (container image building)
- Skopeo (container image operations)
- Automatic podman socket enablement for rootless mode

### Database Tools
- PostgreSQL client
- MySQL client
- Redis tools
- SQLite3

### Version Control
- Git with customizable configuration
- Common git aliases

### Shell Enhancements
- Custom bash aliases
- Custom bin directory in PATH
- Development-friendly shell environment

## Tags

The role supports the following tags for selective execution:

- `dev` - All development machine tasks
- `languages` - Programming language installation
- `containers` - Container tools installation
- `databases` - Database client installation
- `python` - Python package installation
- `nodejs` - Node.js package installation
- `git` - Git configuration
- `shell` - Shell configuration

### Example Usage with Tags

```bash
# Install only container tools
ansible-playbook playbooks/deploy_dev_machine.yml --tags containers

# Skip database installation
ansible-playbook playbooks/deploy_dev_machine.yml --skip-tags databases

# Install only languages and shell configuration
ansible-playbook playbooks/deploy_dev_machine.yml --tags languages,shell
```

## Customization

### Disabling Features

You can disable specific features by setting variables:

```yaml
dev_install_languages: no
dev_install_containers: no
dev_install_databases: no
dev_configure_git: no
dev_configure_shell: no
```

### Adding Custom Packages

Add your own packages to the lists:

```yaml
dev_packages:
  - build-essential
  - git
  - mycustom-package

dev_pip_packages:
  - ansible
  - mypackage
```

### Custom Git Configuration

Add your own git settings:

```yaml
dev_git_config:
  - name: user.name
    value: "Your Name"
  - name: user.email
    value: "your.email@example.com"
  - name: core.editor
    value: "vim"
```

## Security Considerations

- Podman is configured for rootless operation, providing better security isolation than Docker
- SSH server is enabled by default; ensure proper configuration
- Review and customize package lists based on your security requirements

## Platform Support

This role is tested on:
- Ubuntu 20.04 (Focal)
- Ubuntu 22.04 (Jammy)
- Debian 10 (Buster)
- Debian 11 (Bullseye)
- RHEL/CentOS 8 and 9

## License

See repository LICENSE file

## Author Information

Created for iotops project
