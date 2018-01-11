name 'jenkins-slave' # ~FC078
maintainer 'Jason Baker'
maintainer_email 'bake2352@stthomas.edu'
license 'All rights reserved'
description 'Installs/Configures a Jenkins slave node'
long_description 'Installs/Configures a Jenkins slave node'
version '0.1.0'
chef_version '>= 12'
supports 'ubuntu'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/ccp-aws-deploy/issues'
# if respond_to?(:issues_url)
issues_url 'https://github.com/jasondbaker/infrastructure-class/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/ccp-aws-deploy'
# if respond_to?(:source_url)
source_url 'https://github.com/jasondbaker/infrastructure-class' if respond_to?(:source_url)

depends 'docker', '~> 2.15.15'
