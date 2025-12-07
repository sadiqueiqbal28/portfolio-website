resource "aws_vpc" "prod_vpc" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Prod-VPC"
  }
}

resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
    Name = "Prod-IGW"
  }
}









# Public and Private Subnet (ap-south-1a)
resource "aws_subnet" "public_subnet_1a" {
  cidr_block              = "10.0.0.0/26"
  vpc_id                  = aws_vpc.prod_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "prod-public-subnet-1a"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  cidr_block        = "10.0.0.64/26"
  vpc_id            = aws_vpc.prod_vpc.id
  availability_zone = "ap-south-1a"
  tags = {
    Name = "prod-priv-subnet-1a"
  }
}

# Public and Private Subnet (ap-south-1b)
resource "aws_subnet" "public_subnet_1b" {
  cidr_block              = "10.0.0.128/26"
  vpc_id                  = aws_vpc.prod_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b"
  tags = {
    Name = "prod-public-subnet-1b"
  }
}

resource "aws_subnet" "private_subnet_1b" {
  cidr_block        = "10.0.0.192/26"
  vpc_id            = aws_vpc.prod_vpc.id
  availability_zone = "ap-south-1b"
  tags = {
    Name = "prod-priv-subnet-1b"
  }
}









# Route Table for Public and Private Subnet
resource "aws_route_table" "pub_route_table" {
  vpc_id = aws_vpc.prod_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_igw.id
  }
  tags = {
    Name = "pub-route-table"
  }
}

resource "aws_route_table" "priv_route_table_1a" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
    Name = "priv-route-table-1a"
  }
}

resource "aws_route_table" "priv_route_table_1b" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
    Name = "priv-route-table-1b"
  }
}










resource "aws_eip" "prod_eip_1" {
  domain = "vpc"
  tags = {
    Name = "prod-nat-eip-1"
  }
}

resource "aws_eip" "prod_eip_2" {
  domain = "vpc"
  tags = {
    Name = "prod-nat-eip-2"
  }
}

resource "aws_nat_gateway" "prod_nat_1a" {
  allocation_id = aws_eip.prod_eip_1.id
  subnet_id     = aws_subnet.public_subnet_1a.id
  tags = {
    Name = "Prod NAT Gateway-1A"
  }
}

resource "aws_nat_gateway" "prod_nat_1b" {
  allocation_id = aws_eip.prod_eip_2.id
  subnet_id     = aws_subnet.public_subnet_1b.id
  tags = {
    Name = "Prod NAT Gateway-1B"
  }
}

resource "aws_route" "priv_sub_route_1a" {
  nat_gateway_id         = aws_nat_gateway.prod_nat_1a.id
  route_table_id         = aws_route_table.priv_route_table_1a.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "priv_sub_route_1b" {
  nat_gateway_id         = aws_nat_gateway.prod_nat_1b.id
  route_table_id         = aws_route_table.priv_route_table_1b.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "pub_route_asso" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.pub_route_table.id
}

resource "aws_route_table_association" "pub_route_asso_2" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.pub_route_table.id
}

resource "aws_route_table_association" "priv_route_asso_1a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.priv_route_table_1a.id
}

resource "aws_route_table_association" "priv_route_asso_1b" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.priv_route_table_1b.id
}