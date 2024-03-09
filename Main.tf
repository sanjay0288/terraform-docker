provider "aws" {
  region = "ap-south-1" 
}
# Define variables
variable "Docker_Serv" {
  description = "Name of the VM to be created"
  default     = "Docker_Inst"
}

# Resource block to create a new VM instance
resource "aws_instance" "docker_server" {
  ami             = "ami-03f4878755434977f"
  instance_type   = "t2.micro"
  security_groups = ["launch-wizard-1"]
  key_name        = "Sanjay"

  tags = {
    Name = var.Docker_Serv
  }
}

# Execute shell commands to install Docker
resource "null_resource" "install_docker" {
  depends_on = [aws_instance.docker_server]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/ubuntu/.ssh/sanjay.pem")
      host        = aws_instance.docker_server.public_ip
    }
  }
}

# Clone source code from Git repository
resource "null_resource" "clone_git_repository" {
  depends_on = [null_resource.install_docker]

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ubuntu/workspace",
      "git clone https://sanjay0288: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@github.com/sanjay0288/linux_shellscripts.git /home/ubuntu/workspace"
    ]
    
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/ubuntu/.ssh/sanjay.pem")
    host        = aws_instance.docker_server.public_ip
  }
}

# Define the command to execute the script with path.module
resource "null_resource" "github_push" {
  depends_on = [null_resource.clone_git_repository]

  provisioner "local-exec" {
    command = "bash ${path.module}/script.sh ${aws_instance.docker_server.public_ip}"
  }

  # Pass the public IP to the script as a variable
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/ubuntu/.ssh/sanjay.pem")
    host        = aws_instance.docker_server.public_ip
  }
}
