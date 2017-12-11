#
# Cookbook Name:: cloudcli
# Resources:: aws_s3_file
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

actions :get

default_action :get

attribute :bucket, :kind_of => String
attribute :path, :kind_of => String, :name_attribute => true
attribute :key, :kind_of => String
attribute :aws_access_key_id, :kind_of => [String, NilClass], :default => nil
attribute :aws_secret_access_key, :kind_of => [String, NilClass], :default => nil
attribute :checksum, :kind_of => [String, NilClass], :default => nil
attribute :region, :kind_of => String, :default => 'us-east-1'
attribute :timeout, :kind_of => Integer, :default => 900
attribute :owner, :kind_of => String, :default => 'root'
attribute :group, :kind_of => String, :default => 'root'
attribute :mode, :kind_of => [String, Integer, NilClass], :default => nil
