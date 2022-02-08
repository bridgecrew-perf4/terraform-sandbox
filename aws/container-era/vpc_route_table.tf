resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "container-era-pubic-rtb"
    }
}

resource "aws_route_table_association" "public1_route_table_associations" {
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_route_table.id
} 

resource "aws_route_table_association" "public2_route_table_associations" {
    subnet_id = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_route_table.id
} 

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id
}