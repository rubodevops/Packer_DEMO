locals {
  private_key_path = "/home/rubo/aws-demo777.pem"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                  = "us-east-2"
  access_key = "xxxxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxx"
  #profile                 = "default"
}

data "aws_ami" "ubuntu" {
    owners =["self"]
    most_recent = true

    filter {
        name   = "name"
        values = ["packer_AWS_*"]
    }
}

resource "aws_instance" "myec2" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  key_name               = "aws-demo777"
  security_groups = [ aws_security_group.ec2.name ]
}

 
  
  
