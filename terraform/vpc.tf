# VPC定義
resource "aws_vpc" "tf_vpc" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name  = "tf-vpc"
    Owner = "tada"
  }
}

resource "aws_subnet" "tf_public_subnet_1c" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = "10.10.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name  = "tf-public-subnet-1c"
    Owner = "tada"
  }

}

resource "aws_subnet" "tf_public_subnet_1a" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name  = "tf-public-subnet-1a"
    Owner = "tada"
  }
}

resource "aws_subnet" "tf_private_subnet_1a" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name  = "tf-private-subnet-1a"
    Owner = "tada"
  }
}
