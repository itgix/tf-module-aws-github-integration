// https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/
resource "aws_iam_openid_connect_provider" "github" {

  url = "https://token.actions.githubusercontent.com"

  // This will allow the AWS Security Token Service (AWS STS) API to be called by this IdP (Github)
  client_id_list = [
    "sts.amazonaws.com"
  ]

  // github_oidc_thumbprints are SHA-1 fingerprints of the TLS certificates used by https://token.actions.githubusercontent.com
  // AWS uses them to trust the HTTPS certificate chain when validating GitHub’s OIDC tokens.
  // GitHub’s official documentation (recommended). GitHub explicitly publishes the thumbprint AWS expects you to use.
  // Current thumbprint (widely used): 6938fd4d98bab03faadb97b34396831e3780aea1 
  // This value comes from the DigiCert Global Root G2 certificate used by GitHub Actions.
  // https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html
  thumbprint_list = var.github_oidc_thumbprints

  tags = {
    Name      = "GitHub-OIDC-Provider"
    ManagedBy = "Terraform"
    Project   = "ITGix Landing Zone"
  }
}
