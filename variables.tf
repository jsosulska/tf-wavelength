variable "region" {
  type        = string
  default     = "us-east-1"
  description = "This is the AWS region."
}

variable "create_vpc" {
  type        = bool
  default     = false
  description = "Toggle to enable / disable VPC creation"
}

variable "vpc_id" {
  type        = string
  description = "The id of the specific pre-existing VPC to retrieve."
  default     = ""
}

variable "tags" {
  type        = map(any)
  description = "AWS Tags"

  default = {
    Name = "Wavelength"
  }
}
