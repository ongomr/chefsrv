  #
# Cookbook:: chefsrv
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

default['chef-server']['accept_license'] = true
default['chef-server']['version'] = nil
default['chef-server']['package-source'] = nil
default['chef-server']['api_fqdn'] = node['nil']
default['chef-server']['topology'] = 'standalone'
default['chef-server']['chef-ingredient']['timeout'] = 3600

node.default['chef-server']['configuration'] = <<-EOS
notification_email 'RobertOngom@gmail.com'
nginx['cache_max_size'] = '3500m'
EOS

default['chef-server']['addons'] = {'manage' => '2.5.4',
                                    'reporting' => '1.7.5',
                                    'push-jobs-server' => '2.2.2'
                                   }

# Chef Server Setup Specifics
default['chefsrv']['username'] = 'ongomr' # Add to Chef Vault
default['chefsrv']['password'] = 'ask4help' # Add to Chef Vault
default['chefsrv']['full_name'] = 'Robert Mugabe Ongom'
default['chefsrv']['email'] = 'RobertOngom@gmail.com'
default['chefsrv']['user_perm_file_path'] = '/root/ongomr.pem'
default['chefsrv']['org_name'] = 'lab'
default['chefsrv']['org_discription'] = 'Personal Lab Organisation'
default['chefsrv']['association_user'] = node['chefsrv']['username']
default['chefsrv']['org_perm_name'] = 'lab-validator.pem'
