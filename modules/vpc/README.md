# Internal Module: VPC for Wavelength Zones

### Requirements

No requirements.

### Providers

| Name | Version |
|------|---------|
| aws | n/a |

### Modules

No Modules.

### Resources

| Name |
|------|
| [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) |
| [aws_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) |
| [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) |
| [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |
| [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) |
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) |

### Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| availability_zone | The availability zone(s) used by this VPC module | `string` | n/a |
| region | The AWS Region for this VPC to be launched in | `string` | n/a |
| create_vpc | Toggle to enable / disable this module creating a VPC | `bool` | `false` |
| subnet_cidr_block | The CIDR block for the Subnet | `string` | `"10.0.0.0/24"` |
| tags | Default tags for all resources created by the VPC module inside the wavelength module. | `map(any)` | <pre>{<br>  "purpose": "Wavelength",<br>  "terraformManaged": true<br>}</pre> |
| tags_internet_gw | Additional tags for the module created internet gateway | `map(any)` | <pre>{<br>  "type": "igw"<br>}</pre> |
| tags_managed_vpc | Additional tags for the module created VPC | `map(any)` | <pre>{<br>  "type": "vpc"<br>}</pre> |
| tags_region_route_table | Additional tags for the module created route table | `map(any)` | <pre>{<br>  "type": "routeTable"<br>}</pre> |
| tags_region_securitygroup | Additional tags for the module created security group | `map(any)` | <pre>{<br>  "type": "securityGroup"<br>}</pre> |
| tags_region_subnet | Additional tags for the module created subnet | `map(any)` | <pre>{<br>  "type": "awsRegionSubnet"<br>}</pre> |
| vpc_cidr_block | The CIDR block for the VPC | `string` | `"10.0.0.0/22"` |
| wlz_ingress_cidr_block | List of CIDR blocks for SSH access | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> |

### Outputs

| Name | Description |
|------|-------------|
| vpc_id | The id of the created VPC |
