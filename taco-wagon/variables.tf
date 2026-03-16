# Variables for Globomantics web application infrastructure

variable "company_name" {
  type        = string
  description = "Company name for resource naming"
  
  # Module 1: Alphanumeric, 3-20 characters
  validation {
    condition = length(var.company_name>=3) && length(var.company_name20)<=20
    error_message = "Invalid string for company name. must be betwwen 3 and 20 characters long"
  }
  validation {
    condition = !can(regex("[^a-zA-Z09-9]",var.company_name))
    error_message = "Todos los caracteres deben ser alfanumericos"
  }
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
  
  # Module 1: Add validation to allow only dev, staging, or prod
  validation {
    condition     = contains(local.allowed_env, var.environment)
    error_message = "The environment must be one of the following: ${join(", ", local.allowed_env)}."
  }
}

variable "aws_region" {
  type        = string
  description = "AWS region for resource deployment"
  default     = "us-east-1"
  
  # Module 1: Add validation to ensure US regions only
  validation {
    condition = startswith("us-")
    error_message = "Solo se admiten US regions"
  }
}

variable "availability_zones" {
  type        = number
  description = "Number of availability zones to use"
  
  # Module 1: Add validation to ensure at least 2 AZs are provided
  validation {
    condition = var.availability_zones>=2
    error_message = "Debe haber al menos 2 zonas de disponibilidad"
  }
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the web server"
  default     = "t3.micro"
  
  # Module 1: Add validation for approved instance types (t3.micro, t3.small, t3.medium)
  validation {
    condition = contains(local.allowed_instace_type, var.instance_type)
        error_message = "Las intancias deben ser must be one of the following: ${join(", ", local.allowed_instace_type)}."

  }
}
