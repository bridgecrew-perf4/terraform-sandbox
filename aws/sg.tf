# resource "aws_security_group" "trocco-ecr-vpc-endpoint-sg" {
#   name   = "trocco-ecr-vpc-endpoint-sg"
#   description = "Allow HTTPS access to ECR endpoints from within VPC"
#   vpc_id = aws_vpc.tf_vpc.id

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [aws_vpc.tf_vpc.cidr_block]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#       Name = "trocco-ecr-vpc-endpoint-sg"
#   }
# }

resource "aws_security_group" "aurora_sg" {
  name   = "aurora-sg"
  description = "Allow MySQL access from within VPC"
  vpc_id = aws_vpc.tf_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.tf_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = "aurora-sg"
  }
}