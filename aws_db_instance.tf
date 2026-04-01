# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_db_instance" "bia-db-tf" {
  allocated_storage                     = 20
  allow_major_version_upgrade           = null
  apply_immediately                     = null
  auto_minor_version_upgrade            = true
  //availability_zone                     = "us-east-1a"
  backup_retention_period               = 1
  backup_target                         = "region"
  backup_window                         = "03:57-04:27"
  ca_cert_identifier                    = "rds-ca-rsa2048-g1"
  copy_tags_to_snapshot                 = true
  custom_iam_instance_profile           = null
  customer_owned_ip_enabled             = false
  database_insights_mode                = "standard"
  dedicated_log_volume                  = false
  delete_automated_backups              = true
  deletion_protection                   = false
  domain                                = null
  domain_auth_secret_arn                = null
  domain_iam_role_name                  = null
  domain_ou                             = null
  enabled_cloudwatch_logs_exports       = []
  engine                                = "postgres"
  engine_lifecycle_support              = "open-source-rds-extended-support-disabled"
  engine_version                        = "17.6"
  final_snapshot_identifier             = null
  iam_database_authentication_enabled   = false
  identifier                            = "bia-db-tf"
  instance_class                        = "db.t3.micro"
  iops                                  = 0
  kms_key_id                            = "arn:aws:kms:us-east-1:632872792512:key/0f4c4d41-1b0e-447f-9baa-4891650aaaea"
  license_model                         = "postgresql-license"
  maintenance_window                    = "tue:10:24-tue:10:54"
  manage_master_user_password           = true
  max_allocated_storage                 = 0
  monitoring_interval                   = 0
  multi_az                              = false
  network_type                          = "IPV4"
  option_group_name                     = "default:postgres-17"
  parameter_group_name                  = "default.postgres17"
  password                              = null # sensitive
  password_wo                           = null # sensitive
  password_wo_version                   = null
  performance_insights_enabled          = false
  performance_insights_retention_period = 0
  port                                  = 5432
  publicly_accessible                   = false
  replicate_source_db                   = null
  skip_final_snapshot                   = true
  storage_encrypted                     = true
  storage_throughput                    = 0
  storage_type                          = "gp2"
  tags                                  = {}
  tags_all                              = {}
  upgrade_storage_config                = null
  username                              = "postgres"
  vpc_security_group_ids                = [aws_security_group.bia-db.id]
  db_subnet_group_name                   = aws_db_subnet_group.bia-db-tf-subnet-group.name
}

resource "aws_db_subnet_group" "bia-db-tf-subnet-group" {
  name       = "bia-db-tf-subnet-group"
  subnet_ids = [local.subnet_zona_a, local.subnet_zona_b]

  tags = {
    Name = "bia-db-tf-subnet-group"
  }
}