.PHONY: help ping facts deploy-all deploy-otto deploy-iot update check

help:
	@echo "IoT Operations - Ansible Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  help         - Show this help message"
	@echo "  ping         - Test connectivity to all devices"
	@echo "  facts        - Gather facts from all devices"
	@echo "  deploy-all   - Deploy all devices (Otto + IoT)"
	@echo "  deploy-otto  - Deploy only Otto devices"
	@echo "  deploy-iot   - Deploy only generic IoT devices"
	@echo "  update       - Update system packages on all devices"
	@echo "  check        - Run deployment in check mode (dry-run)"
	@echo "  install-deps - Install required Ansible collections"
	@echo ""
	@echo "Examples:"
	@echo "  make ping"
	@echo "  make deploy-otto"
	@echo "  make deploy-all LIMIT=otto-01"
	@echo "  make deploy-otto TAGS=firewall"

ping:
	ansible-playbook playbooks/ping.yml $(if $(LIMIT),--limit $(LIMIT),)

facts:
	ansible-playbook playbooks/gather_facts.yml $(if $(LIMIT),--limit $(LIMIT),)

deploy-all:
	ansible-playbook playbooks/site.yml $(if $(LIMIT),--limit $(LIMIT),) $(if $(TAGS),--tags $(TAGS),)

deploy-otto:
	ansible-playbook playbooks/deploy_otto.yml $(if $(LIMIT),--limit $(LIMIT),) $(if $(TAGS),--tags $(TAGS),)

deploy-iot:
	ansible-playbook playbooks/deploy_iot_devices.yml $(if $(LIMIT),--limit $(LIMIT),) $(if $(TAGS),--tags $(TAGS),)

update:
	ansible-playbook playbooks/update_system.yml $(if $(LIMIT),--limit $(LIMIT),)

check:
	ansible-playbook playbooks/site.yml --check $(if $(LIMIT),--limit $(LIMIT),)

install-deps:
	ansible-galaxy install -r requirements.yml
