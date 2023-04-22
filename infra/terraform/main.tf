# Author - Tejas Shekokar
# Trying to provide solution as minimal as possible hence creating TF snippet in
# a single file


# We can use backend to maintain the state and locking. But I want to keep it
# simple hence not adding this complexity

provider "aws" {}

data "aws_caller_identity" "current" {}

resource "aws_security_group" "this" {
  name = "caspar-test"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"] #for testing purpose exposing port 443 and 80 to world
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
}

resource "aws_key_pair" "this" {
  key_name   = "caspar-test"
  public_key = tls_private_key.this.public_key_openssh
}

resource "aws_instance" "this" {
  ami                    = "ami-06b8d5099f3a8d79d" #minikube needs docker as pre-requisite hence using this ubuntu ami which prepacked with docker
  instance_type          = "t3.medium"
  vpc_security_group_ids = [aws_security_group.this.id]
  key_name               = aws_key_pair.this.key_name
  user_data              = file("${path.cwd}/files/user_data.sh")
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "50"
    delete_on_termination = "true"
  }
}