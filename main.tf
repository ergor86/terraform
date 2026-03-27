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
  vpc_id      = "vpc-0dbde5a1a4dbb8487"

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

    user_data = <<-EOF
#!/bin/bash

#Instalar Docker, Git, jq e AWS CLI
sudo yum update -y
sudo yum install git -y
sudo yum install docker -y
sudo yum install jq -y

#Instalar AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo yum install unzip -y
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker ssm-user
id ec2-user ssm-user
sudo newgrp docker

#Ativar docker
sudo systemctl enable docker.service
sudo systemctl start docker.service

#Instalar docker compose 2
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose


#Adicionar swap
sudo dd if=/dev/zero of=/swapfile bs=128M count=32
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo "/swapfile swap swap defaults 0 0" >> /etc/fstab


#Instalar node e npm
curl -fsSL https://rpm.nodesource.com/setup_21.x | sudo bash -
sudo yum install -y nodejs

#Configurar python 3.11 e uv para uso com mcp servers da aws
sudo dnf install python3.11 -y
sudo ln -sf /usr/bin/python3.11 /usr/bin/python3

sudo -u ec2-user bash -c 'curl -LsSf https://astral.sh/uv/install.sh | sh'
echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/ec2-user/.bashrc 
  EOF
}
