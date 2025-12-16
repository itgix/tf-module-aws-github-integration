data "aws_iam_policy_document" "github_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:${var.github_org}/${var.github_repo}:ref:refs/heads/${var.github_branch}"
      ]
    }
  }
}

resource "aws_iam_role" "itgix_landing_zone_github_integration" {
  name                 = "itgix-landing-zone-github-integration"
  assume_role_policy   = data.aws_iam_policy_document.github_assume_role.json
  max_session_duration = 3600

  tags = {
    Name      = "itgix-landing-zone-github-integration"
    ManagedBy = "Terraform"
    Project   = "ITGix Landing Zone"
  }
}

locals {
  managed_policy_arns = var.aws_managed_iam_policies
}

resource "aws_iam_role_policy_attachment" "github_managed" {
  for_each = toset(local.managed_policy_arns)

  role       = aws_iam_role.itgix_landing_zone_github_integration.name
  policy_arn = each.value
}


data "aws_iam_policy_document" "github_scoped_iam" {
  statement {
    sid       = "IAMReadAccess"
    effect    = "Allow"
    actions   = ["iam:Get*", "iam:List*", "cloudformation:ListExports"]
    resources = ["*"]
  }

  statement {
    sid    = "ManageProjectRoles"
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:UpdateRole",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:UpdateAssumeRolePolicy",
      "iam:TagRole",
      "iam:UntagRole",
    ]
    resources = [
      "arn:aws:iam::${var.target_account_id}:role/itgix-landing-zone-*"
    ]
  }

  statement {
    sid     = "PassRoleToServices"
    effect  = "Allow"
    actions = ["iam:PassRole"]
    resources = [
      "arn:aws:iam::${var.target_account_id}:role/itgix-landing-zone-*"
    ]
    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["eks.amazonaws.com", "ec2.amazonaws.com"]
    }
  }

  statement {
    sid       = "STSGetCallerIdentity"
    effect    = "Allow"
    actions   = ["sts:GetCallerIdentity"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "github_scoped_iam" {
  name   = "itgix-landing-zone-github-iam-scoped"
  policy = data.aws_iam_policy_document.github_scoped_iam.json
}

resource "aws_iam_role_policy_attachment" "github_scoped_iam" {
  role       = aws_iam_role.itgix_landing_zone_github_integration.name
  policy_arn = aws_iam_policy.github_scoped_iam.arn
}
