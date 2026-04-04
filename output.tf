output "instance_id" {
  description = "ID da instancia EC2 criada"
  value       = aws_instance.bia-terraform.id
}

output "instance_type" {
  description = "Tipo da instancia EC2 criada"
  value       = aws_instance.bia-terraform.instance_type
}

output "instance_security_groups" {
  description = "Grupos de segurança associados à instancia EC2 criada"
  value       = aws_instance.bia-terraform.security_groups
}

output "instance_public_ip" {
  description = "Endereço IP público da instancia EC2 criada"
  value       = aws_instance.bia-terraform.public_ip
}

output "rds_endpoint" {
  description = "Endpoint da instância RDS criada"
  value       = aws_db_instance.bia-db-tf.endpoint
}

output "rds_secrets" {
  description = "Secrets associado ao RDS"
  value       = one(aws_db_instance.bia-db-tf.master_user_secret).secret_arn
}

output "rds_secrets_name" {
  description = "Nome do Segredo"
  value       = data.aws_secretsmanager_secret.bia_db.name
}

output "bia_ecr_repo_tf_url" {
  description = "URL do repositório ECR"
  value = aws_ecr_repository.bia_ecr_repo_tf.repository_url
}