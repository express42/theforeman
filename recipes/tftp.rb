%w(tftpd syslinux-common).each do |pkg|
  package pkg
end

tftproot = node['foreman']['foreman-proxy']['tftp']['tftproot']
foreman_proxy_conf_path = node['foreman']['foreman_proxy_conf_path']

directory tftproot do
  owner 'foreman-proxy'
  group 'foreman-proxy'
end

%w(boot pxelinux.cfg).each do |dir|
  directory "#{tftproot}/#{dir}" do
    owner 'foreman-proxy'
    group 'foreman-proxy'
  end
end

%w(pxelinux.0 menu.c32 chain.c32 memdisk).each do |target_file|
  remote_file "Copy #{target_file} file to #{tftproot}" do
    path "#{tftproot}/#{target_file}"
    source "file:///usr/lib/syslinux/#{target_file}"
  end
end

template "#{foreman_proxy_conf_path}/settings.d/tftp.yml" do
  source 'tftp.yml.erb'
  variables( tftproot: tftproot )
  notifies :restart, 'service[foreman-proxy]', :delayed
end
