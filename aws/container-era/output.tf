output "oidc_arn" {
  value = aws_iam_openid_connect_provider.oidc_provider.arn
}

output "role_arn" {
  value = aws_iam_role.github_actions_role.arn
}