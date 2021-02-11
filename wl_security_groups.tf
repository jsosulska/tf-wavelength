# These are not best practice, this is a demo.
resource "aws_security_group" "wl_security_group" {
  vpc_id      = aws_vpc.vpc.id
  name        = "tf WLZ Security Group"
  description = "Security group for Wavelength zone created by Terraform"

  ingress {
    security_groups = [aws_security_group.tf_security_group.id]
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Terraform Wavelength Zone Security Group"
  }

}
