# create a Route Table for the Wavelength Zone (WLZ)
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "wavelength_zone" {
  vpc_id = local.vpc_id

  tags = var.tags
}

# set up Wavelength Zone Route
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
resource "aws_route" "wavelength_zone" {
  route_table_id         = aws_route_table.wavelength_zone.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_ec2_carrier_gateway.wavelength.id
}

# associate Route Table with Subnet for WLZ
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "wavelength" {
  subnet_id      = aws_subnet.wl_subnet.id
  route_table_id = aws_route_table.wavelength_zone.id
}
