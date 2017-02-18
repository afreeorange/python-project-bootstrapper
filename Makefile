COOKIECUTTER = cookiecutter
PIP = pip

.PHONY: help
help:
	@echo ""
	@echo "  Python Project Bootstrapper "
	@echo "  --------------------------- "
	@echo ""
	@echo "  Available templates: "
	@echo ""
	@echo "  * flask-service "
	@echo "  * flask-app "
	@echo "  * command-line-app "
	@echo "  * library "
	@echo ""
	@echo "  To start a project, type 'make' followed by the template name: "
	@echo ""
	@echo "      make command-line-app "
	@echo ""
	@echo "  The project directory will be created automatically. "
	@echo ""


.PHONY: check_deps
check_deps:

ifndef VIRTUAL_ENV
	$(error "! You don't appear to be in a virtual environment.")
endif

ifneq ($(shell bash -c '$(PIP)' >/dev/null 2>&1; echo $$?), 0)
	$(error "! Looks like you don't have 'pip' installed. See this page: https://pip.pypa.io/en/stable/installing")
endif

ifneq ($(shell bash -c '$(COOKIECUTTER)' >/dev/null 2>&1; echo $$?), 2)
	$(warning "! Cookiecutter is required to set up this template.")
	$(warning "! make will fail otherwise.")

	@echo "Install cookiecutter? [y/n] "; \
	read -r INSTALL_COOKIECUTTER; \
	[ $$INSTALL_COOKIECUTTER = "y" ] && (bash -c 'pip install $(COOKIECUTTER)')
endif

# Project template tasks

.PHONY: flask-service
flask-service: check_deps
	cookiecutter https://github.com/afreeorange/template-python-flask-api.git

.PHONY: flask-app
flask-app: check_deps
	cookiecutter https://github.com/afreeorange/template-python-flask-app.git

.PHONY: command-line-app
command-line-app: check_deps
	cookiecutter https://github.com/afreeorange/template-python-cli-app.git

.PHONY: library
library: check_deps
	cookiecutter https://github.com/afreeorange/template-python-library.git
