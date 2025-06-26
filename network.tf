# Create VPC Network
resource "aws_vpc" "devnet" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC DEVNET"
  }
}

# Create VPC Public Subnet 1
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.devnet.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = var.azs[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1"
  }
}

# Create VPC Public Subnet 2
resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.devnet.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone       = var.azs[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 2"
  }
}

# Create VPC Private Subnet 1
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.devnet.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.azs[0]

  tags = {
    Name = "Private Subnet 1"
  }
}

# Create VPC Private Subnet 2
resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.devnet.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.azs[1]

  tags = {
    Name = "Private Subnet 2"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "devnetgw" {
  vpc_id = aws_vpc.devnet.id

  tags = {
    Name = "Internet Gateway"
  }
}

# Create Default Public Route Table
resource "aws_route_table" "devnetpubrt" {
  vpc_id = aws_vpc.devnet.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devnetgw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Create Public Route Table for Public Subnet 1
resource "aws_route_table_association" "public_ass1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.devnetpubrt.id
}

# Create Public Route Table for Public Subnet 2
resource "aws_route_table_association" "public_ass2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.devnetpubrt.id
}

# Create NAT Gateway
resource "aws_eip" "devnet_nat_eip" {
  tags = {
    Name = "NAT Gateway"
  }
}

# Allocate NAT GW in Public Net
resource "aws_nat_gateway" "devnetnatgw" {
  allocation_id = aws_eip.devnet_nat_eip.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "nat-gateway"
  }

  depends_on = [aws_internet_gateway.devnetgw]
}

# Create route table for Private Subnet
resource "aws_route_table" "devnetprivrt" {
  vpc_id = aws_vpc.devnet.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.devnetnatgw.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

# Create Route Table for Private Subnet 1
resource "aws_route_table_association" "private_ass1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.devnetprivrt.id
}

# Create Route Table for Private Subnet 2
resource "aws_route_table_association" "private_ass2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.devnetprivrt.id
}