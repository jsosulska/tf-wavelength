# TODO: make multi-AZ

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "managed" {
  count = var.create_vpc == true ? 1 : 0

  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = local.tags_managed_vpc
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "region_subnet" {
  count = var.create_vpc == true ? 1 : 0

  vpc_id            = aws_vpc.managed[0].id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone

  tags = local.tags_region_subnet
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "internet_gw" {
  count = var.create_vpc == true ? 1 : 0

  vpc_id = aws_vpc.managed[0].id

  tags = local.tags_internet_gw
}

## Create, Set Up, Associate
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "region_route_table" {
  count = var.create_vpc == true ? 1 : 0

  vpc_id = aws_vpc.managed[0].id

  tags = local.tags_region_route_table
}

# Setup Region Route Table
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
resource "aws_route" "region_route" {
  count = var.create_vpc == true ? 1 : 0

  route_table_id         = aws_route_table.region_route_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gw[0].id
}

# Associate Route Table with subnet
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "region_route_association" {
  count = var.create_vpc == true ? 1 : 0

  subnet_id      = aws_subnet.region_subnet[0].id
  route_table_id = aws_route_table.region_route_table[0].id
}
