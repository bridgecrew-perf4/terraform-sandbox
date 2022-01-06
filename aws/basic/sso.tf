# data "aws_ssoadmin_permission_set" "Administrator" {
#   instance_arn = tolist(data.aws_ssoadmin_instances.example.arns)[0]
#   name         = "AdministratorAccess"
# }

# resource "aws_ssoadmin_account_assignment" "kobayashi_account_assignment" {
#     instance_arn = data.aws_ssoadmin_permission_set.Administrator.instance_arn
#     permission_set_arn = data.aws_ssoadmin_permission_set.Administrator.arn
#     target_type = "AWS_ACCOUNT"
# }