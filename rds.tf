provider "aws" {
   region = "us-east-1"
}
resource "aws_security_group" "demo-rds-sg" {
   name = "secgroup123"
   description = "awssecuritygroup"
 #vpc_id = aws_vpc.demo-vpc.id
      ingress {
       from_port = 3306
       to_port = 3306
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
      }
      egress {
         from_port =0
         to_port = 65535
         protocol ="tcp"
         cidr_blocks = ["0.0.0.0/0"]
      }
   tags = {
       name ="secgroup"
   }
}
resource "aws_db_instance" "default" {
 allocated_storage    = 30
 db_name              = "mydb"
 engine               = "mysql"
 engine_version       = "8.0.35"
 instance_class       = "db.t3.micro"
 username             = "admin"
 password             = "Password"
 publicly_accessible = "true"
 parameter_group_name = "default.mysql8.0"
 skip_final_snapshot  = true
 #vpc_security_group_ids =  [aws_securiy_group.demo-rds-sg.id]
}
