terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
    required_version = ">= 1.2.0"
}

provider "aws" {
    region = "us-east-1"
    profile = "aws-cli-sts"

    assume_role {
    role_arn     = "arn:aws:iam::632872792512:role/role-aws-cli-sts"
    session_name = "terraform-session"
    }
}

resource "aws_instance" "bia-terraform" {
    ami="ami-02f3f602d23f1659d"
    instance_type="t3.micro"
    tags = {
        Name = "bia-terraform"
        ambiente = "dev"
    }
    vpc_security_group_ids = ["sg-00441de9cbdc2d140"]
    root_block_device {
        volume_size = 8
    }
}
