data "aws_iam_policy_document" "ecs-instance-role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs-instance-role" {
  name = "ecs-instance-role-tf"
  assume_role_policy = data.aws_iam_policy_document.ecs-instance-role.json
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-policy" {
  role = aws_iam_role.ecs-instance-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role = aws_iam_role.ecs-instance-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ecs_node" {
  name = "ecs-instance-role-tf-profile"
  role = aws_iam_role.ecs-instance-role.name
  path = "/ecs/instance/"
}

/*
# IAM Role utilizada pelas instâncias EC2 do cluster ECS

#

# Essa role permite que as instâncias EC2 atuem como "workers" do ECS.

# Ela é assumida pelo serviço EC2 (sts:AssumeRole com ec2.amazonaws.com)

# e vinculada às instâncias através de um Instance Profile.

#

# Principais responsabilidades:

# - Registrar a instância no cluster ECS

# - Receber e executar tarefas (containers)

# - Baixar imagens do Amazon ECR

# - Enviar logs e métricas para o CloudWatch

# - Permitir acesso remoto via AWS Systems Manager (SSM), sem necessidade de SSH

#

# Policies associadas:

# - AmazonEC2ContainerServiceforEC2Role:

# Permite integração da instância com o ECS (registro, execução de tasks, comunicação com o serviço)

#

# - AmazonSSMManagedInstanceCore:

# Permite gerenciamento da instância via SSM (Session Manager, Run Command, etc)

#

# Sem essa role, a instância EC2 não consegue se registrar no ECS

# nem executar containers corretamente.

#

# Observação:

# Essa é uma EC2 Instance Role (nível de infraestrutura),

# diferente de:

# - Task Role (usada pelos containers)

# - Execution Role (usada pelo agente do ECS)
*/