
resource "aws_security_group" "bia-ec2" {
  description = "acesso das EC2 com estrutura de ALB"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Acesso para internet (ECS, ECR, CloudWatch)"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = []
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.bia-alb.id]
    self             = false
    to_port          = 65535
  }]
  name                   = "bia-ec2"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-0dbde5a1a4dbb8487"
}

resource "aws_security_group" "bia-alb" {
  description = "Acesso ao Load Balancer"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "liberado para o mundo"
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 443
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "liberado para o mundo"
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]
  name                   = "bia-alb"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-0dbde5a1a4dbb8487"
}

resource "aws_security_group" "bia-web" {
  description = "Acesso do bia-web"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
    }, {
    cidr_blocks      = []
    description      = "acesso vindo de bia-alb"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.bia-alb.id]
    self             = false
    to_port          = 65535
  }]
  name                   = "bia-web"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-0dbde5a1a4dbb8487"
}

resource "aws_security_group" "bia-db" {
  description = "acesso do bia-db"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = []
    description      = "acesso bindo do bia-servless"
    from_port        = 5432
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = ["sg-06b26684d7623b194"]
    self             = false
    to_port          = 5432
    }, {
    cidr_blocks      = []
    description      = "acesso vindo das EC2 do load balancer"
    from_port        = 5432
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.bia-ec2.id]
    self             = false
    to_port          = 5432
    }, {
    cidr_blocks      = []
    description      = "acesso vindo do bia-dev"
    from_port        = 5432
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.bia-dev.id]
    self             = false
    to_port          = 5432
    }, {
    cidr_blocks      = []
    description      = "acesso vindo do bia-web"
    from_port        = 5432
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.bia-web.id]
    self             = false
    to_port          = 5432
  }]
  name                   = "bia-db"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-0dbde5a1a4dbb8487"
}

resource "aws_security_group" "bia-dev" {
  description = "Acesso do bia-dev"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "liberado para o mundo"
    from_port        = 3001
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 3001
  }]
  name                   = "bia-dev"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-0dbde5a1a4dbb8487"
}

//security group que estavam no main.tf
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

resource "aws_vpc_security_group_ingress_rule" "bia-tf-ssh-ipv4" {
  security_group_id = aws_security_group.bia-tf.id
  cidr_ipv4         = "0.0.0.0/0" # ideal restringir depois
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "bia-tf-ssh-ipv6" {
  security_group_id = aws_security_group.bia-tf.id
  cidr_ipv6         = "::/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
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
