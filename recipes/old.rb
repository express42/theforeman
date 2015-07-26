include_recipe 'ruby_lwrp::default'

user 'foreman' do
  supports manage_home: true
  home '/home/foreman'
  shell '/bin/bash'
end

ruby_install '2.2.2'

ruby_set '2.2.2' do
  username 'foreman'
end
