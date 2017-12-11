#
# Cookbook Name:: cloudcli
# Resources:: config
#
# Copyright (C) 2016 Nick Downs
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

actions :create, :delete

default_action :create

attribute :path, kind_of: String, name_attribute: true
attribute :profile, kind_of: String, default: 'default'
attribute :credential_params, kind_of: Hash, default: {}
attribute :owner, kind_of: String, default: 'root'
attribute :group, kind_of: String, default: 'root'
attribute :mode, kind_of: [String, Integer], default: 0600
