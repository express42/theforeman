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

# HOW-TO

Setup foreman and foreman-proxy:
```
cd /usr/share/foreman
RAILS_ENV=production foreman-rake db:migrate
RAILS_ENV=production foreman-rake db:seed
vi /etc/foreman/settings.yaml
vi /etc/foreman/plugins/foreman_memcache.yaml
apt-get install ruby-foreman-chef
/etc/init.d/foreman restart
vi /etc/foreman-proxy/settings.yml
vi /etc/foreman-proxy/settings.d/bmc.yml
vi /etc/foreman-proxy/settings.d/chef.yml
vi /etc/foreman-proxy/settings.d/dhcp.yml
vi /etc/foreman-proxy/settings.d/discovery.yml
vi /etc/foreman-proxy/settings.d/facts.yml
vi /etc/foreman-proxy/settings.d/puppetca.yml
vi /etc/foreman-proxy/settings.d/templates.yml
vi /etc/foreman-proxy/settings.d/tftp.yml
/etc/init.d/foreman-proxy restart
```

Setup dhcp server:
```
vi /etc/dhcp/dhcpd.conf
/etc/init.d/isc-dhcp-server restart
```

Setup tftp server:
```
apt-get install inetutils-inetd
vi /etc/inetd.conf
/etc/init.d/inetutils-inetd start
```

Reset admin password:
```
RAILS_ENV=production foreman-rake permissions:reset
```

Libvirt auth:
```
mkdir /etc/foreman/libvirt-pki
vi cacert.pem
vi clientcert.pem
vi clientkey.pem
```

Chef Handler:
```
node.default['chef_client']['load_gems']['chef_handler_foreman']['require_name'] = 'chef_handler_foreman'
node.default['foreman']['server_url'] = 'http://'

template '/etc/chef/client.d/foreman_handler.rb' do
  source 'foreman_handler.rb.erb'
  mode '0644'
  notifies :create, 'ruby_block[reload_client_config]'
  variables(
    server_url: node['foreman']['server_url']
  )
end

foreman_server_options  url: '<%= @server_url %>'
foreman_facts_upload    true
foreman_reports_upload  true
reports_log_level       "notice"
```

# License and Maintainer

Maintainer:: LLC Express 42 (<cookbooks@express42.com>)

License:: MIT
