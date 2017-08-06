#
# Cookbook:: chefsrv
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe "chef-server::default"
include_recipe "chef-server::addons"
include_recipe "chefsrv::setup_lab"
