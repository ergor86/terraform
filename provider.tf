terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.53"
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

