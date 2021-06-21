# VPC定義
resource "aws_vpc" "tf_vpc" {
    cidr_block = "10.10.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "tf-vpc"
        Owner = "tada"
    }
}

resource "aws_subnet" "tf_public" {
    vpc_id = aws_vpc.tf_vpc.id
    cidr_block = "10.10.0.0/24"
    map_public_ip_on_launch = true
    availability_zone = "ap-northeast-1"
}