# wavelength-tf-demo

A repo to manage AWS Wavelength Zones in Terraform. This module has an
intentionally small scope, but comes with several features. The following
[lab](https://www.eventbox.dev/published/lesson/wavelength-v2/prerequisites.html)
covers the intent of the MVP.
We want to achieve:

- [x] One Region with Multiple region-based AZ's and a wavelength availability zone.
- [x] Needed supporting VPC infrastructure
- EKS cluster with
  - control plane in local az
  - worker nodes across local and wavelength az
- Consul

## Requirements

- Request access to Wavelength through the AWS Console. This process can take several days.
  - Currently, only available in the [following regions](https://aws.amazon.com/wavelength/features/)
- When adding Wavelength zones, be sure to use the following filter in your future Terraform for standard Availability zones for a given region.

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

## Warnings

- [wl_route_tables.tf](wl_route_tables.tf) is commented out until the issues above are fixed. You will need to create these manual via scripts or the console.

## Module

```hcl
module "terraform-aws-wavelength-zone" {
  source     = "github.com/jsosulska/tf-wavelength"
  create_vpc = false
}
```

## Required inputs

```hcl
None
```
