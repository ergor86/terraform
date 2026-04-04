//Criação do capacity provider 
//A função do capacity provider é permitir que o ECS gerencie a capacidade de instâncias EC2 para executar as tarefas. 
//Ele se integra com o Auto Scaling para ajustar automaticamente a capacidade com base na demanda das tarefas.
resource "aws_ecs_capacity_provider" "bia_capacity_provider_tf" {
  name = "capacity-provider-bia-tf"
  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.ecs_asg_tf.arn
    managed_termination_protection = "DISABLED"
    managed_scaling {
      status = "ENABLED"
      target_capacity = 100
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 2
    }
  }
}

//Associa o capacity provider ao cluster
resource "aws_ecs_cluster_capacity_providers" "bia_cluster_capacity_providers_tf" {
  cluster_name = aws_ecs_cluster.bia_cluster_tf.name
  capacity_providers = [aws_ecs_capacity_provider.bia_capacity_provider_tf.name]
  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.bia_capacity_provider_tf.name
    base = 1
    weight = 100
  }
}