resource "aws_ecr_repository" "demo_app" {
  name = "${var.repository_name}-demo"

  image_scanning_configuration {
    scan_on_push = true
  }

}
