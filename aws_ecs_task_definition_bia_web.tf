resource "aws_ecs_task_definition" "bia-web" {
  family = "task-def-bia-tf"
  requires_compatibilities = ["EC2"] // Especifica que a tarefa é compatível com o tipo de lançamento EC2, o que significa que as tarefas serão executadas em instâncias EC2 gerenciadas pelo ECS.
  network_mode       = "bridge"
  task_role_arn     = aws_iam_role.ecs_task_role.arn //Referência à role do IAM criada para a tarefa, que tem as permissões necessárias para acessar o Secrets Manager
    container_definitions = jsonencode([{
      name         = "bia",
      image        = "${aws_ecr_repository.bia_ecr_repo_tf.repository_url}:latest",
      essential    = true
      portMappings = [{ containerPort = 8080, hostPort = 80 }],
      cpu    = 1024
      memoryReservation = 400
      environment = [
        { name = "DB_PORT", value = "5432" },
        { name = "DB_HOST", value = "${aws_db_instance.bia-db-tf.address}" }, //endpoint sem a porta
        { name = "DB_SECRET_NAME", value = "${data.aws_secretsmanager_secret.bia_db.name}" }, /// nome do secret do Secrets Manager, que será usado pela aplicação para buscar as credenciais do banco de dados
        { name = "DB_REGION", value = "us-east-1" }, // região onde o Secrets Manager está localizado
        { name = "DEBUG_SECRET", value = "false" }
      ]
      logConfiguration = {
        logDriver = "awslogs",
          options = {
            "awslogs-region"        = "us-east-1",
            "awslogs-group"         = aws_cloudwatch_log_group.bia_log_group_tf.name, //referência ao recurso do log group criado
            "awslogs-stream-prefix" = "bia"
          }
      },
    }])

    runtime_platform { //Arquitetura e sistema operacional para a tarefa
      operating_system_family = "LINUX"
      cpu_architecture        = "X86_64"
    }
}