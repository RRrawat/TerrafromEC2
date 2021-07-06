provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "terraform_ec2_example" {
    ami = "ami-0ab4d1e9cf9a1215a"
    instance_type = "t2.micro"
    key_name = "Practic_key"
    tags = {
        Name = "Terraform_Practice"
    }

}
resource "aws_default_vpc" "main_vpc" {
    tags = {
        Name = "main_vpc"
    }
}
resource "aws_security_group" "TerraformEC2_SG" {
  name        = "TerraformEC2_SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_default_vpc.main_vpc.id

  
  ingress {
    description      = "Inbound rules from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_default_vpc.main_vpc.cidr_block]
    
  }
  ingress {
    description      = "Inbound rules from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_default_vpc.main_vpc.cidr_block]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "TerraformEC2_SG"
  }
}
