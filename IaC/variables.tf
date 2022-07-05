###################
# AWS Config
###################
variable "aws_region" {
  default     = "us-east-1"
  description = "aws region where our resources going to create choose"
}

variable "aws_access_key" {
  type = string
  description = "aws_access_key"
}

variable "aws_secret_key" {
  type = string
  description = "aws_secret_key"
}

###################
# Project Config
###################

variable "project_name" {
  description = "Project Name"
  default     = "DemoA"
}

variable "key_name" {
  description = "EC2 SSH Key name"
  default     = "user1"
}

variable "app_port" {
  description = "App port"
  default     = 80
}