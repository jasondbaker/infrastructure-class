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

source "amazon-ebs" "docker" {
  ami_name = "docker-node-${local.timestamp}"
  ami_groups = ["all"]  # make the image publicly available
  ami_virtualization_type = "hvm"
  instance_type = "t2.micro"
  region = "us-east-1"
  shutdown_behavior = "terminate"
  ssh_username = "ec2-user"
  ssh_timeout = "1h"
  tags = {
    description = "Docker server"
  }

  aws_polling {
    delay_seconds = 60
    max_attempts = 60
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

  temporary_iam_instance_profile_policy_document {
    Version = "2012-10-17"
    Statement {
      Effect = "Allow"
      Action = [
        "ssm:DescribeAssociation",
        "ssm:GetDeployablePatchSnapshotForInstance",
        "ssm:GetDocument",
        "ssm:DescribeDocument",
        "ssm:GetManifest",
        "ssm:GetParameter",
        "ssm:GetParameters",
        "ssm:ListAssociations",
        "ssm:ListInstanceAssociations",
        "ssm:PutInventory",
        "ssm:PutComplianceItems",
        "ssm:PutConfigurePackageResult",
        "ssm:UpdateAssociationStatus",
        "ssm:UpdateInstanceAssociationStatus",
        "ssm:UpdateInstanceInformation"
      ]
      Resource = ["*"]
    }
    Statement {
      Effect = "Allow"
      Action = [
        "ssmmessages:CreateControlChannel",
        "ssmmessages:CreateDataChannel",
        "ssmmessages:OpenControlChannel",
        "ssmmessages:OpenDataChannel"
      ]
      Resource = ["*"]
    }
    Statement {
      Effect = "Allow"
      Action = [
        "ec2messages:AcknowledgeMessage",
        "ec2messages:DeleteMessage",
        "ec2messages:FailMessage",
        "ec2messages:GetEndpoint",
        "ec2messages:GetMessages",
        "ec2messages:SendReply"
      ]
      Resource = ["*"]
    }
    Statement {
      Effect = "Allow"
      Action = [
        "ec2:DescribeTags"
      ]
      Resource = ["*"]
    }
  }
}

build {
  sources = ["source.amazon-ebs.docker"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install ansible2 -y",
      "sudo yum install pip -y",
      "sudo mkdir -p /opt/ansible/files",
      "sudo chown -R ec2-user:ec2-user /opt/ansible",
      "sudo chmod -R 750 /opt/ansible"
    ]
  }

  provisioner "ansible-local" {
    playbook_dir = "ansible"
    playbook_file = "ansible/build-playbook.yml"
    staging_directory = "/opt/ansible"
  }

}
