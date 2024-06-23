output "db_instance_id" {
  description = "RDS instance ID."
  value       = aws_db_instance.mysql.id
}

output "db_instance_endpoint" {
  description = "Endpoint address of the RDS instance."
  value       = aws_db_instance.mysql.endpoint
}

output "db_instance_arn" {
  description = "ARN of the RDS instance."
  value       = aws_db_instance.mysql.arn
}

output "db_instance_address" {
  description = "Address of the RDS instance."
  value       = aws_db_instance.mysql.address
}

output "kms_key_id" {
  description = "ID of the KMS key."
  value       = aws_kms_key.myqsl_kms_key.id
}

output "kms_key_arn" {
  description = "ARN of the KMS key."
  value       = aws_kms_key.myqsl_kms_key.arn
}