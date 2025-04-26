variable "region" {
  default = "eu-west-2"
}

variable "cluster_name" {
  default = "inspect-ai"
}

variable "vpc_id" {
  description = "VPC where EKS should be deployed"
  type        = string
  default     = "vpc-0478057a47c219bbf"
}

variable "subnet_ids" {
  description = "List of subnet IDs (private preferred)"
  type        = list(string)
  default     = ["subnet-091c14b9d8b91ead1", "subnet-091c14b9d8b91ead1"]
}