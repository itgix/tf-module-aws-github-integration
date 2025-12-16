Terraform module used by the ITGix AWS Landing Zone

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.github_scoped_iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.itgix_landing_zone_github_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.github_managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.github_scoped_iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.github_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.github_scoped_iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_managed_iam_policies"></a> [aws\_managed\_iam\_policies](#input\_aws\_managed\_iam\_policies) | List of AWS managed policies to be assigned to the IAM role that gets assumed from Github actions | `list(string)` | n/a | yes |
| <a name="input_github_branch"></a> [github\_branch](#input\_github\_branch) | GitHub branch allowed to assume the role | `string` | n/a | yes |
| <a name="input_github_oidc_thumbprints"></a> [github\_oidc\_thumbprints](#input\_github\_oidc\_thumbprints) | GitHub OIDC provider thumbprints | `list(string)` | <pre>[<br/>  "6938fd4d98bab03faadb97b34396831e3780aea1"<br/>]</pre> | no |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | GitHub organization or username | `string` | n/a | yes |
| <a name="input_github_repo"></a> [github\_repo](#input\_github\_repo) | GitHub repository name | `string` | n/a | yes |
| <a name="input_target_account_id"></a> [target\_account\_id](#input\_target\_account\_id) | Target AWS account ID where we will setup a role that can be assumbed by a Github actions pipeline, it usually should be the account ID where this module is actually called | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_integration_iam_role_arn"></a> [github\_integration\_iam\_role\_arn](#output\_github\_integration\_iam\_role\_arn) | IAM Role assumed by GitHub Actions |
| <a name="output_github_oidc_provider_arn"></a> [github\_oidc\_provider\_arn](#output\_github\_oidc\_provider\_arn) | GitHub OIDC Provider ARN |
<!-- END_TF_DOCS -->
