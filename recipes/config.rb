template '/etc/default/foreman' do
  source 'etc_default.erb'
  variables config: node['foreman']['etc_default']
end

cookbook_file '/etc/init.d/foreman' do
  source 'foreman_init'
  notifies :restart, 'service[foreman]', :delayed
  mode '0755'
end

template '/etc/foreman/database.yml' do
  source 'database.yml.erb'
  notifies :restart, 'service[foreman]', :delayed
end

cookbook_file '/etc/foreman/unicorn.rb' do
  source 'unicorn.rb'
  owner 'foreman'
  group 'foreman'
  notifies :restart, 'service[foreman]', :delayed
end

link '/usr/share/foreman/config/unicorn.rb' do
  to '/etc/foreman/unicorn.rb'
end

service 'foreman' do
  supports status: true, restart: true
  action [:enable, :start]
end

service 'foreman-proxy' do
  supports status: true, restart: true
  action [:enable, :start]
end

include_recipe 'nginx'

nginx_site 'foreman' do
  template 'nginx_foreman_web.erb'
  variables(
    foreman_app_path: node['foreman']['share_path'],
    foreman_app_port: 3000
  )
end
