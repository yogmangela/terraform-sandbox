variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "security_group" {
  description = "Security Group ID"
  type = string
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
}