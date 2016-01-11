TF := terraform
DIR := $(dir $(lastword $(MAKEFILE_LIST)))

ENV := tama
# ENV := pochi

PORT_FORWARD_SYNCTHING := 18384:127.0.0.1:8384

.PHONY: init cd show force-apply apply destroy taint plan login open-http

TF_STATE := $(ENV).tfstate
TF_OPTS := -backup=- -var=env=$(ENV) -state=$(TF_STATE)

plan: init
	$(TF) plan $(TF_OPTS)

show: init
	time $(TF) show $(TF_STATE)

force-apply: init taint apply open-http

apply: init
	time $(TF) apply $(TF_OPTS)

destroy: init
	$(TF) destroy $(TF_OPTS)

taint: init
	$(TF) taint $(TF_OPTS) digitalocean_droplet.k-ui-jp

login: init ssh/config
	ssh -F ssh/config k-ui.jp \
		-L "$(PORT_FORWARD_SYNCTHING)"

open-http: IP_ADDR = $(shell make show | perl -ne '/^\s+ipv4_address = (.*)$$/ && print $$1, "\n"')
open-http: init
	python -m webbrowser -t "http://$(IP_ADDR)/"

##

init: cd ssh/id_rsa do_token

cd:
	@cd "$(DIR)"

ssh/id_rsa:
	ssh-keygen -f ssh/id_rsa -t rsa -b 2048 -P ""

ssh/config: $(TF_STATE) ssh/gen_ssh_config.sh
	./ssh/gen_ssh_config.sh "$@" $(TF_STATE)

do_token:
	@echo "Abort: Require DigitalOcean API token"
	@exit 1
