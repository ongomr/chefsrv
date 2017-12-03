#
# Cookbook:: devstack
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# creating user to install and run devstack
user node['stack']['user'] do
  comment 'devstack user'
  #uid '1234'
  #gid '1234'
  home "#{node['stack']['home']}"
  shell '/bin/bash'
  manage_home true
  #password '$1$JJsvHslasdfjVEroftprNn4JHtDi'
end

# adding user to sudoers file
execute "adding user #{node['stack']['user']} to sudoers" do
  command "echo \"#{node['stack']['user']} ALL=(ALL) NOPASSWD: ALL\" \| sudo tee /etc/sudoers.d/#{node['stack']['user']}"
  not_if "grep \"#{node['stack']['user']} ALL=(ALL) NOPASSWD: ALL\" /etc/sudoers.d/#{node['stack']['user']}"
end

# cloning devstack from git.openstack.org
# bug exists in git, if directory exists, clone does not occur
git "#{node['stack']['home']}/devstack" do
  repository "#{node['stack']['clone']}"
  revision 'master'
  action :sync
  user "#{node['stack']['user']}"
  group "#{node['stack']['group']}"
end

# setting up local.conf for default devstack settings
template "#{node['stack']['home']}/devstack/local.conf" do
  source 'local.conf.erb'
  variables({
      password: node['stack']['password'],
      ipaddress: node['stack']['ipaddress']
    })
  owner "#{node['stack']['user']}"
  group "#{node['stack']['group']}"
  mode '0600'
end

# installing and running devstack
execute "stack.sh" do
  user "#{node['stack']['user']}"
  group "#{node['stack']['group']}"
  cwd "#{node['stack']['home']}/devstack"
  environment ({'HOME' => "#{node['stack']['home']}", 'USER' => "#{node['stack']['user']}"})
  command "./stack.sh"
  not_if "ps cax | grep horizon"
end
