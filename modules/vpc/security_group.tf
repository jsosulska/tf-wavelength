# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "managed_wlz" {
  count = var.create_vpc == true ? 1 : 0

  vpc_id = aws_vpc.managed[0].id

  tags = var.tags
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
# NOTE: this is decidedly NOT a best-practice!
resource "aws_security_group_rule" "managed_wlz_ingress" {
  count = var.create_vpc == true ? 1 : 0

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.managed_wlz[0].id
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "managed_wlz_egress" {
  count = var.create_vpc == true ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.managed_wlz[0].id
}
