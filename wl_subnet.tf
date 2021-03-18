# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "wl_subnet" {
  # TODO: turn into a variable
  availability_zone = "us-east-1-wl1-atl-wlz-1"

  cidr_block = var.wlz_cidr_block
  vpc_id     = local.vpc_id

  tags = local.tags_wlz_subnet
}
