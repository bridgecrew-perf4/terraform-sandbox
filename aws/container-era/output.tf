output "oidc_arn" {
  value = aws_iam_openid_connect_provider.oidc_provider.arn
}

output "role_arn" {
  value = aws_iam_role.github_actions_role.arn
}

output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}