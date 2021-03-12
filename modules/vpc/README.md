# Internal Module: VPC for Wavelength Zones

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
| availability_zone | TODO | `string` | n/a |
| region | This is the AWS region. | `string` | n/a |
| create_vpc | Toggle to enable / disable VPC creation | `bool` | `false` |
| subnet_cidr_block | The CIDR block for the Subnet | `string` | `"10.0.1.0/24"` |
| tags | TODO | `map(any)` | <pre>{<br>  "purpose": "Wavelength",<br>  "terraformManaged": true<br>}</pre> |
| tags_internet_gw | TODO | `map(any)` | <pre>{<br>  "type": "igw"<br>}</pre> |
| tags_managed_vpc | TODO | `map(any)` | <pre>{<br>  "type": "vpc"<br>}</pre> |
| tags_region_route_table | TODO | `map(any)` | <pre>{<br>  "type": "Region Route Table"<br>}</pre> |
| tags_region_subnet | TODO | `map(any)` | <pre>{<br>  "type": "subnet"<br>}</pre> |
| tags_securitygroup_wlz | TODO | `map(any)` | <pre>{<br>  "type": "Security Group"<br>}</pre> |
| vpc_cidr_block | The CIDR block for the VPC | `string` | `"10.0.0.0/22"` |
| wlz_ingress_cidr_block | List of CIDR blocks for SSH access | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> |

### Outputs

| Name | Description |
|------|-------------|
| vpc_id | TODO |
