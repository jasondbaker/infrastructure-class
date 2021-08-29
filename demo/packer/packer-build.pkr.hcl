packer {
  required_plugins {
    amazon = {
    version = ">= 0.0.1"
    source = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "packer" {
  ami_name = "packer-build-node-${local.timestamp}"
  ami_groups = ["all"]  # make the image publicly available
  ami_regions = ["us-east-2"]
  ami_virtualization_type = "hvm"
  ebs_optimized = true
  instance_type = "t3.micro"
  region = "us-east-1"
  shutdown_behavior = "terminate"
  ssh_username = "ec2-user"
  ssh_timeout = "1h"
  tags = {
    description = "Packer build server"
  }

  aws_polling {
    delay_seconds = 60
    max_attempts = 60
  }

  launch_block_device_mappings {
    device_name = "/dev/xvda"
    volume_size = "8"
    volume_type = "gp3"
    delete_on_termination = true
  }

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name = "amzn2-ami-hvm*-gp2"
      root-device-type = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners = ["amazon"]
  }
}

build {
  sources = ["source.amazon-ebs.packer"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y yum-utils",
      "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo",
      "sudo yum -y install packer",
    ]
  }

}
