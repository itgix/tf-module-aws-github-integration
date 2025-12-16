variable "github_oidc_thumbprints" {
  type        = list(string)
  description = "GitHub OIDC provider thumbprints"
  default     = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

variable "target_account_id" {
  type        = string
  description = "Target AWS account ID where we will setup a role that can be assumbed by a Github actions pipeline, it usually should be the account ID where this module is actually called"
}

variable "aws_managed_iam_policies" {
  type        = list(string)
  description = "List of AWS managed policies to be assigned to the IAM role that gets assumed from Github actions"
}

variable "list_of_github_repos" {
  type        = list(string)
  description = "A list of github repos to provide access for, should be provided in the format - repo:<github_org>/<github_repo>:ref:refs/heads/<branch_name>"
}
