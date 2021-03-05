variable "create_vpc" {
  type        = bool
  default     = false
  description = "Toggle to enable / disable VPC creation"
}

variable "tags" {
  default     = map(any)
  description = "AWS Tags"

  default {
    Name = "Wavelength"
  }
}
