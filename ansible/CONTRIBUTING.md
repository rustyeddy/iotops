# Contributing to IoT Operations

Thank you for your interest in contributing to the IoT Operations Ansible project!

## How to Contribute

### Reporting Issues

If you find a bug or have a feature request:

1. Check existing issues to avoid duplicates
2. Create a new issue with:
   - Clear description of the problem/feature
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Your environment details (Ansible version, OS, etc.)

### Contributing Code

#### Setting Up Development Environment

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/iotops.git
   cd iotops
   ```
3. Create a branch for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

#### Making Changes

1. **Follow Ansible Best Practices**
   - Use descriptive task names
   - Add comments for complex logic
   - Use variables instead of hard-coded values
   - Follow YAML style guidelines

2. **Test Your Changes**
   ```bash
   # Syntax check
   cd ansible
   ansible-playbook --syntax-check playbooks/your_playbook.yml
   
   # Check mode (dry run)
   ansible-playbook --check playbooks/your_playbook.yml
   
   # Test on actual devices (if available)
   ansible-playbook playbooks/your_playbook.yml --limit test-device
   ```

3. **Validate YAML Files**
   ```bash
   # Python validation
   python3 -c "import yaml; yaml.safe_load(open('file.yml'))"
   ```

#### Coding Standards

##### Directory Structure

When adding new roles, follow this structure:
```
roles/your_role/
├── README.md
├── defaults/
│   └── main.yml
├── files/
├── handlers/
│   └── main.yml
├── meta/
│   └── main.yml
├── tasks/
│   └── main.yml
├── templates/
└── vars/
    └── main.yml
```

##### YAML Style

- Use 2 spaces for indentation
- Use lowercase with underscores for variable names
- Quote strings when necessary
- Add comments for complex logic

Example:
```yaml
---
# Good example
- name: Install required packages
  package:
    name: "{{ item }}"
    state: present
  loop:
    - package1
    - package2
  tags: packages
```

##### Variable Naming

- Prefix role variables with role name: `otto_port`, `iot_timeout`
- Use descriptive names: `enable_feature` not `ef`
- Document all variables in defaults/main.yml

##### Task Names

- Start with a verb: "Install", "Configure", "Deploy"
- Be specific: "Install Python packages" not "Install stuff"
- Use proper capitalization

#### Adding New Roles

1. Create role structure:
   ```bash
   cd ansible/roles
   mkdir -p new_role/{tasks,handlers,templates,defaults,meta,files,vars}
   ```

2. Add README.md with:
   - Description
   - Requirements
   - Role variables
   - Dependencies
   - Example playbook

3. Define defaults in `defaults/main.yml`

4. Create tasks in `tasks/main.yml`

5. Add meta information in `meta/main.yml`

6. Create a playbook in `playbooks/`

7. Update main `README.md` with new role information

#### Adding New Playbooks

1. Create playbook in `playbooks/` directory
2. Follow naming convention: `verb_object.yml`
3. Add documentation at the top:
   ```yaml
   ---
   # Playbook description
   # Run: ansible-playbook playbooks/your_playbook.yml
   ```
4. Include appropriate tags
5. Add to `site.yml` if it should be part of main deployment

#### Documentation

- Update relevant README files
- Add inline comments for complex logic
- Update examples if you change variable names
- Keep documentation in sync with code

### Submitting Changes

1. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "feat: add support for new device type"
   ```

   Use conventional commit messages:
   - `feat:` - New feature
   - `fix:` - Bug fix
   - `docs:` - Documentation changes
   - `refactor:` - Code refactoring
   - `test:` - Test additions/changes
   - `chore:` - Maintenance tasks

2. **Push to Your Fork**
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create Pull Request**
   - Go to GitHub and create a PR from your branch
   - Provide clear description of changes
   - Reference any related issues
   - Ensure all checks pass

### Pull Request Guidelines

- One feature/fix per PR
- Include tests if applicable
- Update documentation
- Ensure backward compatibility
- Keep changes focused and minimal

### Review Process

1. Maintainers will review your PR
2. Address any feedback or requested changes
3. Once approved, your PR will be merged

## Development Tips

### Testing Playbooks Locally

Use vagrant or docker to test playbooks:

```bash
# Example with vagrant
vagrant init ubuntu/focal64
vagrant up
# Add vagrant host to inventory for testing
```

### Using Check Mode

Always test with `--check` first:
```bash
ansible-playbook playbooks/site.yml --check --diff
```

### Debugging

Use debug module and verbose mode:
```yaml
- name: Debug variable
  debug:
    var: my_variable
    verbosity: 2
```

Run with verbosity:
```bash
ansible-playbook playbooks/site.yml -vv
```

### Using Tags

Apply tags for easier testing:
```yaml
- name: Configure firewall
  include_tasks: firewall.yml
  tags:
    - firewall
    - security
```

Test specific tags:
```bash
ansible-playbook playbooks/site.yml --tags firewall
```

## Questions?

If you have questions:
- Open an issue for discussion
- Check existing documentation
- Review closed issues and PRs

Thank you for contributing to IoT Operations!
