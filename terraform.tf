terraform {
  required_version = ">= 0.13.6"

  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/aws/latest
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.32.0"
    }
  }
}
