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

# Create Security Group for LAN net
resource "aws_security_group" "lan" {
  name        = "lan_sg"
  description = "Allow all internal and all outbound traffic"
  vpc_id      = aws_vpc.devnet.id
}

# Create Security Group for LAN net (internal VMs)
resource "aws_security_group_rule" "lan_internal" {
  type                     = "ingress"
  description              = "Allow all traffic from LAN security group"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.lan.id
  source_security_group_id = aws_security_group.lan.id
}

# Create Security Group for WAN to LAN access
resource "aws_security_group_rule" "wan_to_lan_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.lan.id
  source_security_group_id = aws_security_group.wan.id
}