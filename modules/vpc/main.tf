# TODO: make multi-AZ

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "managed" {
  count = var.create_vpc == true ? 1 : 0

  cidr_block           = "15.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = var.tags
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "region_subnet" {
  count = var.create_vpc == true ? 1 : 0

  vpc_id = aws_vpc.managed[0].id

  # TODO change into variable
  cidr_block        = "15.0.1.0/24"
  availability_zone = var.availability_zone

  tags = var.tags
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "internet_gw" {
  count = var.create_vpc == true ? 1 : 0

  vpc_id = aws_vpc.managed[0].id

  # TODO change into variable
  tags = {
    Name = "Internet-Gateway"
  }
}

## Create, Set Up, Associate
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "region_route_table" {
  count = var.create_vpc == true ? 1 : 0

  vpc_id = aws_vpc.managed[0].id

  # TODO change into variable
  tags = {
    Name = "Region Route Table"
  }
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
