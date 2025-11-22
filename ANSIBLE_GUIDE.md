# Ansible Best Practices Guide for iotops

This guide outlines the best practices followed in this Ansible project.

## Directory Structure

### Standard Layout

We follow the Ansible recommended directory structure:

- **inventory/** - Contains all inventory files and variables
- **playbooks/** - All playbook files
- **roles/** - Reusable roles following Ansible Galaxy structure
- **files/** - Static files to be copied to remote hosts
- **templates/** - Jinja2 templates for dynamic configuration
- **filter_plugins/** - Custom Jinja2 filters
- **library/** - Custom Ansible modules

## Naming Conventions

### Files and Directories

- Use lowercase with underscores for file and directory names
- Playbook files: `<purpose>.yml` (e.g., `iot_devices.yml`)
- Role names: lowercase with underscores (e.g., `iot_device`)
- Variable files: lowercase (e.g., `main.yml`, `debian.yml`)

### Variables

- Use descriptive, lowercase names with underscores
- Prefix role-specific variables with role name (e.g., `iot_device_enabled`)
- Use `ansible_` prefix for Ansible-specific variables
- Boolean variables should be obvious (e.g., `enabled`, `disabled`)

### Tasks and Plays

- Start task names with a capital letter
- Use descriptive names that explain what the task does
- Group related tasks with tags

## Variable Management

### Hierarchy

1. **defaults/main.yml** - Default values, lowest precedence
2. **group_vars/all.yml** - Variables for all hosts
3. **group_vars/<group>.yml** - Group-specific variables
4. **host_vars/<host>.yml** - Host-specific variables
5. **Playbook vars** - Variables in playbooks
6. **Extra vars** - Command-line variables (highest precedence)

### Sensitive Data

- Always use Ansible Vault for sensitive data
- Create separate vault files (e.g., `vault.yml`)
- Never commit unencrypted secrets
- Use vault password files for automation

Example structure:
```
group_vars/
  production/
    vars.yml        # Non-sensitive vars
    vault.yml       # Encrypted sensitive vars
```

## Role Development

### Structure

Each role should follow this structure:

```
roles/role_name/
├── README.md           # Role documentation
├── defaults/           # Default variables
│   └── main.yml
├── files/              # Static files
├── handlers/           # Handlers
│   └── main.yml
├── meta/               # Role metadata
│   └── main.yml
├── tasks/              # Tasks
│   └── main.yml
├── templates/          # Jinja2 templates
├── tests/              # Role tests
│   ├── inventory
│   └── test.yml
└── vars/               # Role variables
    └── main.yml
```

### Best Practices

1. **Single Responsibility** - Each role should have one clear purpose
2. **Idempotency** - Roles should be safe to run multiple times
3. **Documentation** - Include comprehensive README.md
4. **Defaults** - Provide sensible defaults for all variables
5. **Tags** - Add tags for selective execution
6. **OS Support** - Handle multiple operating systems

## Playbook Best Practices

### Organization

- Use `site.yml` as the master playbook
- Create separate playbooks for different components
- Use `import_playbook` to compose larger playbooks
- Keep playbooks focused and readable

### Structure

```yaml
---
- name: Descriptive play name
  hosts: target_hosts
  become: true
  
  pre_tasks:
    - name: Pre-task actions
      # ...
  
  roles:
    - role: role_name
      tags:
        - role_tag
  
  tasks:
    - name: Additional tasks
      # ...
  
  post_tasks:
    - name: Post-task actions
      # ...
```

### Task Organization

- Use `pre_tasks` for setup (e.g., updating package cache)
- Use `tasks` for main configuration
- Use `post_tasks` for verification
- Use `handlers` for service restarts

## Tags Strategy

Apply tags at multiple levels:

- **Role level** - Tag entire role execution
- **Task level** - Tag specific tasks
- **Block level** - Tag groups of tasks

Common tags:
- `setup` - Initial setup tasks
- `configuration` - Configuration tasks
- `packages` - Package installation
- `services` - Service management
- `verify` - Verification tasks

## Idempotency

Ensure all tasks are idempotent:

1. Use appropriate modules (e.g., `file`, `package`, `service`)
2. Avoid `command` and `shell` when possible
3. When using `command`/`shell`, add `changed_when` and `creates`
4. Test multiple runs produce same result

Example:
```yaml
- name: Create directory
  file:
    path: /opt/app
    state: directory
    mode: '0755'

- name: Run command only when needed
  command: /usr/local/bin/init-app
  args:
    creates: /opt/app/.initialized
```

## Error Handling

- Use `failed_when` to define failure conditions
- Use `ignore_errors` sparingly
- Use `block`/`rescue`/`always` for complex error handling
- Log errors appropriately

Example:
```yaml
- name: Task that might fail
  block:
    - name: Attempt task
      command: /usr/local/bin/risky-operation
  rescue:
    - name: Handle failure
      debug:
        msg: "Task failed, but continuing"
  always:
    - name: Cleanup
      file:
        path: /tmp/temp-file
        state: absent
```

## Testing

### Syntax Check

```bash
ansible-playbook playbooks/site.yml --syntax-check
```

### Lint

```bash
ansible-lint playbooks/*.yml roles/*/tasks/*.yml
```

### Check Mode

```bash
ansible-playbook playbooks/site.yml --check
```

### Diff Mode

```bash
ansible-playbook playbooks/site.yml --check --diff
```

## Performance Optimization

1. **Pipelining** - Enable SSH pipelining in ansible.cfg
2. **Fact Caching** - Cache gathered facts
3. **Forks** - Increase parallel execution (adjust forks)
4. **Gathering** - Use smart fact gathering
5. **Async Tasks** - Use async for long-running tasks

Example async task:
```yaml
- name: Long running task
  command: /usr/local/bin/long-task
  async: 3600
  poll: 0
  register: long_task

- name: Check on long task
  async_status:
    jid: "{{ long_task.ansible_job_id }}"
  register: job_result
  until: job_result.finished
  retries: 30
  delay: 60
```

## Security Best Practices

1. **Vault** - Encrypt all sensitive data
2. **Permissions** - Set appropriate file permissions
3. **Users** - Use dedicated Ansible user
4. **Sudo** - Use sudo for privilege escalation
5. **SSH Keys** - Use SSH keys, not passwords
6. **Secrets** - Never log sensitive data

## Documentation

Every role should include:

1. **README.md** - Role description and usage
2. **Defaults** - Document all default variables
3. **Requirements** - List dependencies and prerequisites
4. **Examples** - Provide usage examples
5. **License** - Specify license information

## Version Control

- Commit logical changes separately
- Write descriptive commit messages
- Use branches for new features
- Tag releases (e.g., v1.0.0)
- Keep .gitignore updated

## Common Patterns

### Conditional Execution

```yaml
- name: Task for Debian
  apt:
    name: package
    state: present
  when: ansible_os_family == "Debian"

- name: Task for production
  service:
    name: service
    state: started
  when: environment == "production"
```

### Loops

```yaml
- name: Create multiple directories
  file:
    path: "{{ item }}"
    state: directory
  loop:
    - /opt/app/bin
    - /opt/app/conf
    - /opt/app/logs

- name: Install packages
  package:
    name: "{{ item.name }}"
    state: "{{ item.state }}"
  loop:
    - { name: 'vim', state: 'present' }
    - { name: 'telnet', state: 'absent' }
```

### Templates

```yaml
- name: Deploy configuration
  template:
    src: app.conf.j2
    dest: /etc/app/app.conf
    owner: root
    group: root
    mode: '0644'
  notify: restart app
```

## Troubleshooting

Common issues and solutions:

1. **Connection Issues** - Check SSH access and credentials
2. **Permission Denied** - Verify sudo access
3. **Module Not Found** - Install required collections
4. **Variable Undefined** - Check variable names and scope
5. **Task Timeout** - Increase timeout or use async

Enable verbose output for debugging:
```bash
ansible-playbook playbooks/site.yml -vvv
```

## References

- [Ansible Documentation](https://docs.ansible.com/)
- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)
- [Ansible Galaxy](https://galaxy.ansible.com/)
- [Ansible Lint](https://ansible-lint.readthedocs.io/)
