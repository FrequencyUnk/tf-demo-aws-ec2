terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.23.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.2.0"
    }
  }
}

provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "ubuntu" {
  ami           = "${data.aws_ami.latest-ubuntu.id}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "${var.name}"
    ttl = "24h"
    owner = "jeremy" 
    se-region = "C1" 
    purpose = "Demo"
    terraform = "True"
  }
}

data "aws_ami" "latest-ubuntu" {
most_recent = true
owners = ["099720109477"] # Canonical

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

