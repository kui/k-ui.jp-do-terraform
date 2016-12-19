TF := terraform
DIR := $(dir $(lastword $(MAKEFILE_LIST)))

ENVS := tama pochi

# ENV ?= tama
ENV ?= pochi

SSH_DIR := ssh/$(ENV)
ID_RSA := $(SSH_DIR)/id_rsa
SSH_CONFIG := $(SSH_DIR)/config

PORT_FORWARD_SYNCTHING := 18384:127.0.0.1:8384

TF_STATE := $(ENV).tfstate
TF_OPTS := -backup=- -var=env=$(ENV) -state=$(TF_STATE)
IP_ADDR = $(shell make show ENV=$(ENV) | perl -ne '/^\s+ipv4_address = (.*)$$/ && print $$1, "\n"')

.PHONY: init cd show force-apply apply destroy taint plan login open-http

plan: init
	$(TF) plan $(TF_OPTS)

show: init
	$(TF) show $(ENV).tfstate

show-all: init
	@for e in $(ENVS); do \
	  echo "## $$e"; \
	  $(TF) show $$e.tfstate; \
	done

force-apply: init taint apply open-http

apply: init
	time $(TF) apply $(TF_OPTS)

destroy: init
	$(TF) destroy $(TF_OPTS)

taint: init
	$(TF) taint $(TF_OPTS) digitalocean_droplet.k-ui-jp

login: init $(SSH_CONFIG)
	ssh -F "$(SSH_CONFIG)" k-ui.jp \
		-L "$(PORT_FORWARD_SYNCTHING)"

open-http: init
	python -m webbrowser -t "http://$(IP_ADDR)/"

##

init: check-env cd $(ID_RSA) do_token

check-env:
	@if perl -e "'$(ENVS)' =~ /(?<!\S)$(ENV)(?!\S)/ and exit(1)"; then \
	  echo "Invalid ENV"; \
	  exit 1; \
	fi

cd:
	@cd "$(DIR)"

$(ID_RSA):
	ssh-keygen -f "$@" -t rsa -b 2048 -P ""

$(SSH_CONFIG): $(TF_STATE) ssh/gen_ssh_config.sh
	./ssh/gen_ssh_config.sh "$(ID_RSA)" "$(IP_ADDR)" > "$@"

do_token:
	@echo "Abort: Require DigitalOcean API token"
	@exit 1
