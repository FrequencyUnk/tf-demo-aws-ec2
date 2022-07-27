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

provider "hcp" {}

data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "learn-packer-run-tasks"
  channel     = "production"
}

data "hcp_packer_image" "ubuntu_us_east_2" {
  bucket_name    = "learn-packer-run-tasks"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
  region         = "us-east-2"
}

resource "aws_instance" "ubuntu" {
  ami           = data.hcp_packer_image.ubuntu_us_east_2.cloud_image_id
  instance_type = "t2.micro"
  tags = {
    #Name = "Learn-HCP-Packer"
    ttl = "24h"
    owner = "jeremy" 
    se-region = "C1" 
    purpose = "Demo"
    terraform = "True"
  }
}

