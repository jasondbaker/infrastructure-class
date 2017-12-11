cloudcli Cookbook
=============
Installs cloud provider CLI tools and provide custom resources which expose the cloud tools to cookbooks.

CLI Tools Supported
-------------------
* aws-cli

Requirements
------------

* Chef 12.5 or higher

Tested Platforms
----------------
* Ubuntu 14.04
* CentOS 6.5
* Amazon 2015.09.2

Attributes
----------
All attributes are located under `node['cloudcli']`

| Attribute  | Description                                             | Example            | Default     |
|------------|---------------------------------------------------------|--------------------|-------------|
| version    | The version of awscli to install                        | 1.4.0              | nil (latest)|
| virtualenv | Python virtualenv you would like to install awscli into | /home/ubuntu/my_ve | nil         |

Recipes
-------

### default
Installs the awscli tools.

Resources/Providers
-------------------

### cloudcli_aws_s3_file
#### Actions

| Action | Description                       |
|--------|-----------------------------------|
| :get   | Download a file from an s3 bucket |

#### Attribute Parameters

| Parameter             | Description                                                                               | Default        |
|-----------------------|-------------------------------------------------------------------------------------------|----------------|
| aws_access_key_id     | AWS API Access Key ID                                                                     | nil            |
| aws_secret_access_key | AWS API Secret Access Key                                                                 | nil            |
| path                  | Location to store downloaded file                                                         | name attribute |
| bucket                | S3 bucket name                                                                            |                |
| key                   | S3 Key name to download                                                                   |                |
| checksum              | Sha256 checksum to validate download                                                      | nil            |
| region                | AWS endpoint region                                                                       | us-east-1      |
| timeout               | Number of seconds to wait for download to complete                                        | 900            |
| owner                 | The owner of the downloaded file                                                          | root           |
| group                 | The group name the file should be grouped into                                            | root           |
| mode                  | The mode to set on the file. Setting to nil, leaves this to the operating system defaults | nil            |

#### Usage Examples
```ruby
# Provide all credential information to download file and store it to /tmp/testfile
cloudcli_aws_s3_file '/tmp/testfile' do
  aws_access_key_id 'YOUR_ACCESS_KEY_ID'
  aws_secret_access_key 'YOUR_SECRET_ACCESS_KEY'
  region 'us-west-2'
  bucket 'my-test-bucket'
  key 'my_large_file.gz'
  checksum '37f9405a23d1e53082dbe9ea0ef19ec8791c778a6ecd0b02a6c1af2cf9bd4847'
  timeout 1200
  owner 'testuser'
  group 'testgroup'
  mode '0644'
end
```

```ruby
# Do not pass any credentials to provider because our instance is on EC2 and uses an IAM Profile
cloudcli_aws_s3_file '/tmp/testfile' do
  bucket 'my-test-bucket'
  key 'my_large_file.gz'
end
```

### cloudcli_aws_credentials
This resource allows you to setup credential files for aws-cli. The resource is designed to only
write out the credentials file once. Because of this, you can write multiple profiles for the same
credentials file with multiple calls to this resource. Take a look at the examples section for
an example of this behavior.

#### Actions
| Action  | Description                    |
|---------|--------------------------------|
| :create | Create an AWS credentials file |
| :delete | Remove the credentials file    |

#### Attribute Parameters
| Parameter           | Description                                                                     | Default        |
|---------------------|---------------------------------------------------------------------------------|----------------|
| path                | Location to write the credentials file                                          | name attribute |
| profile             | The name of the profile for this set of credentials                             | `default`      |
| credential_params   | Hash of additional configuration key=value pairs to set in the credentials file | {}             |
| owner               | Credentials file owner                                                          | `root`         |
| group               | Credentials file group                                                          | `root`         |
| mode                | Credentials file mode                                                           | 0600           |

#### Usage Examples
```ruby
# Standard configuration setting access key, secret key and region
cloudcli_aws_credentials '/etc/aws/credentials' do
  owner 'testuser'
  group 'testuser'
  mode 0600
  credential_params(
    aws_access_key_id: 'ASDASDASKD123',
    aws_secret_access_key: 'TESTPASS12345',
    region: 'us-west-2'
  )
end

```

```ruby
cloudcli_aws_credentials '/etc/aws/credentials' do
  owner 'testuser'
  group 'testuser'
  profile 'primary'
  mode 0600
  credential_params(
    aws_access_key_id: 'ASDASDASKD123',
    aws_secret_access_key: 'TESTPASS12345',
    region: 'us-west-2'
  )
end

# Creating a cross-account role profile named secondary in the same credentials file
# as the `primary` profile defined above.
cloudcli_aws_credentials '/etc/aws/credentials' do
  owner 'root'
  group 'root'
  mode 0660
  profile 'secondary'
  credential_params(
    region: 'eu-west-2',
    role_arn: 'arn:aws:iam::123456789012:role/testingchef'
  )
end

```

