postgresql 'main' do
  cluster_version '9.3'
  configuration(
#      listen_addresses:           '192.168.0.2',
      ssl_renegotiation_limit:    0,
      shared_buffers:             '1024MB',
      maintenance_work_mem:       '8MB',
      work_mem:                   '8MB',
      log_min_duration_statement: 500,
      synchronous_commit:         'off'
  )
end

postgresql_user 'foreman' do
  in_version '9.3'
  in_cluster 'main'
  unencrypted_password 'password'
end

postgresql_database 'foreman' do
  in_version '9.3'
  in_cluster 'main'
  owner 'foreman'
end
