output "ecr_demo_app_url" {
  description = "URL of the ECR repository for demo app"
  value       = aws_ecr_repository.demo_app.repository_url
}
