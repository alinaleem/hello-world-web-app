provider "aws" {
  region = "us-east-1"  # Change to your preferred AWS region
}

resource "aws_instance" "ubuntu_instance" {
  ami           = "ami-0d8d212151c86b1c6"  # Ubuntu 22.04 AMI ID for us-east-1, adjust if using a different region
  instance_type = "t2.micro"  # Free tier eligible instance type

  tags = {
    Name = "Terraform Instance"
  }

  key_name = "createlypair.pem"  # Replace with your existing EC2 key pair name

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt upgrade -y",
      "sudo apt install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/createlypair.pem")  # Path to your private key
      host        = self.public_ip
    }
  }
}
