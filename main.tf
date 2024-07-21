provider "aws" {
  region = "us-east-1"  # Change to your preferred AWS region
}

resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from any IP; you might want to restrict this for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ubuntu_instance" {
  ami           = "ami-013b3de8a8fa9b39f"  # Ubuntu 22.04 AMI ID for us-east-1, adjust if using a different region
  instance_type = "t2.micro"               # Free tier eligible instance type
  key_name      = "createlypair"           # Replace with your existing EC2 key pair name
  security_groups = [aws_security_group.allow_ssh.name]  # Attach security group

  tags = {
    Name = "Terraform Instance"
  }

  provisioner "local-exec" {
    command = "sleep 120"  # Wait 2 minutes before running remote-exec
  }

  provisioner "remote-exec" {
    inline = [
      "set -x",  # Print each command as it is executed

      # Update package lists
      "sudo apt update",

      # Search for OpenJDK packages
      "sudo apt-cache search OpenJDK",

      # Install OpenJDK 17
      "sudo apt install -y openjdk-17-jdk",
      "sudo apt install -y openjdk-17-jre",
      "java -version",
      "javac -version",

      # Install Docker
      "sudo apt update",
      "sudo apt install docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",

    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/ubuntu/.ssh/createlypair.pem")  # Path to your private key
      host        = self.public_ip
    }
  }
}
