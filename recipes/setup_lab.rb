#
# Cookbook:: chefsrv
# Recipe:: setup_lab
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# NEED BETTER TESTS AND CONDITIONS FOR EXECUTES


# Adding administrator user for chef server
execute 'adding admin user for lab' do
  command "chef-server-ctl user-create #{node['chefsrv']['username']} #{node['chefsrv']['full_name']} \
                                        #{node['chefsrv']['email']} #{node['chefsrv']['password']} \
                                        --filename #{node['chefsrv']['user_perm_file_path']}"
  not_if "chef-server-ctl user-list —check-user |grep #{node['chefsrv']['username']}"
end

# Adding lab org and associationg user to chef server
execute 'adding lab org' do
  command "chef-server-ctl org-create #{node['chefsrv']['org_name']} #{node['chefsrv']['org_discription']} \
                                        --association_user #{node['chefsrv']['association_user']}  \
                                        --filename #{node['chefsrv']['org_perm_name']}"
  not_if "chef-server-ctl org-list |grep #{node['chefsrv']['org_name']}"
end

# Reinstalling and configuring chef-manage
#execute 'reinstalling chef-manage' do
#  command "chef-server-ctl install chef-manage"
#  not_if "chef-manage-ctl service-list |grep \"web*\""
#end

# Reconfiguring chef for chef-manage
execute 'reconfiguring chef for chef-manage' do
  command "chef-server-ctl reconfigure"
  not_if "chef-manage-ctl service-list |grep \"web*\""
end

# Configuring chef-manage and accepting license
execute 'reconfiguring chef-manage' do
  command "chef-manage-ctl reconfigure --accept-license"
  not_if "chef-manage-ctl service-list |grep \"web*\""
end

# Reinstalling and configuring opscode-push-jobs-server
#execute 'reinstalling opscode-push-jobs-server' do
#  command "chef-server-ctl install opscode-push-jobs-server"
#  not_if "chef-server-ctl service-list |grep \"opscode-pushy-server*\""
#end

# Reconfiguring chef for opscode-push-jobs-server
execute 'reconfiguring chef for opscode-push-jobs-server' do
  command "chef-server-ctl reconfigure"
  not_if "chef-server-ctl service-list |grep \"opscode-pushy-server*\""
end

# Configuring opscode-push-jobs-server
execute 'reconfiguring opscode-push-jobs-server' do
  command "opscode-push-jobs-server-ctl reconfigure"
  not_if "chef-server-ctl service-list |grep \"opscode-pushy-server*\""
end


# Reinstalling and configuring opscode-reporting
#execute 'reinstalling opscode-reporting' do
#  command "chef-server-ctl install opscode-reporting"
#  only_if "opscode-reporting-ctl test |grep \"bundler: failed to load command:\""
#end

# Reconfiguring chef for opscode-reporting
execute 'reconfiguring chef for opscode-reporting' do
  command "chef-server-ctl reconfigure"
  only_if "opscode-reporting-ctl test |grep \"bundler: failed to load command:\""
end

# Configuring opscode-reporting
execute 'reconfiguring chef-manage' do
  command "opscode-reporting-ctl reconfigure --accept-license"
  only_if "opscode-reporting-ctl test |grep \"bundler: failed to load command:\""
end
