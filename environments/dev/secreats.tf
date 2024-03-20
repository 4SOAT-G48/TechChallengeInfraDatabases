
data "aws_secretsmanager_secret_version" "db_credentials_admin" {
  secret_id = "dev/fiap-4soat-g48/database/postgres/admin"
}

locals {
  db_credentials_admin = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_admin.secret_string)
}
