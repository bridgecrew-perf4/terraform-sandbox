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

# resource "aws_subnet" "tf_public_subnet_1d" {
#   vpc_id                  = aws_vpc.tf_vpc.id
#   cidr_block              = "10.10.5.0/24"
#   map_public_ip_on_launch = true
#   availability_zone       = "ap-northeast-1d"

#   tags = {
#     Name  = "tf-public-subnet-1d"
#     Owner = "tada"
#   }
# }

resource "aws_subnet" "tf_private_subnet_1a" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name  = "tf-private-subnet-1a"
    Owner = "tada"
  }
}

resource "aws_subnet" "tf_private_subnet_1c" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = "10.10.4.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name  = "tf-private-subnet-1c"
    Owner = "tada"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf-public"
  }
}

resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public.id
  gateway_id             = "igw-0e1154ca948ec3011"
}

# Association
resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.tf_public_subnet_1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1c" {
  subnet_id      = aws_subnet.tf_public_subnet_1c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private_1a" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf-private-1a"
  }
}

# resource "aws_route" "private_1a" {
#   route_table_id         = aws_route_table.private_1a.id
# }

resource "aws_vpc_endpoint_route_table_association" "private_1a" {
  vpc_endpoint_id         = aws_vpc_endpoint.s3.id
  route_table_id = aws_route_table.private_1a.id
}

