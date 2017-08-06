#/bin/bash
# Script to install chef-server using chef-solo and chef cookbooks on gitlab.
# Maintaniner: Robert Ongom
# Email: RobertOngom@gmail.com

#Installing chef client from 'www.opscode.com'
curl -L https://www.opscode.com/chef/install.sh | bash
chef-solo -v

# Chef Repository.: setup a file structure that will help organise our various Chef files

wget http://github.com/opscode/chef-repo/tarball/master
tar -zxf master
mv chef-boneyard-chef-repo* chef-repo
rm master

# Setting up 'knife.rb' to point to the cookbooks directory
mkdir .chef
echo "cookbook_path [ '/root/chef-repo/cookbooks' ]" > .chef/knife.rb

# Copy cookbooks from gitlab to cookbooks directory : TEST BELOW CODE
#wget https://gitlab.com/ongomr/chefsrv/repository/archive.tar.gz?ref=master
#tar -zxf archive
#mv chefsrv cookbooks/chefsrv
#rm master

# Creating Solo.rb file
cat <<EOT >> solo.rb
file_cache_path "/root/chef-solo"
cookbook_path "/root/chef-repo/cookbooks"

{
  "run_list": [ "recipe[apt]", "recipe[phpapp]" ]
}
EOT

# Run chef build using chef-solo, use 'chef-solo -c solo.rb -j chefsrv.json'
# If a 'chefsrv' role is created

chef-solo -c solo.rb
