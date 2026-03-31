
//EC2 Instance
resource "aws_instance" "bia-terraform" {
    ami="ami-02f3f602d23f1659d"
    instance_type="t3.micro"
    tags = {
        Name = var.instance_name
        ambiente = "dev"
    }
    vpc_security_group_ids = [aws_security_group.bia-tf.id]
    root_block_device {
        volume_size = 12
    }

    iam_instance_profile = aws_iam_instance_profile.role-acesso-ssm.name
    user_data_replace_on_change = true

    user_data = "${file("user_data.sh")}"
    subnet_id = local.subnet_zona_a
    associate_public_ip_address = true // atribuir IP público IPv4 automaticamente à instância
    ipv6_address_count = 1 // atributo para solicitar um endereço IPv6 automaticamente
    key_name = "teste-terraform" // nome da chave SSH para acesso à instância
}