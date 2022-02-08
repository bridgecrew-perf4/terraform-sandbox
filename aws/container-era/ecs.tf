resource "aws_instance" "container_era_instance" {
    ami = "ami-03d79d440297083e3"
    instance_type = "t3.small"
    monitoring = true
    iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.name
    subnet_id = aws_subnet.public_subnet_1.id
    user_data = file("./scripts/user_data.sh")
    associate_public_ip_address = true
    vpc_security_group_ids = [
        "${aws_security_group.ecs_sg.id}",
    ]
    root_block_device {
        volume_size = "30"
        volume_type = "gp3"
    }
}
