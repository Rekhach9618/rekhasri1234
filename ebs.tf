provider "aws" {
  region = "us-east-1"  # Change this to your preferred AWS region
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Example AMI ID (Amazon Linux 2)
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}

resource "aws_ebs_volume" "example" {
  availability_zone = aws_instance.example.availability_zone
  size              = 10  # Size in GB

  tags = {
    Name = "ExampleEBSVolume"
  }
}

resource "aws_volume_attachment" "example" {
  device_name = "/dev/sdf"  # Change this to your desired device name
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.example.id
}

