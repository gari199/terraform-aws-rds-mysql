provider "aws" {
  region = "eu-central-1"
}

module "rds" {
  source                 = "/../"
  account_id             = "637423344778"
  allocated_storage      = "20"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "mysql_database"
  username               = "admin"
  parameter_group_name   = "default.mysql8.0"
  vpc_security_group_ids = ["sg-0c226fddab0a2860c"]
  kms_key_alias          = "mysql-key"
}