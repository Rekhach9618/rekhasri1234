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
  availability_zone       = "us-east-1a"   # Change as needed

  tags = {
    Name = "PublicSubnet"
  }
}

# Create a private subnet
resource "aws_subnet" "private" {

