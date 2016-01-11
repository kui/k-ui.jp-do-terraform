k-ui.jp Digital Ocean terraform
=================================

terraform configs for http://k-ui.jp/ on Digital Ocean

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~bash
# Create droplet or re-apply the chenged .tf for k-ui.jp
$ make apply

# Re-create droplet to re-apply the chenged `scripts`
$ make force-apply

# Destroy the droplet
$ make destroy

# SSH login to the current droplet
$ make login

# Open the HTTP service on the current droplet
$ make open-http
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Notes
--------------

* Create `./scripts/gmail-{user,password}` to report Munin alerts and blog build cron
* Config Syncthing **manually**


Environment Switching
--------------------------

This configs has two environment to continue these services.

Do the blow if you want to change this configs:

1. Change `ENV` in `Makefile`
2. Edit configs
3. `make apply` or `make force-apply`
4. Check the edited configs:
  * `make login` or
  * `make open-http`
5. Retry 2.-4. if you need
6. Change the `k-ui.jp` DNS to the current environment IP address
  * `make show` if you need
7. Do some `git` operations
