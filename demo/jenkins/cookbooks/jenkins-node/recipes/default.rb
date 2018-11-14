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
  'jq' => nil,
  'python3' => nil,
  'python3-pip' => nil
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

node.default['cloudcli']['aws']['version'] = '1.15.0'
include_recipe 'cloudcli::awscli'

# Make sure Python 2.7 is the default
bash 'update-alternatives python' do
  code <<-EOH
    update-alternatives --install /usr/bin/python python /usr/bin/python3.5 1
    update-alternatives --install /usr/bin/python python /usr/bin/python2.7 2
  EOH
end

# Install any required python modules
# Install cloudformation helper scripts
bash 'install-python-modules' do
  code <<-EOH
    pip install boto3==1.6.22
    pip install docker==3.2.0
    pip install https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz
  EOH
end

# Install docker repository
bash 'install-docker-repo' do
  code <<-EOH
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce
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
directory '/tmp/docker/jenkins' do
  owner 'ubuntu'
  group 'ubuntu'
  mode '0755'
  recursive true
  action :create
end

directory '/tmp/docker/jenkinsagent' do
  owner 'ubuntu'
  group 'ubuntu'
  mode '0755'
  recursive true
  action :create
end

directory '/workspace' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# copy in files for docker build
cookbook_file 'jenkins/DockerFile' do
  group 'root'
  mode '0755'
  owner 'ubuntu'
  path '/tmp/docker/jenkins/Dockerfile'
  source 'jenkins/Dockerfile'
end

cookbook_file 'jenkins/security.groovy' do
  group 'root'
  mode '0755'
  owner 'ubuntu'
  path '/tmp/docker/jenkins/security.groovy'
  source 'jenkins/security.groovy'
end

cookbook_file 'jenkins/plugins.txt' do
  group 'root'
  mode '0755'
  owner 'ubuntu'
  path '/tmp/docker/jenkins/plugins.txt'
  source 'jenkins/plugins.txt'
end

cookbook_file 'jenkinsagent/Dockerfile' do
  group 'root'
  mode '0755'
  owner 'ubuntu'
  path '/tmp/docker/jenkinsagent/Dockerfile'
  source 'jenkinsagent/Dockerfile'
end

cookbook_file 'jenkinsagent/run.sh' do
  group 'root'
  mode '0755'
  owner 'ubuntu'
  path '/tmp/docker/jenkinsagent/run.sh'
  source 'jenkinsagent/run.sh'
end

# build jenkins server image
bash 'build_jenkins' do
  cwd '/tmp/docker/jenkins'
  code <<-EOH
    docker build -t jenkins:seis .
  EOH
end

# build jenkinsagent image
bash 'build_jenkinsagent' do
  cwd '/tmp/docker/jenkinsagent'
  code <<-EOH
    docker build -t jenkinsagent:seis .
  EOH
end
