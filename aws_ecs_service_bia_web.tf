resource "aws_ecs_service" "bia" {
  name            = "service-bia-tf"
  cluster         = aws_ecs_cluster.bia_cluster_tf.id
  task_definition = aws_ecs_task_definition.bia-web.arn
  desired_count   = 1
  
//O bloco capacity_provider_strategy é usado para especificar qual capacity provider o ECS deve usar para executar as tarefas. Neste caso, estamos usando o capacity provider criado anteriormente, que está associado ao Auto Scaling Group.
  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.bia_capacity_provider_tf.name
    base              = 1
    weight            = 100
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent = 100

//O bloco lifecycle é usado para ignorar mudanças na configuração do desired_count, 
//o que significa que mesmo que o desired_count seja alterado manualmente ou por outro processo, 
//o Terraform não irá tentar corrigir essa mudança, 
//permitindo que o ECS ajuste a quantidade de tarefas conforme necessário sem interferência do Terraform.
  lifecycle {
    ignore_changes = [desired_count]
  }
}