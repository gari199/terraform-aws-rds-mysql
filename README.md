## RDS MySQL

Contains a self-developed module with strict security measures to deploy a MySQL database within ACME organization. The database will be encrtypted using a self managed KMS key for audit and compliance purposes.

The MySQL RDS modfule contains following components:
- KMS Key and key policy with right permissions and grants to encrypt the database
- MySQL DB instance with secure features