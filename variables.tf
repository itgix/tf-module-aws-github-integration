variable "github_org" {
  type        = string
  description = "GitHub organization or username"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository name"
}

variable "github_branch" {
  type        = string
  description = "GitHub branch allowed to assume the role"
}

variable "github_oidc_thumbprints" {
  type        = list(string)
  description = "GitHub OIDC provider thumbprints"
  default     = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

variable "target_account_id" {
  type        = string
  description = "Target AWS account ID where we will setup a role that can be assumbed by a Github actions pipeline, it usually should be the account ID where this module is actually called"
}
