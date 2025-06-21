# Create VPC Network
resource "aws_vpc" "devnet" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Create VPC Public Subnet 1
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.devnet.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = var.azs[0]
  map_public_ip_on_launch = true
}

# Create VPC Public Subnet 2
resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.devnet.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone       = var.azs[1]
  map_public_ip_on_launch = true
}

# Create VPC Private Subnet 1
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.devnet.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.azs[0]
}

# Create VPC Private Subnet 2
resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.devnet.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.azs[1]
}

# Create Internet Gateway
resource "aws_internet_gateway" "devnetgw" {
  vpc_id = aws_vpc.devnet.id
}

# Create Default Public Route Table
resource "aws_route_table" "devnetpubrt" {
  vpc_id = aws_vpc.devnet.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devnetgw.id
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

# NAT instance is creating on based t2.micro Bastion host

# Create Default Private Route Table throught NAT instance
resource "aws_route_table" "devnetprivrt" {
  vpc_id = aws_vpc.devnet.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_instance.bastion.id
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