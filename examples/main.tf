provider "aws" {
  region = "eu-central-1"
}

module "rds" {
  source                 = "../"
  account_id             = var.account_id
  allocated_storage      = var.allocated_storage
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.username
  parameter_group_name   = var.parameter_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  kms_key_alias          = var.kms_key_alias
}