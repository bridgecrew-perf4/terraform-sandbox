# module "ec2_role" {
#   source     = "./module/iam"
#   name       = "isucon-role-role"
#   identifier = "spotfleet.amazonaws.com"
#   policy     = data.aws_iam_policy.spotinstance_access.policy
# }

# data "aws_iam_policy" "spotinstance_access" {
#   arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetTaggingRole"
# }

# # data "aws_iam_policy_document" "ec2_assume_role" {
# #     statement {
# #       actions = ["sts:AssumeRole"]
# #       principals {
# #             type = "Service"
# #             identifiers = ["spotfleet.amazonaws.com"]
# #             }
# #     }

# # }

# # resource "aws_iam_role" "spot-fleet-role" {
# #     name = "isucon-role"
# #     assume_role_policy = "${data.aws_iam_policy_document.ec2_assume_role.json}"
# # }

# # resource "aws_iam_policy_attachment" "policy-attach" {
# #   name = "isucon-role-policy"
# #   roles = [aws_iam_role.spot-fleet-role.id]
# #   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetTaggingRole"
# # }


# data "aws_caller_identity" "current" {}

# resource "aws_spot_fleet_request" "isucon-spot-request" {
#   iam_fleet_role = module.ec2_role.iam_role_arn

#   spot_price                          = "0.0163"
#   target_capacity                     = var.spot_target_capacity
#   terminate_instances_with_expiration = true
#   wait_for_fulfillment                = "true"
#   launch_specification {
#     ami                         = var.spot_instance_ami
#     instance_type               = "t3.medium"
#     key_name                    = "kensyo-key"
#     vpc_security_group_ids      = ["sg-0a20405a84445e7a3"]
#     subnet_id                   = aws_subnet.tf_public_subnet_1a.id
#     associate_public_ip_address = true

#     root_block_device {
#       volume_size = var.gp2_volume_size
#       volume_type = "gp2"
#     }

#     tags = {
#       Name = "isucon-instance"
#     }
#   }


# }

# data "aws_instance" "isucon-instance" {
#   filter {
#     name   = "tag:Name"
#     values = ["isucon-instance"]
#   }

#   depends_on = ["aws_spot_fleet_request.isucon-spot-request"]
# }

# output "ip" {
#   value      = data.aws_instance.isucon-instance.public_ip
#   depends_on = ["aws_spot_fleet_request.isucon-spot-request"]
# }