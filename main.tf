provider "aws" {
  region = "ap-south-1"
}

# -------------------------
# VPC
# -------------------------
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "custom-vpc"
  }
}

# -------------------------
# PUBLIC SUBNET
# -------------------------
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# -------------------------
# INTERNET GATEWAY
# -------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "vpc-igw"
  }
}

# -------------------------
# ROUTE TABLE
# -------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# -------------------------
# SECURITY GROUP
# -------------------------
resource "aws_security_group" "apache_sg" {
  name   = "apache-sg"
  vpc_id = aws_vpc.main.id

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

  tags = {
    Name = "apache-sg"
  }
}

# -------------------------
# KEY PAIR
# -------------------------
resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform-apache-key"
  public_key = file(var.public_key_path)
}

# -------------------------
# EC2 INSTANCE + APACHE
# -------------------------
resource "aws_instance" "apache_server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.apache_sg.id]
  key_name                    = aws_key_pair.terraform_key.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Apache Deployed Using Terraform (Custom VPC)</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "terraform-apache-server"
  }
}
