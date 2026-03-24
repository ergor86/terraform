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