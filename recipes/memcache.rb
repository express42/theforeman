package 'ruby-foreman-memcache'

node.default['memcached']['listen'] = '127.0.0.1'

include_recipe 'memcached::default'

foreman_conf_path = node['foreman']['foreman_conf_path']

file "#{foreman_conf_path}/plugins/foreman_memcache.yaml" do
  content node['foreman']['plugins']['memcache']['config'].to_hash.to_yaml
  notifies :restart, 'service[foreman]', :delayed
end
