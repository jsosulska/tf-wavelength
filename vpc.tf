# vpc.tf 

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.21.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


# create the vpc
resource "aws_vpc" "tf-vpc" {
    cidr_block              = "15.0.0.0/16"
    instance_tenancy        = "default"
    enable_dns_support      = true
    enable_dns_hostnames    = true
    tags = {
        Name = "tf-vpc"
    }
}

# create the Region subnet

resource "aws_subnet" "tf_region_subnet" {
    vpc_id              = aws_vpc.tf-vpc.id
    cidr_block          = "15.0.1.0/24"
    availability_zone    = "us-east-1a"
    tags = {
        Name = "tf-subnet"
    }
}

# create the WL subnet

resource "aws_subnet" "tf_wl_subnet" {
    vpc_id              = aws_vpc.tf-vpc.id
    cidr_block          = "15.0.2.0/24"
    availability_zone    = "us-east-1-wl1-atl-wlz-1"
    tags = {
        Name = "tf-wl-atl-subnet"
    }
}

resource "aws_security_group" "tf_security_group" {
    vpc_id          = aws_vpc.tf-vpc.id
    name            = "tf Security Group"
    description     = "Security group for bastion created by Terraform"

    ingress {
        cidr_blocks     = ["0.0.0.0/0"]
        protocol        = "tcp"
        from_port       = 22
        to_port         = 22
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    tags = {
        Name = "Terraform Security Group"
    }

}

resource "aws_security_group" "tf_wl_security_group" {
    vpc_id          = aws_vpc.tf-vpc.id
    name            = "tf WLZ Security Group"
    description     = "Security group for Wavelength zone created by Terraform"

    ingress {
        security_groups     = [aws_security_group.tf_security_group.id]
        protocol        = "tcp"
        from_port       = 22
        to_port         = 22
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    tags = {
        Name = "Terraform Wavelength Zone Security Group"
    }

}


# Create Internet Gateway
resource "aws_internet_gateway" "tf_internet_gw" {
    vpc_id              = aws_vpc.tf-vpc.id
    tags = {
        Name = "tf Internet Gateway"
    }
}

# Create Carrier Gateway
resource "aws_ec2_carrier_gateway" "tf_carrier_gateway" {
    vpc_id              = aws_vpc.tf-vpc.id
    tags = {
        Name = "tf-carrier-gw"
    }
}

# Create the Route Table for Region
resource "aws_route_table" "region_route_table" {
    vpc_id              = aws_vpc.tf-vpc.id
    tags = {
        Name = "Region Route Table"
    }
}

# Create the Route Table for Wavelength Zone
resource "aws_route_table" "WLZ_route_table" {
    vpc_id              = aws_vpc.tf-vpc.id
    tags = {
        Name = "Wavelength Zone Route Table"
    }
}

# Setup Region Route Table
resource "aws_route" "region_route" {
    route_table_id          = aws_route_table.region_route_table.id
    destination_cidr_block  = "0.0.0.0/0"
    gateway_id              = aws_internet_gateway.tf_internet_gw.id
}

# Associate Route Table with subnet
resource "aws_route_table_association" "region_route_association" {
    subnet_id           = aws_subnet.tf_region_subnet.id
    route_table_id      = aws_route_table.region_route_table.id
}

# Setup WLZ Route Table
resource "aws_route" "WLZ_route" {
    route_table_id          = aws_route_table.WLZ_route_table.id
    destination_cidr_block  = "0.0.0.0/0"
    gateway_id              = aws_ec2_carrier_gateway.tf_carrier_gateway.id
}

# Associate Route Table with subnet for WLZ
#resource "aws_route_table_association" "WLZ_route_association" {
#    subnet_id           = aws_subnet.tf_wl_subnet.id
#    route_table_id      = aws_route_table.WLZ_route_table.id
#}
