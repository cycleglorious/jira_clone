locals {
  tags = {
    app = "jira-clone"
  }
}

variable "vault_token" {
  type = string
  description = "value of vault token"
  sensitive = true
}

variable "region" {
  type = string
  default = "eu-north-1"
  description = "Region"
}

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

variable "availability_zones" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-north-1a", "eu-north-1b"]
}

variable "db_instance_type" {
  type = string
  description = "DB Instance type"
  default = "db.t4g.micro"
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

variable "upstash_token" {
  type        = string
  description = "Upstash token"
  sensitive = true
  default     = ""
}

variable "upstash_url" {
  type = string
  description = "Upstash URL"
  default = "http://serverless-redis-http"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t2.micro"
}

variable "instance_ami" {
  type = string
  description = "Instance AMI"
  default = "ami-0274f4b62b6ae3bd5"
}