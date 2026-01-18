variable "vpc_cidr" {
  description = "CIDR block for VPC"
}

variable "subnet_cidr" {
  description = "CIDR block for public subnet"
}

variable "ami" {
  description = "AMI ID for EC2 instance"
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "public_key_path" {
  description = "Path to SSH public key"
}
