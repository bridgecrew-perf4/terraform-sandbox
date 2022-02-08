data "tls_certificate" "github" {
    url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

# oidc provider
resource "aws_iam_openid_connect_provider" "oidc_provider" {
    url = "https://token.actions.githubusercontent.com"
    client_id_list = [ "sts.amazonaws.com" ]
    thumbprint_list = [ data.tls_certificate.github.certificates[0].sha1_fingerprint ]
}

data "aws_iam_policy_document" "github_oidc_assume_role_policy" {
    statement {
      effect = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]
      principals {
        type = "Federated"
        identifiers = [aws_iam_openid_connect_provider.oidc_provider.arn]
      }
      condition {
        test = length(var.github_oidc_repo_names) == 1 ? "StringLike" : "ForAnyValue:StringLike"
        variable = "token.actions.githubusercontent.com:sub"
        values = [for item in var.github_oidc_repo_names: "repo:${var.github_owner}/${item}:*"]
        }
    }
}

resource "aws_iam_policy" "gihub_actions_policy" {
    name = "githubactions_policy"
    path = "/"
    description = "Policy for GitHub Actions"
    policy = file("./deploy_policy.json")
}

resource "aws_iam_role" "github_actions_role" {
    name = "githubactions-oidc-role"
    path = "/"
    assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role_policy.json
    managed_policy_arns = [aws_iam_policy.gihub_actions_policy.arn]
}