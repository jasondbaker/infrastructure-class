packer {
    required_plugins {
      amazon = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/amazon"
      }
    }
}

source "amazon-ebs" "webserver" {
    //TODO
}
  
build {
    sources = ["source.amazon-ebs.webserver"]

    provisioner "shell" {
        inline = [
            //TODO
        ]
    }

    provisioner "ansible-local" {
        playbook_file = "webserver-playbook.yml"
    }
}
