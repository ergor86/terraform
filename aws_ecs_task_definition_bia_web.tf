resource "aws_ecs_task_definition" "bia-web" {
  family = "task-def-bia-tf"
  network_mode       = "bridge"
  
    container_definitions = jsonencode([{
      name         = "bia",
      image        = "${aws_ecr_repository.bia_ecr_repo_tf.repository_url}:latest",
      essential    = true
      portMappings = [{ containerPort = 8080, hostPort = 80 }],
      cpu    = 1024
      memoryReservation = 400
      environment = [
        { name = "DB_PORT", value = "5432" },
        { name = "DB_HOST", value = "${aws_db_instance.bia-db-tf.address}" } //endpoint sem a porta
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
}