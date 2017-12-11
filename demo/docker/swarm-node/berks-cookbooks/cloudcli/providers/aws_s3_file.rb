#
# Cookbook Name:: cloudcli
# provider:: aws_s3_file
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
require 'chef/mixin/shell_out'
require 'chef/scan_access_control'

include Chef::Mixin::ShellOut
include Chef::Mixin::EnforceOwnershipAndPermissions

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = ::Chef::Resource.resource_for_node(:cloudcli_aws_s3_file, node).new(new_resource.name)
  @current_resource.bucket(new_resource.bucket)
  @current_resource.key(new_resource.key)
  @current_resource.path(new_resource.path)
  @current_resource.region(new_resource.region)
  @current_resource.checksum(nil)

  if ::File.exist?(new_resource.path)
    @current_resource.checksum(Chef::Digester.checksum_for_file(new_resource.path))
  end

  # Approach using a similar method to the built-in file resource.
  # https://github.com/chef/chef/blob/master/lib/chef/provider/file.rb
  unless Chef::Platform.windows?
    acl_scanner = ScanAccessControl.new(@new_resource, @current_resource)
    acl_scanner.set_all!
  end

  @current_resource
end

action :get do
  # We do not want to download the file if we are able to validate the local file if it exists.
  if new_resource.checksum.nil? || new_resource.checksum != current_resource.checksum
    event = "download s3://#{new_resource.bucket}/#{new_resource.key} and store it at #{new_resource.path}"
    converge_by(event) do
      Chef::Log.info(event)
      new_resource.updated_by_last_action(true) if s3_get
    end
  end
end

def s3_get
  cmd = node['cloudcli']['aws']['binary'] +
        ' s3 cp ' \
        "s3://#{new_resource.bucket}/#{new_resource.key} " +
        new_resource.path
  s3_cmd(cmd)

  return unless access_controls.requires_changes?
  converge_by(access_controls.describe_changes) do
    access_controls.set_all
  end
end

def s3_cmd(command)
  # Setup Environment for aws cli to run in.
  environment = {}
  environment['AWS_DEFAULT_REGION'] = new_resource.region
  environment['AWS_ACCESS_KEY_ID'] = new_resource.aws_access_key_id unless new_resource.aws_access_key_id.nil?
  environment['AWS_SECRET_ACCESS_KEY'] = new_resource.aws_secret_access_key unless new_resource.aws_secret_access_key.nil?

  # Shell out options
  options = { :timeout => new_resource.timeout, :environment => environment }
  shell_out!(command, options)
end

# Borrowing from the file resource in core chef
def manage_symlink_access?
  false
end
