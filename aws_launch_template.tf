data "aws_ssm_parameter" "ecs_node_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "ecs_ec2_tf" {
  name_prefix = "cluster-bia-web-"
  image_id = data.aws_ssm_parameter.ecs_node_ami.value
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.bia-web.id]
  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_node.arn
  }
  monitoring {
    enabled = true
  }
  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo ECS_CLUSTER=${aws_ecs_cluster.bia_cluster_tf.name} >> /etc/ecs/ecs.config
    EOF
  )
}