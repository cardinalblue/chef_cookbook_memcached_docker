#
# Cookbook:: chef_cookbook_memcached_docker
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'docker'

docker_service 'default' do
  action [:create, :start]
end

docker_image 'bitnami/memcached:1.5.9-debian-9' do
  action :pull_if_missing
end

docker_container 'memcached_server' do
  action :run_if_missing
  repo 'bitnami/memcached:1.5.9-debian-9'
  port "11211:11211"
  env ["MEMCACHED_CACHE_SIZE=#{node['memcached']['memory']}",
       "MEMCACHED_USERNAME=#{node['memcached']['sasl_user_name']}",
       "MEMCACHED_PASSWORD=#{node['memcached']['sasl_user_password']}"]
  restart_policy 'always'
end
