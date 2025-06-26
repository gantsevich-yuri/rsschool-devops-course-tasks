# Create Security Group for access from WAN net
resource "aws_security_group" "wan" {
  name        = "wan_sg"
  description = "Allow ssh inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.devnet.id
}

# Allow only inbound ssh traffic from WAN
resource "aws_security_group_rule" "wan_ssh_in" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.wan.id
}

# Allow all trafic from bastion
resource "aws_security_group_rule" "wan_all_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.wan.id
}

# Create Security Group for LAN net
resource "aws_security_group" "lan" {
  name        = "lan_sg"
  description = "Allow all internal and all outbound traffic"
  vpc_id      = aws_vpc.devnet.id
}

# Allow inbound ALL LAN traffic 
resource "aws_security_group_rule" "lan_all_in" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.lan.id
}

# Allow all trafic from LAN
resource "aws_security_group_rule" "lan_all_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lan.id
}