# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
//data "aws_vpc" "existing_vpc" {
//  id = var.vpc_id
//}

module "vpc" {
  source = "./modules/vpc"

  create_vpc        = false
  region            = var.region
  availability_zone = "us-east-1a"

  tags = var.tags
}

locals {
//  vpc_id = var.create_vpc == true ? module.vpc.vpc_id : data.aws_vpc.existing_vpc.id
  vpc_id = module.vpc.vpc_id
}
