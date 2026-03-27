terraform {
    backend "s3" {
        bucket = "bia-terraform-sts"
        key    = "state.tfstate"
        region = "us-east-1"
        profile = "aws-cli-sts"
        assume_role = {
            role_arn = "arn:aws:iam::632872792512:role/role-aws-cli-sts"
        }
    }
}