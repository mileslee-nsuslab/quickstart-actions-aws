terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.24.0"
    }
  }
  backend "s3" {
    bucket         = "nsuslab-devops-terraform-state"
    key            = "digger/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = false
    dynamodb_table = "nsuslab-devops-lock-table"
    role_arn       = "arn:aws:iam::651482608654:role/assumable-cicd-role"
  }
}



provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

resource "aws_instance" "vm_instance" {
  ami             = "ami-05c13eab67c5d8861"                   # us-east-1 Amazon Linux 2023 AMI 2023.2.20231030.1 x86_64 HVM kernel-6.1
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.vpc_subnet.id
  security_groups = [aws_security_group.security_group.id]
  tags = {
    Name = "terraform-instance"
  }
}

