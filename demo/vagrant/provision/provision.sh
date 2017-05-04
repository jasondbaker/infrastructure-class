#!/bin/bash

# System provisioning script
#
yum update -y
yum install nginx -y
service nginx start
