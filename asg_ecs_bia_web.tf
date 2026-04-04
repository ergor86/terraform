resource "aws_autoscaling_group" "ecs_asg_tf" {
    name_prefix = "bia-cluster-tf-asg-"
    max_size = 2
    min_size = 0
    desired_capacity = 1
    launch_template {
        id = aws_launch_template.ecs_ec2_tf.id
        version = aws_launch_template.ecs_ec2_tf.latest_version
    }
    vpc_zone_identifier = [local.subnet_zona_a, local.subnet_zona_b]
    health_check_type = "EC2"
    health_check_grace_period = 0
     protect_from_scale_in = false

//Etiqueta para identificar as instâncias do ASG, o valor pode ser o mesmo para todas as instâncias, mas a chave é importante para que possamos identificar facilmente quais instâncias pertencem a este ASG.
    tag {
        key = "Name"
        value = "bia-cluster-tf"
        propagate_at_launch = true
    }

// Etiqueta para identificar que esta ASG é gerenciada por um cluster ECS, o valor pode ser vazio, mas a chave é importante para que o ECS possa reconhecer e gerenciar as instâncias corretamente.
    tag {
        key = "AmazonECSManaged"
        value = ""
        propagate_at_launch = true
    }
//sempre que detectar mudanças na configuração do ASG, ele irá iniciar um processo de atualização das instâncias, onde ele irá substituir as instâncias antigas pelas novas, garantindo que a configuração esteja sempre atualizada e consistente.
    instance_refresh {
        strategy = "Rolling"
    }
}