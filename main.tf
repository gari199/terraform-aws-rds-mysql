# Create a KMS key
resource "aws_kms_key" "myqsl_kms_key" {
  description             = "KMS key for RDS encryption"
  enable_key_rotation     = true
  rotation_period_in_days = 100

  tags = {
    Name = "MySQL KMS Key"
  }
}

# Create a KMS key alias
resource "aws_kms_alias" "myqsl_kms_alias" {
  name          = "alias/${var.kms_key_alias}"
  target_key_id = aws_kms_key.myqsl_kms_key.id
  }

# Define the key policy
resource "aws_kms_key_policy" "myqsl_kms_policy" {
  key_id = aws_kms_key.myqsl_kms_key.id
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
      {
        "Sid": "Enable IAM User Permissions",
        "Effect": "Allow",
        "Principal": {
          "AWS": "*"
        },
        "Action": "kms:*",
        "Resource": "*"
      },
      {
        "Sid": "Allow access for Key Administrators",
        "Effect": "Allow",
        "Principal": {
          "AWS": [
            "arn:aws:iam::${var.account_id}:root"
          ]
        },
        "Action": [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion"
        ],
        "Resource": "*"
      },
      {
        "Sid": "Allow use of the key",
        "Effect": "Allow",
        "Principal": {
          "AWS": [
            "arn:aws:iam::${var.account_id}:user/admin"
          ]
        },
        "Action": [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource": "*"
      },
      {
        "Sid": "Allow attachment of persistent resources",
        "Effect": "Allow",
        "Principal": {
          "AWS": [
            "arn:aws:iam::${var.account_id}:user/admin"
          ]
        },
        "Action": [
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
        ],
        "Resource": "*",
        "Condition": {
          "Bool": {
            "kms:GrantIsForAWSResource": "true"
          }
        }
      }
    ]
  }
  EOF
}

#Create Database
resource "aws_db_instance" "mysql" {
  allocated_storage           = var.allocated_storage
  engine                      = "mysql"
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  db_name                     = var.db_name
  username                    = var.username
  manage_master_user_password = true
  parameter_group_name        = var.parameter_group_name
  skip_final_snapshot         = false
  final_snapshot_identifier   = "final-snapshot-${var.db_name}"
  publicly_accessible         = false

  # Encryption settings
  storage_encrypted = true
  kms_key_id        = aws_kms_key.myqsl_kms_key.arn

  # Security groups
  vpc_security_group_ids = var.vpc_security_group_ids

  # Backup settings
  backup_retention_period = 7
  backup_window           = "07:00-09:00"

  # Maintenance settings
  maintenance_window = "Mon:00:00-Mon:03:00"

  tags = {
    Name = "MySQL Database"
  }
}
