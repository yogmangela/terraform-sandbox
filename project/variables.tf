variable "region" {
  description = "AWS region to deploy resources"
  default     = "eu-west-2"
}

variable "repository_name" {
  description = "Name of the CodeCommit repository"
}

variable "branch_name" {
  description = "Branch name for the CodeCommit repository"
  default     = "main"
}
