apt_repository 'foreman-repo' do
  uri 'http://deb.theforeman.org'
  distribution node['lsb']['codename']
  components ['1.8']
  key 'http://deb.theforeman.org/pubkey.gpg'
end

apt_repository 'foreman-plugins-repo' do
  uri 'http://deb.theforeman.org'
  distribution 'plugins'
  components ['1.8']
  key 'http://deb.theforeman.org/pubkey.gpg'
end
