resource "aws_iam_role" "ecs_iam_role" {
    name = "container-era-ecs-instance-role"
    path = "/"
    assume_role_policy = file("./ec2_assume_role_policy.json")
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
    name = "container-era-ecs-instance-profile"
    role = aws_iam_role.ecs_iam_role.name
}

resource "aws_iam_policy" "ecs_instance_policy" {
    name = "container-era-ecs-instance-policy"
    path = "/"
    description = ""
    policy = file("./ecs_instance_policy.json")
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attach" {
    role = aws_iam_role.ecs_iam_role.name
    policy_arn = aws_iam_policy.ecs_instance_policy.arn
}