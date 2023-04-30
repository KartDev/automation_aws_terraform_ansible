provider "aws" {
  region = "eu-north-1" 
}

resource "tls_private_key" "example_key_pair" {
  algorithm = "RSA"
}

resource "aws_key_pair" "example_key_pair" {
  key_name   = "example_key_pair"
  public_key = tls_private_key.example_key_pair.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.example_key_pair.private_key_pem
  filename = "example_key_pair.pem"
  file_permission = "0600"
}

resource "aws_security_group" "webapp_sg" {
  name        = "webapp_sg"
  description = "Allow inbound traffic for the web application"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "webapp_instance" {
  ami           = "ami-0577c11149d377ab7" 
  instance_type = "t3.micro"

  key_name = aws_key_pair.example_key_pair.key_name

    tags = {
    Name = "webapp_instance"
  }
}

output "instance_public_ip" {
  value = aws_instance.webapp_instance.public_ip
}
