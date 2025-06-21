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
  instance_type               = "t3.micro"          
  subnet_id                   = aws_subnet.public1.id  
  security_groups             = [aws_security_group.wan.id]
  associate_public_ip_address = true 
  source_dest_check           = false

  key_name = "aws-ubuntu-home"   
  
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y iptables-persistent
              sysctl -w net.ipv4.ip_forward=1
              iptables -t nat -A POSTROUTING -o eth0 -s 0.0.0.0/0 -j MASQUERADE
              netfilter-persistent save
              echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
              EOF

  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "private_vm1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"          
  subnet_id                   = aws_subnet.private1.id  
  security_groups             = [aws_security_group.lan.id]
  associate_public_ip_address = false

  key_name = "aws-ubuntu-home"   

  tags = {
    Name = "vm1"
  }
}

