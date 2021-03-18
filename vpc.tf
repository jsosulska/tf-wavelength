data "aws_availability_zones" "wlz" {
  filter {
    name   = "group-name"
    values = [var.region]
  }
}

module "vpc_wlz" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  create_vpc      = var.create_vpc
  name            = "vpc_wlz"
  cidr            = "10.1.0.0/16"
  azs             = data.aws_availability_zones.wlz.names
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

  enable_nat_gateway   = true
  enable_dns_hostnames = true

  tags = var.tags_wavelength
}

/*
You can remove the above section from this module if you are launching VPCs through other modules. If the above module is used, the CIDR created by the module above is used to filter the data below.
*/

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
data "aws_vpc" "existing_vpc" {
  filter {
    name   = "cidr"
    values = ["10.1.0.0/16"]
  }
}

locals {
  // vpc_id = var.create_vpc == true ? module.vpc.vpc_id : data.aws_vpc.existing_vpc.id
  vpc_id = data.aws_vpc.existing_vpc.id
}
