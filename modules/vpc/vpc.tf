resource "aws_vpc" "vhugo_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_subnet" "subnet-1-public" {
  vpc_id     = aws_vpc.vhugo_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1c"
  tags = {
    Name = "${var.name}-subnet-public"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vhugo_vpc.id

  tags = {
    Name = "${var.name}-rt-public"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vhugo_vpc.id

  tags = {
    Name = "${var.name}-ig"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1-public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gateway.id
}
