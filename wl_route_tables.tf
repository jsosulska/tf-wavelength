## Create, Set Up, Associate
# Create the Route Table for Wavelength Zone
resource "aws_route_table" "WLZ_route_table" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "Wavelength Zone Route Table"
  }
}

# Setup WLZ Route Table
resource "aws_route" "WLZ_route" {
  route_table_id         = aws_route_table.WLZ_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_ec2_carrier_gateway.carrier_gateway.id
}

# Associate Route Table with subnet for WLZ
#resource "aws_route_table_association" "WLZ_route_association" {
#    subnet_id           = aws_subnet.wl_subnet.id
#    route_table_id      = aws_route_table.WLZ_route_table.id
#}