data "aws_secretsmanager_secret" "bia_db" {
    arn = one(aws_db_instance.bia-db-tf.master_user_secret).secret_arn
}
