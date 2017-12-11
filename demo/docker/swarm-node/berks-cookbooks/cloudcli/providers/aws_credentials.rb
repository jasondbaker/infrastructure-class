#
# Cookbook Name:: cloudcli
# provider:: aws_credentials
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

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

def add_config_to_state(path, profile, params)
  # Multiple calls for the same path and profile will overwrite
  # the previous settings
  node.run_state[path] = {} unless node.run_state.key?(path)
  node.run_state[path][profile] = params
end

action :create do
  add_config_to_state(
    new_resource.path,
    new_resource.profile,
    new_resource.credential_params
  )

  # create parent directory first
  dirname = ::File.dirname(new_resource.path)
  directory dirname do
    owner new_resource.owner
    group new_resource.group
    action :create
  end

  template new_resource.path do
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
    source 'credentials.erb'
    cookbook 'cloudcli'
    variables(
      :state_key => new_resource.path
    )
    action :nothing
  end

  # This allows end-users to use the resource multiple times
  # but the template will only be run a single time.
  #
  # TODO: Refactor if this issue is resolved with a solution
  #       https://github.com/chef/chef/issues/3426
  log "create_template" do
    level :debug
    message "Create template for #{new_resource.path} #{new_resource.profile}"
    notifies :create, "template[#{new_resource.path}]", :delayed
  end
end

action :delete do
  template new_resource.path do
    source 'credentials.erb'
    cookbook 'cloudcli'
    action :delete
  end
end
