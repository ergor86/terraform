# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "role-acesso-ssm"
resource "aws_iam_instance_profile" "role-acesso-ssm" {
  name     = "role-acesso-ssm"
  path     = "/"
  role     = aws_iam_role.role-acesso-ssm.name
  tags     = {}
  tags_all = {}
}

# __generated__ by Terraform from "role-acesso-ssm"
resource "aws_iam_role" "role-acesso-ssm" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::aws:policy/AWSElasticBeanstalkReadOnly", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess", "arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/AmazonECS_FullAccess", "arn:aws:iam::aws:policy/AmazonRDSFullAccess", "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "arn:aws:iam::aws:policy/SecretsManagerReadWrite"]
  max_session_duration  = 3600
  name                  = "role-acesso-ssm"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
}
