# wavelength-tf-demo

A repo to manage wavelength zones in terraform.
## Requirements

- You will need to request access to the Wavelength service through AWS. This process can take several days.

- When adding Wavelength zones, be sure to use the following filter in your future Terraform for Availability zones

```
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
```

## Module

```
module "wavelength_zone" {
  source = "./modules/vpc"
  create_vpc = false
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
