variable "allocated_storage" {
  description = "Allocated storage in gigabytes."
  type        = number
}

variable "engine_version" {
  description = "Version of the database engine."
  type        = string
}

variable "instance_class" {
  description = "Instance type of the RDS instance."
  type        = string
}

variable "db_name" {
  description = "Name of the database to create."
  type        = string
}

variable "username" {
  description = "Master username for the database."
  type        = string
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate with this instance."
  type        = string
  default     = "default.mysql8.0"
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate."
  type        = list(string)
}

variable "kms_key_alias" {
  description = "Alias for the KMS key."
  type        = string
}

variable "account_id" {
  description = "AWS account ID where the KMS key is created."
  type        = string
}
