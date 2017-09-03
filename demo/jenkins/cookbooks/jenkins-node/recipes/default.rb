#
# Cookbook Name:: jenkins-node
# Recipe:: default
#

bash 'apt update upgrade' do
  code <<-EOH
    apt -y update
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq
  EOH
end

# Install base packages
pkgs = {
  'jq' => '1.5+dfsg-1',
}

pkgs.each do |pkg, version|
  package pkg do
    version version
    action :install
  end
end

# Install aws-cli via cloudcli, not via apt (which does not keep up to date)
package 'awscli' do
  action :remove
end

node.default['cloudcli']['aws']['version'] = '1.11.102'
include_recipe 'cloudcli::awscli'

# Make sure Python 2.7 is the default
bash 'update-alternatives python' do
  code <<-EOH
    update-alternatives --install /usr/bin/python python /usr/bin/python3.5 1
    update-alternatives --install /usr/bin/python python /usr/bin/python2.7 2
  EOH
end

# Install any required python modules
bash 'install-python-modules' do
  code <<-EOH
    pip install boto3==1.4.6
    pip install docker==2.5.0
  EOH
end

# Install docker repository
bash 'install-docker-repo' do
  code <<-EOH
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce=17.06.0~ce-0~ubuntu
  EOH
end

# Enable Docker at startup
service 'docker' do
  action :enable
end

# give ubuntu user access to docker commands
bash 'ubuntu-docker-access' do
  code <<-EOH
    usermod -a -G docker ubuntu
  EOH
end

# make a tmp directory for docker build
directory '/tmp/docker' do
  owner 'ubuntu'
  group 'ubuntu'
  mode '0755'
  action :create
end

# copy in files for docker build
cookbook_file 'DockerFile' do
  group 'root'
  mode '0755'
  owner 'ubuntu'
  path '/tmp/docker/Dockerfile'
  source 'Dockerfile'
end

cookbook_file 'security.groovy' do
  group 'root'
  mode '0755'
  owner 'ubuntu'
  path '/tmp/docker/security.groovy'
  source 'security.groovy'
end

cookbook_file 'plugins.txt' do
  group 'root'
  mode '0755'
  owner 'ubuntu'
  path '/tmp/docker/plugins.txt'
  source 'plugins.txt'
end

bash 'build_jenkins' do
  cwd '/tmp/docker'
  code <<-EOH
    docker build -t jenkins:seis .
  EOH
end
