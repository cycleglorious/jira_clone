variable "aws_region" {
  type        = string
  default     = "eu-north-1"
}

variable "cluster_name" {
  type        = string
  default     = "my-eks-cluster"
}

variable "cluster_version" {
  type        = string
  default     = "1.32" # Вкажіть бажану версію (переконайтесь, що вона підтримується)
}

variable "vpc_id" {
  type        = string
}

variable "private_subnet_ids" {
  type        = list(string)
}

variable "app_name" {
  type        = string
  default     = "jira-clone"
}

variable "node_instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_group_min_size" {
  type        = number
  default     = 0
}

variable "node_group_max_size" {
  type        = number
  default     = 2
}

variable "node_group_desired_size" {
  type        = number
  default     = 2
}

variable "tags" {
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}