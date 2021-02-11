# These are not best practice, this is a demo.
resource "aws_security_group" "security_group" {
    vpc_id          = aws_vpc.vpc.id
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
