provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

resource "aws_instance" "class-server" {
    ami = "ami-b73b63a0"
    instance_type = "t2.micro"
    subnet_id = "subnet-63d4222a"
    vpc_security_group_ids = ["sg-7b221001"]
    key_name = "seis665"
    tags {
      Name = "class-server-tf"
      Project = "Fido"
    }

    connection {
      # default username for AMI
      user = "ec2-user"
      private_key = "${file("/Users/jbaker/.ssh/seis665.pem")}"
    }

    # run a remote provisioner on the instance
    # install nginx and start the web server
    provisioner "remote-exec" {
      inline = [
        "sudo yum update -y",
        "sudo yum install nginx -y",
        "sudo service nginx start",
      ]
    }
}

output "ip" {
  value = "${aws_instance.class-server.public_ip}"
}

