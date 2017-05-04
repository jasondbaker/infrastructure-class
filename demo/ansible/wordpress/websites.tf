provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

resource "aws_instance" "wordpress" {
    count = "2"
    ami = "ami-b63769a1"
    instance_type = "t2.micro"
    subnet_id = "subnet-63d4222a"
    vpc_security_group_ids = ["sg-7b221001"]
    key_name = "seis665"
    tags {
      Name = "web${count.index}"
      sshUser = "ec2-user"
      role = "webserver"
    }

    connection {
      # default username for AMI
      user = "ec2-user"
      private_key = "${file("/Users/jbaker/.ssh/seis665.pem")}"
    }

}