```ruby
# Configuring S3 threading parameters
s3_config = <<EOF

  max_concurrent_requests=20
  max_queue_size=10000
  multipart_threshold=64MB
  multipart_chunksize=16MB
EOF

cloudcli_aws_credentials '/home/testuser/.aws/credentials' do
  owner 'testuser'
  group 'testuser'
  mode 0600
  credential_params(
    aws_access_key_id: 'TEST123',
    aws_secret_access_key: 'SECRETKEY!',
    s3: s3_config
  )
end

```

Testing
-------
In order to run the integration tests for this cookbook, you must have a valid AWS account and go through a few setup steps.
__*Please note, you may incur AWS fees when executing the kitchen integration tests.*__

### Local Configuration
The testing suites are setup to use environment variables to pass in end user specific information.

#### Variables used by .kitchen.yml
These variables are used to setup the `test_get` and `profile_test_get` (kitchen-ec2 only) suites. Kitchen will setup proper
node attributes based on these variables. See the .kitchen.yml file for information on which variables are set.

```bash
export TEST_AWS_ACCESS_KEY_ID=
export TEST_AWS_SECRET_ACCESS_KEY=
export TEST_AWS_REGION=
export TEST_BUCKET=
export TEST_KEY=
export TEST_CHECKSUM=
```

#### Variables used by .kitchen.ec2.yml
The .kitchen.ec2.yml file is used to test within EC2. In order to use it, you must configure proper AWS security credentials
as well as a few other settings. Take a look at .kitchen.ec2.yml to see which specific kitchen-ec2 variables are set from
these environment variables.

```bash
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_KEYPAIR_NAME=
export AWS_REGION=
export AWS_SUBNET_ID=
export AWS_AVAILABILITY_ZONE=
export EC2_SSH_KEY_PATH=
export AWS_IAM_PROFILE=
export AWS_UBUNTU_1404_AMI=
export AWS_AMAZON_AMI=
```

### AWS Configuration

#### `test_get` suite dependencies
The following items need to be setup properly in order to use the `test_get` suite.

* AWS S3 Bucket containing a test file
* AWS IAM Account with at least GetObject access to the bucket setup in the previous step
* AWS IAM Account API keys for the account setup in the previous step

#### `profile_test_get` suite dependencies
The following items need to be setup properly in order to use the `profile_test_get` suite.

* AWS S3 Bucket containing a test file
* AWS IAM Role/Profile with at least GetObject access to the bucket setup in the previous step
* AWS IAM Account API Keys for an account with enough access to run an EC2 instance

### Executing the integration tests
The `test_get` suite will download the file by
providing the credentials configured via the environment. Those files
will then be verified against the checksum you set via
`TEST_CHECKSUM`.  If the checksum does not match the downloaded file,
the tests will fail.

__Note: kitchen-ec2 profile support is waiting for a release. If you would like to test with
IAM profiles, you will need to build the kitchen-ec2 gem from source.__

The `profile_test_get` suite is only available when using the
kitchen-ec2 driver. The .kitchen.cloud.yml file is configured to use
the kitchen-ec2 driver. To enable this file, set the
`KITCHEN_LOCAL_YAML` environment variable to the path for the
.kitchen.cloud.yml file.

* IAM Role Documentation: http://docs.aws.amazon.com/IAM/latest/UserGuide/role-usecase-ec2app.html
* kitchen-ec2 plugin repository: https://github.com/test-kitchen/kitchen-ec2

Contributing
------------

1. Fork the repository on Github: <https://help.github.com/articles/fork-a-repo>
2. Clone the repository locally:

    ```bash
    $ git clone http://github.com/nickryand/cloudcli-cookbook
    ```

3. Create a named feature branch:

    ```bash
    $ cd cloudcli-cookbook
    $ git checkout -b [new feature branch]
    ```

4. Add your change(s)
5. Write tests for your change(s):
6. Install the gem dependencies:

    ```bash
    $ bundle install
    ```
7. Run the integration and spec tests to ensure they all pass:

    ```bash
    bundle exec rake integration
    ```
8. Run the style tests to ensure they all pass:

    ```bash
    bundle exec rake style
    ```
9. Update the README.md with new information if applicable.
10. Commit and push your changes up to your feature branch
11. Submit a Pull Request

License and Authors
-------------------
- Author:: Christopher Licata (<cmlpolyglotdev@gmail.com>)
- Author:: Nick Downs (<nickryand@gmail.com>)

```
Copyright 2017 Christopher Licata
Copyright 2016 Nick Downs
Copyright 2014 Amazon Web Services

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
