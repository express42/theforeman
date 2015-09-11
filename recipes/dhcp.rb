%w(isc-dhcp-server).each do |pkg|
  package pkg
end

foreman_proxy_conf_path = node['foreman']['foreman_proxy_conf_path']

file "#{foreman_proxy_conf_path}/settings.d/dhcp.yml" do
  content node['foreman']['foreman-proxy']['dhcp']['config'].to_hash.to_yaml
  notifies :restart, 'service[foreman-proxy]', :delayed
end
