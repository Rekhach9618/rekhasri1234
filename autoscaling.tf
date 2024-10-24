









provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "PublicSubnet1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/16"  # Adjust as needed
  availability_zone = "us-east-1a"
}

resource "aws_autoscaling_group" "terraform" {
  vpc_zone_identifier = [aws_subnet.PublicSubnet1.id]

  launch_template {
    id      = aws_launch_template.terraform.id
    version = "$Latest"
  }

  min_size         = 1
  max_size         = 2
  desired_capacity  = 1
}

resource "aws_launch_template" "terraform" {
  name          = "terraform-launch-template"
  image_id     = "ami-0ddc798b3f1a5117e"  # Replace with a valid AMI ID
  instance_type = "t2.micro"

  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo "Hello, World!" > /var/tmp/hello.txt
  EOF
  )

  
}


