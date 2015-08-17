# Description

Installs/Configures theforeman

# Requirements

## Platform:

*No platforms defined*

## Cookbooks:

* postgresql_lwrp
* memcached
* nginx

# Attributes

* `node['foreman']['etc_default']['start']` -  Defaults to `yes`.
* `node['foreman']['user']` -  Defaults to `foreman`.
* `node['foreman']['share_path']` -  Defaults to `/usr/share/foreman`.
* `node['foreman']['foreman_conf_path']` -  Defaults to `/etc/foreman`.
* `node['foreman']['foreman_proxy_conf_path']` -  Defaults to `/etc/foreman-proxy`.
* `node['foreman']['foreman-proxy']['dhcp']['config']['enabled']` -  Defaults to `true`.
* `node['foreman']['foreman-proxy']['dhcp']['config']['dhcp_vendor']` -  Defaults to `isc`.
* `node['foreman']['foreman-proxy']['dhcp']['config']['dhcp_config']` -  Defaults to `/etc/dhcp/dhcpd.conf`.
* `node['foreman']['foreman-proxy']['dhcp']['config']['dhcp_leases']` -  Defaults to `/var/lib/dhcp/dhcpd.leases`.
* `node['foreman']['plugins']['memcache']['config']['memcache']['hosts']` -  Defaults to `[ ... ]`.
* `node['foreman']['plugins']['memcache']['config']['memcache']['options']['namespace']` -  Defaults to `foreman`.
* `node['foreman']['plugins']['memcache']['config']['memcache']['options']['expires_in']` -  Defaults to `86400`.
* `node['foreman']['foreman-proxy']['tftp']['tftproot']` -  Defaults to `/srv/tftp`.

# Recipes

* theforeman::config
* theforeman::database
* theforeman::default
* theforeman::dhcp
* theforeman::install
* theforeman::memcache
* theforeman::official_repository
* theforeman::old
* theforeman::tftp

# License and Maintainer

Maintainer:: LLC Express 42 (<cookbooks@express42.com>)

License:: MIT
