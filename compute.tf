data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public1.id
  security_groups             = [aws_security_group.wan.id]
  associate_public_ip_address = true
  source_dest_check           = false

  key_name = "aws-ubuntu-home"

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname bastion
              curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
              install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
              EOF

  tags = {
    Name = "Bastion"
  }
}

resource "aws_instance" "k3s_master" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private1.id
  security_groups             = [aws_security_group.lan.id]
  associate_public_ip_address = false

  key_name = "aws-ubuntu-home"

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname k3s-master
              curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='server' K3S_TOKEN=${var.k3s_token} K3S_KUBECONFIG_MODE='644' sh -s -
              EOF

  tags = {
    Name = "k3s master node"
  }
}

resource "aws_instance" "k3s_worker" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private2.id
  security_groups             = [aws_security_group.lan.id]
  associate_public_ip_address = false

  key_name = "aws-ubuntu-home"

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname k3s-worker
              K3S_URL="https://${aws_instance.k3s_master.private_ip}:6443"
              curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server $K3S_URL --token ${var.k3s_token}" sh -s -
              EOF

  tags = {
    Name = "k3s worker node"
  }
}

resource "aws_instance" "public_vm2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public2.id
  security_groups             = [aws_security_group.wan.id]
  associate_public_ip_address = true
  source_dest_check           = false

  key_name = "aws-ubuntu-home"

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname vm2-public
              EOF

  tags = {
    Name = "Public vm2"
  }
}

