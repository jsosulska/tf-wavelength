# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "wl_subnet" {
  vpc_id = local.vpc_id

  # TODO: turn into a variable
  cidr_block = "15.0.2.0/24"

  # TODO: turn into a variable
  availability_zone = "us-east-1-wl1-atl-wlz-1"

  tags = {
    Name = "wl-atl-subnet"
  }
}
