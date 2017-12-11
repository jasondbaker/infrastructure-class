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
if defined?(ChefSpec)
  def get_cloudcli_aws_s3_file(path)
    ChefSpec::Matchers::ResourceMatcher.new(:cloudcli_aws_s3_file, :get, path)
  end

  def create_cloudcli_aws_credentaisl(path)
    ChefSpec::Matchers::ResourceMatcher.new(:cloudcli_aws_credentials, :create, path)
  end

  def delete_cloudcli_aws_credentaisl(path)
    ChefSpec::Matchers::ResourceMatcher.new(:cloudcli_aws_credentials, :delete, path)
  end
end
