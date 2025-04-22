variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "eks_cluster_arn" {
  type        = string
  description = "ARN of the EKS cluster"
}

variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}


variable "eks_security_group_id" {
  type        = string
  description = "ID of the EKS security group"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnets"
}

variable "buildspec" {
  type        = string
  description = "Path to the buildspec file"
}


# ======== Secrets Manager ========
variable "secrets_manager_db_secret_arn" {
  description = "ARN of the Secrets Manager secret containing DB credentials."
  type        = string
  default     = null
}

variable "create_secrets_policy" {
  description = "Boolean flag to indicate if the IAM policy for reading secrets should be created."
  type        = bool
  default     = false
}

