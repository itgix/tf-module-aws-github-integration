output "github_oidc_provider_arn" {
  value       = try(aws_iam_openid_connect_provider.github.arn, null)
  description = "GitHub OIDC Provider ARN"
}

output "terraform_role_arn" {
  value       = try(aws_iam_role.itgix_landing_zone_github_integration.arn, null)
  description = "IAM Role assumed by GitHub Actions"
}
