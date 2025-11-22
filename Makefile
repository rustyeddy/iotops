# Makefile for iotops Ansible project

.PHONY: help install lint check syntax test ping site devices gateways servers

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

install: ## Install Ansible and required collections
	pip install ansible ansible-lint
	ansible-galaxy install -r requirements.yml

lint: ## Lint all playbooks
	ansible-lint playbooks/*.yml

check: ## Run playbooks in check mode (dry-run)
	ansible-playbook playbooks/site.yml --check

syntax: ## Check playbook syntax
	ansible-playbook playbooks/site.yml --syntax-check

test: syntax lint ## Run all tests (syntax check and lint)

ping: ## Test connectivity to all hosts
	ansible all -m ping

site: ## Run the full site playbook
	ansible-playbook playbooks/site.yml

devices: ## Configure IoT devices
	ansible-playbook playbooks/iot_devices.yml

gateways: ## Configure IoT gateways
	ansible-playbook playbooks/iot_gateways.yml

servers: ## Configure IoT servers
	ansible-playbook playbooks/iot_servers.yml

list-hosts: ## List all hosts in inventory
	ansible all --list-hosts

list-tags: ## List all available tags
	ansible-playbook playbooks/site.yml --list-tags

facts: ## Gather facts from all hosts
	ansible all -m setup --tree /tmp/facts

clean: ## Clean temporary files
	rm -f ansible.log
	rm -f *.retry
	rm -rf /tmp/ansible_facts
	rm -rf /tmp/facts
