#
# Cookbook Name:: cloudcli
# Recipe:: _aws_windows
#
# Copyright 2016 Nick Downs
# Copyright 2014 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.
#
remote_file "#{Chef::Config[:file_cache_path]}/cloudcli.msi" do
  source node['cloudcli']['aws']['windows_url']
end

windows_package 'aws_cli_installation' do
  source "#{Chef::Config[:file_cache_path]}/cloudcli.msi"
  action :install
end
