data "tls_certificate" "github_actions" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

resource "aws_iam_openid_connect_provider" "github_actions" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  # ref: https://qiita.com/minamijoyo/items/eac99e4b1ca0926c4310
  # ref: https://zenn.dev/yukin01/articles/github-actions-oidc-provider-terraform
  thumbprint_list = [data.tls_certificate.github_actions.certificates[0].sha1_fingerprint]
}

module "iam_github_oidc_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version = "5.33.0"

  name = "github-oidc-iam-role"
  # This should be updated to suit your organization, repository, references/branches, etc.
  subjects = ["Akito-Fujihara/github-actions-aws-oidc:*"]

  policies = {
    AdminRole = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }
}
