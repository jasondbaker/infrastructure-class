#
# Cookbook Name:: webserver-failover
# Recipe:: default
#

bash 'yum update' do
  code <<-EOH
    yum update -y
  EOH
end

# Install base packages
pkgs = {
  'httpd' => '2.2.34-1.16.amzn1',
  'php' => '5.3.29-1.8.amzn1',
  'jq' => '1.5-1.2.amzn1',
}

pkgs.each do |pkg, version|
  package pkg do
    version version
    action :install
  end
end

# Enable http at startup
service 'httpd' do
  action :enable
end


# copy in html files
cookbook_file 'website/index.php' do
  mode '0644'
  owner 'ec2-user'
  path '/var/www/html/index.php'
  source 'website/index.php'
end

