resource "aws_ecr_repository" "gatus" {
    name = "gatus-repo"

    image_tag_mutability = "MUTABLE"

    lifecycle {
    prevent_destroy = true
  }
    
}