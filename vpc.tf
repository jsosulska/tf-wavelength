/* 
To use your existing VPC in the region passed to your AWS provider
configuration, comment out the module definition (L#7-L#13) and local
var (L#22) below, and uncomment anything with //.
*/

/*
module "vpc" {
  count = var.create_vpc == true ? 1 : 0
  source = "./modules/vpc"

  create_vpc        = false
  region            = var.region
  availability_zone = "us-east-1a"
}
*/

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

locals {
  // vpc_id = var.create_vpc == true ? module.vpc.vpc_id : data.aws_vpc.existing_vpc.id
  vpc_id = data.aws_vpc.existing_vpc.id
}
