locals {
  tags = {
    app = "jira-clone"
  }
  app_name = "jira-clone"
}

variable "vault_token" {
  type        = string
  description = "Value of vault token"
  sensitive   = true
}

variable "region" {
  type        = string
  default     = "eu-north-1"
  description = "Region"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-north-1a", "eu-north-1b"]
}


# ===== VPC =====
variable "cidr_vpc" {
  type        = string
  description = "VPC CIRD value"
  default     = "10.0.0.0/16"
}

variable "cidr_public_subnets" {
  type        = list(string)
  description = "Pyblic Subnet CIRD values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "cidr_private_subnets" {
  type        = list(string)
  description = "Private Subnet CIRD values"
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

# ===== RDS =====
variable "db_instance_type" {
  type        = string
  description = "DB Instance type"
  default     = "db.t4g.micro"
}

variable "db_family" {
  type        = string
  description = "DB Family"
  default     = "postgres15"
}


variable "db_name" {
  type        = string
  description = "DB Name"
  default     = "jiraClone"
}

variable "db_port" {
  type        = number
  description = "DB Port"
  default     = 5432
}

variable "db_engine_version" {
  type = string
  description = "DB Engine version"
  default = "15.12"
}

# ===== App =====
variable "upstash_url" {
  type        = string
  description = "Upstash URL"
  default     = "http://serverless-redis-http"
}

variable "run_migrations" {
  type = bool
  description = "Run migrations"
  default = false
}

variable "run_seed" {
  type = bool
  description = "Run seeds"
  default = false
}

# ===== EKS =====
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "jira-clone-eks"
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.32"
}