resource "aws_cloudwatch_log_group" "bia_log_group_tf" {
    name = "/ecs/bia-log-group-tf"
    retention_in_days = 7
}