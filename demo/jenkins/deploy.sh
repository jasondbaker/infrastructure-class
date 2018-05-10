#!/bin/bash

aws s3 cp jenkins-cf.json s3://seis665/jenkins-cf.json --region us-east-1 --acl public-read
