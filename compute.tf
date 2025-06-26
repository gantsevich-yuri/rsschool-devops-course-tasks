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
              EOF

  tags = {
    Name = "Bastion"
  }
}

resource "aws_instance" "private_vm1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private1.id
  security_groups             = [aws_security_group.lan.id]
  associate_public_ip_address = false

  key_name = "aws-ubuntu-home"

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname vm1-private
              EOF

  tags = {
    Name = "Private vm1"
  }
}

resource "aws_instance" "private_vm2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private2.id
  security_groups             = [aws_security_group.lan.id]
  associate_public_ip_address = false

  key_name = "aws-ubuntu-home"

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname vm2-private
              EOF

  tags = {
    Name = "Private vm2"
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

