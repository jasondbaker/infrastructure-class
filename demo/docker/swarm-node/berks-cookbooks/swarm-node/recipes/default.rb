#
# Cookbook Name:: swarm-node
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
  'python' => nil,
  'python-pip' => nil
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

# Install any required python modules
# Install cloudformation helper scripts
bash 'install-python-modules' do
  code <<-EOH
    pip install awscli
    pip install boto3==1.7.4
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
