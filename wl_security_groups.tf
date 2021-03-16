# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "wlz_ingress_securitygroup" {
  vpc_id = local.vpc_id

  tags = local.tags_wlz_securitygroup
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
# NOTE: this is decidedly NOT a best-practice!
resource "aws_security_group_rule" "wavelength_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.wlz_ingress_securitygroup.id
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "wavelength_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.wlz_ingress_securitygroup.id
}
