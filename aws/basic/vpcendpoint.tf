resource "aws_vpc_endpoint" "s3" {
    vpc_id = aws_vpc.tf_vpc.id
    service_name = "com.amazonaws.ap-northeast-1.s3"
    vpc_endpoint_type = "Gateway"
}

resource "aws_vpc_endpoint" "ecr_dkr" {
    vpc_id = aws_vpc.tf_vpc.id
    service_name = "com.amazonaws.ap-northeast-1.ecr.dkr"
    vpc_endpoint_type = "Interface"
    subnet_ids = [ aws_subnet.tf_private_subnet_1a.id, aws_subnet.tf_private_subnet_1c.id ]
    security_group_ids  = [aws_security_group.trocco-ecr-vpc-endpoint-sg.id]
    private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_api" {
    vpc_id = aws_vpc.tf_vpc.id
    service_name = "com.amazonaws.ap-northeast-1.ecr.api"
    vpc_endpoint_type = "Interface"
    subnet_ids = [ aws_subnet.tf_private_subnet_1a.id, aws_subnet.tf_private_subnet_1c.id ]
    security_group_ids  = [aws_security_group.trocco-ecr-vpc-endpoint-sg.id]
    private_dns_enabled = true
  
}