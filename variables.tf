variable "create_vpc" {
  type        = bool
  default     = false
  description = "Toggle to enable / disable VPC creation"
}

variable "tags" {
  type        = map(any)
  description = "AWS Tags"

  default = {
    Name = "Wavelength"
  }
}
