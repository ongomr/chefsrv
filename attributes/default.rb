#
# Cookbook:: devstack
# Attribue:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# default devstack user
default['stack']['user'] = 'stack'
default['stack']['group'] = 'stack'
default['stack']['home'] = "/opt/#{node['stack']['user']}"

# default devstack git source
default['stack']['clone'] = 'git://git.openstack.org/openstack-dev/devstack'

# default devstack passwords
default['stack']['password'] = 'secret'
default['stack']['ipaddress'] = '192.168.56.120' # use '#{node['ipaddress']}' if you using one interface on the server
