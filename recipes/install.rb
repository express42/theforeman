%w(foreman foreman-proxy foreman-libvirt foreman-console foreman-postgresql ruby-foreman-hooks ruby-foreman-dhcp-browser).each do |pkg|
  package pkg
end

%w(ruby-smart-proxy-chef ruby-smart-proxy-discovery).each do |pkg|
  package pkg
end

package 'unicorn'

chef_gem 'foreman_api'
