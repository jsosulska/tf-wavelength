# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "region_ingress" {
  count = var.create_vpc == true ? 1 : 0

  vpc_id = aws_vpc.managed[0].id

  tags = local.tags_region_securitygroup
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "managed_wlz_ingress" {
  count = var.create_vpc == true ? 1 : 0

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.wlz_ingress_cidr_block
  security_group_id = aws_security_group.region_ingress[0].id
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "managed_wlz_egress" {
  count = var.create_vpc == true ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.region_ingress[0].id
}
