variable "public_key" {
  type        = string
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "dkernel_key" {
  key_name   = "Demokeys"
  public_key = var.public_key
}
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx_server" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.dkernel_key.key_name
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              set -eux

              # Update system
              yum update -y

              # Install nginx
              amazon-linux-extras enable nginx1
              yum clean metadata
              yum install -y nginx

              systemctl enable nginx
              systemctl start nginx

              # Create user
              id dkernel &>/dev/null || useradd -m dkernel

              # Sudo privileges
              echo "dkernel ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/dkernel
              chmod 440 /etc/sudoers.d/dkernel

              # SSH setup (FIXED: stable and reliable)
              mkdir -p /home/dkernel/.ssh
              echo "${var.public_key}" > /home/dkernel/.ssh/authorized_keys

              chown -R dkernel:dkernel /home/dkernel/.ssh
              chmod 700 /home/dkernel/.ssh
              chmod 600 /home/dkernel/.ssh/authorized_keys

              # Fix SELinux context (important on AWS images sometimes)
              restorecon -R /home/dkernel/.ssh || true
              EOF

  tags = {
    Name = "nginx-server"
  }
}
