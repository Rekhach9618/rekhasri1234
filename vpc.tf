provider "aws" {
  region = "us-east-1"  # Change this to your preferred AWS region
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"  # Change as needed

  tags = {
    Name = "ExampleVPC"
  }
}

# Create a public subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.1.0/24"  # Change as needed
  availability_zone       = "us-east-1a"    # Change as needed

  map_public_ip_on_launch = true  # Ensure instances get public IPs on launch

  tags = {
    Name = "PublicSubnet"
  }
}

# Create a private subnet
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.2.0/24"  # Change as needed
  availability_zone       = "us-east-1b"    # Change as needed

  tags = {
    Name = "PrivateSubnet"
  }
}

# Create an Internet Gateway (for public subnet access)
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "ExampleIGW"
  }
}

# Create a route table for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

# Associate the public route table with the public subnet
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create a NAT Gateway (for private subnet outbound access)
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "ExampleNATGateway"
  }
}

# Create a route table for private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name = "PrivateRouteTable"
  }
}

# Associate the private route table with the private subnet
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# (Optional) Create a security group for instances in the private subnet
resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.example.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["10.0.0.0/16"]  # Allow internal communication
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }

  tags = {
    Name = "PrivateSG"
  }
}


