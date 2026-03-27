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

//security group
resource "aws_security_group" "bia-tf" {
  name        = "bia-tf"
  description = "Regra para a instacia EC2 bia-terraform"
  vpc_id      = local.vpc_id

  tags = {
    Name = "bia-tf"
  }
}

resource "aws_vpc_security_group_ingress_rule" "bia-tf-3001-ipv4" {
  security_group_id = aws_security_group.bia-tf.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3001
  ip_protocol       = "tcp"
  to_port           = 3001
}

resource "aws_vpc_security_group_ingress_rule" "bia-tf-3001-ipv6" {
  security_group_id = aws_security_group.bia-tf.id
  cidr_ipv6         = "::/0"
  from_port         = 3001
  ip_protocol       = "tcp"
  to_port           = 3001
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.bia-tf.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.bia-tf.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

//EC2 Instance
resource "aws_instance" "bia-terraform" {
    ami="ami-02f3f602d23f1659d"
    instance_type="t3.micro"
    tags = {
        Name = var.instance_name
        ambiente = "dev"
    }
    vpc_security_group_ids = [aws_security_group.bia-tf.id]
    root_block_device {
        volume_size = 12
    }

    iam_instance_profile = aws_iam_instance_profile.role-acesso-ssm.name
    user_data_replace_on_change = true

    user_data = "${file("user_data.sh")}"
}