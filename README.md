The Terraform module is used by the ITGix AWS Landing Zone - https://itgix.com/itgix-landing-zone/

# AWS GitHub Integration Terraform Module

This module sets up GitHub Actions OIDC integration with AWS, creating an IAM OIDC provider and an IAM role that can be assumed by GitHub Actions workflows.

Part of the [ITGix AWS Landing Zone](https://itgix.com/itgix-landing-zone/).

## Resources Created

- IAM OIDC provider for GitHub Actions
- IAM role with trust policy for GitHub Actions
- Managed policy attachments to the IAM role

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `github_oidc_thumbprints` | GitHub OIDC provider thumbprints | `list(string)` | `["6938fd4d98bab03faadb97b34396831e3780aea1"]` | no |
| `target_account_id` | Target AWS account ID where the assumable role is created | `string` | — | yes |
| `aws_managed_iam_policies` | List of AWS managed policies to assign to the IAM role | `list(string)` | — | yes |
| `list_of_github_repos` | List of GitHub repos to provide access for (format: `repo:<org>/<repo>:ref:refs/heads/<branch>`) | `list(string)` | — | yes |

## Outputs

| Name | Description |
|------|-------------|
| `github_oidc_provider_arn` | GitHub OIDC Provider ARN |
| `github_integration_iam_role_arn` | IAM Role assumed by GitHub Actions |

## Usage Example

```hcl
module "github_integration" {
  source = "path/to/tf-module-aws-github-integration"

  target_account_id = "123456789012"

  aws_managed_iam_policies = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]

  list_of_github_repos = [
    "repo:my-org/my-repo:ref:refs/heads/main"
  ]
}
```
