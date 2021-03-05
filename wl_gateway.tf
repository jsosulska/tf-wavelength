# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_carrier_gateway
resource "aws_ec2_carrier_gateway" "wavelength" {
  vpc_id = local.vpc_id

  tags = var.tags
}
