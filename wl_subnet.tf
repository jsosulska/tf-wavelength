# create the WL subnet
resource "aws_subnet" "wl_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "15.0.2.0/24"
  availability_zone = "us-east-1-wl1-atl-wlz-1"
  tags = {
    Name = "wl-atl-subnet"
  }
}
