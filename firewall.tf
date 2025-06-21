# Create Security Group for access from WAN net
resource "aws_security_group" "wan" {
  name        = "wan_sg"
  description = "Allow ssh inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.devnet.id
}

# Allow only inbound ssh traffic from WAN
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.wan.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

# Create Security Group for LAN net (internal VMs)
resource "aws_security_group" "lan" {
  name        = "lan_sg"
  description = "Allow all internal inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.devnet.id
}

# Allow all traffic in LAN
resource "aws_vpc_security_group_ingress_rule" "lan_to_lan" {
  security_group_id        = aws_security_group.lan.id
  ip_protocol              = "-1"
  source_security_group_id = aws_security_group.lan.id
}

# Allow ssh traffic in LAN from jump host
resource "aws_vpc_security_group_ingress_rule" "wan_to_lan" {
  security_group_id        = aws_security_group.lan.id
  ip_protocol              = "tcp"
  from_port                = 22
  to_port                  = 22
  source_security_group_id = aws_security_group.wan.id
}