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

source "amazon-ebs" "webserver" {
  ami_name = "webserver-failover-node-${local.timestamp}"
  ami_groups = ["all"]  # make the image publicly available
  ami_regions = ["us-east-2"]
  ami_virtualization_type = "hvm"
  instance_type = "t2.micro"
  region = "us-east-1"
  shutdown_behavior = "terminate"
  ssh_username = "ec2-user"
  ssh_timeout = "1h"
  tags = {
    description = "Webserver failover node for class"
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
  sources = ["source.amazon-ebs.webserver"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y amazon-linux-extras yum-utils",
      "sudo amazon-linux-extras install epel -y",
      "sudo yum install ansible pip -y",
      "sudo mkdir -p /opt/ansible/files",
      "sudo chown -R ec2-user:ec2-user /opt/ansible",
      "sudo chmod -R 750 /opt/ansible"
    ]
  }

  provisioner "ansible-local" {
    playbook_dir = "ansible"
    playbook_file = "ansible/playbook.yml"
    staging_directory = "/opt/ansible"
  }

}
