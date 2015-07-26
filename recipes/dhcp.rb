%w(isc-dhcp-server).each do |pkg|
  package pkg
end

foreman_proxy_conf_path = node['foreman']['foreman_proxy_conf_path']

file "#{foreman_proxy_conf_path}/settings.d/dhcp.yml" do
  content YAML::dump(node['foreman']['foreman-proxy']['dhcp']['config'])
  notifies :restart, 'service[foreman-proxy]', :delayed
end
