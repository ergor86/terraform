resource "aws_ecr_repository" "bia_ecr_repo_tf" {
    name = "bia-ecr-repo-tf"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = false
    }
    force_delete = true
}