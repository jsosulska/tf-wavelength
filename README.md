# wavelength-tf-demo

A repo to manage wavelength zones in terraform.
## Requirements

- You will need to request access to the Wavelength service through AWS. This process can take several days.
- When adding Wavelength zones, be sure to use the following filter in your future Terraform for Availability zones

```hcl
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
```

- Currently there a blocking issues that stop wavelength from being deployed completely with Terraform.
  - [Provider-Top Level](https://github.com/hashicorp/terraform-provider-aws/issues/14518)
  - [r/aws_route: AWS Wavelength support #16961](https://github.com/hashicorp/terraform-provider-aws/pull/16961)
    - [r/aws_route: 'destination_prefix_list_id' attribute can be specified for managed prefix list destinations #17291](https://github.com/hashicorp/terraform-provider-aws/pull/17291)
    - [d/aws_route: 'destination_prefix_list_id' attribute set for managed prefix list destinations #17295)](https://github.com/hashicorp/terraform-provider-aws/pull/17295)
  - [d/aws_route: AWS Wavelength support #16963](https://github.com/hashicorp/terraform-provider-aws/pull/16963)
  - [r/aws_route_table: AWS Wavelength support #16979](https://github.com/hashicorp/terraform-provider-aws/pull/16979)
    - [r/aws_(default)_route_table: 'destination_prefix_list_id' attribute can be specified for managed prefix list destinations #17319)](https://github.com/hashicorp/terraform-provider-aws/pull/17319)
  - [d/aws_route_table: AWS Wavelength support #17001](https://github.com/hashicorp/terraform-provider-aws/pull/17001)
    - [d/aws_route_table: 'destination_prefix_list_id' attribute set for managed prefix list destinations #17347](https://github.com/hashicorp/terraform-provider-aws/pull/17347)
 Open)

- The following [lab](https://www.eventbox.dev/published/lesson/wavelength-v2/prerequisites.html) covers the intent of the MVP. We want to achieve:
  - One Region with Multiple local and wavelength availability zones.
  - Needed supporting VPC infrastructure (optional)
  - AKS cluster with
    - control plane in local az
    - worker nodes across local and wavelength az
  - Consul

## Warnings

- wl_routetables.tf is commented out until the issues above are fixed.

## Module

```
module "wavelength_zone" {
  source            = "./modules/vpc"
  create_vpc        = false
  availability_zone = "us-east-1a"
}
```

## Required inputs

```
Required inputs
```

## Outputs

```
Required outputs
```
