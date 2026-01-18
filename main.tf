provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform-apache-key"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "apache_sg" {
  name        = "apache-sg"
  description = "Allow SSH and HTTP"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "apache_server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.terraform_key.key_name

  vpc_security_group_ids = [aws_security_group.apache_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Apache Server Deployed using Terraform</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Terraform-Apache-Server"
  }
}
