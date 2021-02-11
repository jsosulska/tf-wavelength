variable "create_vpc" {
  type        = bool
  default     = false
  description = "Toggle to enable / disable VPC creation"
}

# Todo: Make Multi-az
# Needs for_each
variable "availability_zone" {
  type        = list(string)
  description = "Toggle to enable / disable VPC creation"
}

# create the vpc
resource "aws_vpc" "vpc" {
    count = var.create_vpc == true ? 1 : 0
    cidr_block              = "15.0.0.0/16"
    instance_tenancy        = "default"
    enable_dns_support      = true
    enable_dns_hostnames    = true
    tags = {
        Name = "tf-vpc"
    }
}

# create the Region subnet
resource "aws_subnet" "region_subnet" {
    count = var.create_vpc == true ? 1 : 0
    vpc_id              = aws_vpc.vpc.id
    cidr_block          = "15.0.1.0/24"
    availability_zone   = var.availability_zone
    tags = {
        Name = "tf-subnet"
    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "internet_gw" {
    count = var.create_vpc == true ? 1 : 0
    vpc_id              = aws_vpc.vpc.id
    tags = {
        Name = "Internet-Gateway"
    }
}

## Create, Set Up, Associate
# Create the Route Table for Region
resource "aws_route_table" "region_route_table" {
    count = var.create_vpc == true ? 1 : 0
    vpc_id              = aws_vpc.vpc.id
    tags = {
        Name = "Region Route Table"
    }
}

# Setup Region Route Table
resource "aws_route" "region_route" {
    count = var.create_vpc == true ? 1 : 0
    route_table_id          = aws_route_table.region_route_table.id
    destination_cidr_block  = "0.0.0.0/0"
    gateway_id              = aws_internet_gateway.internet_gw.id
}

# Associate Route Table with subnet
resource "aws_route_table_association" "region_route_association" {
    count = var.create_vpc == true ? 1 : 0
    subnet_id           = aws_subnet.region_subnet.id
    route_table_id      = aws_route_table.region_route_table.id
}