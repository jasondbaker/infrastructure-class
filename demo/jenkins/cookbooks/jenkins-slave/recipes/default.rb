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
  'ant' => '1.9.6-1ubuntu1',
  'jq' => '1.5+dfsg-1',
  'openjdk-8-jdk' => '8u151-b12-0ubuntu0.16.04.2',
  'python' => '2.7.11-1',
  'python-pip' => '8.1.1-2ubuntu0.4',
}

pkgs.each do |pkg, version|
  package pkg do
    version version
    action :install
  end
end

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
    pip install boto3==1.4.6
    pip install docker==2.5.0
    pip install https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz
    pip install awscli
  EOH
end

# Install docker repository
bash 'install-docker-repo' do
  code <<-EOH
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce=17.09.0~ce-0~ubuntu
  EOH
end

# Enable Docker at startup
service 'docker' do
  action :enable
end

# create a jenkins user
user 'jenkins' do
  system true
  shell '/bin/false'
end

# copy jenkins swarm-agent
bash 'jenkins-swarm-agent' do
  code <<-EOH
    wget -q https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.3/swarm-client-3.3.jar -P /home/jenkins/
  EOH
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
