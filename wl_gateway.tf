# Create Carrier Gateway
resource "aws_ec2_carrier_gateway" "carrier_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "tf-carrier-gw"
  }
}
