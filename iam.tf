module "iam_github_oidc_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version = "5.33.0"

  name = "github-oidc-iam-role"
  # This should be updated to suit your organization, repository, references/branches, etc.
  subjects = [
    "Akito-Fujihara/github-actions-aws-oidc:*",
  ]

  policies = {
    AdminRole = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }
}
