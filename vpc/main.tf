resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "test_pubsub" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Test-VPC-PUB-SUB"
  }
}

resource "aws_subnet" "test_pvtsub" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "Test-VPC-PVT-SUB"
  }
}

resource "aws_internet_gateway" "tigw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "Test-VPC-IGW"
  }
}

resource "aws_route_table" "test_pubrt" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tigw.id
  }

  tags = {
    Name = "Test-VPC-PUB-RT"
  }
}

resource "aws_route_table_association" "pubrtasso" {
  subnet_id      = aws_subnet.test_pubsub.id
  route_table_id = aws_route_table.test_pubrt.id
}

resource "aws_eip" "test_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "test_tnat" {
  allocation_id = aws_eip.test_eip.id
  subnet_id     = aws_subnet.test_pubsub.id

  tags = {
    Name = "Test-VPC-NAT"
  }
}

resource "aws_route_table" "test_pvtrt" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.test_tnat.id
  }

  tags = {
    Name = "Test-VPC-PVT-RT"
  }
}

resource "aws_route_table_association" "pvtasso" {
  subnet_id      = aws_subnet.test_pvtsub.id
  route_table_id = aws_route_table.test_pvtrt.id
}

