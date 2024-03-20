
resource "aws_db_instance" "postgres_db" {

  identifier = var.database.name

  availability_zone = "us-east-1a"

  engine = var.engine.type
  engine_version = var.engine.version

  storage_type = var.storage.type
  allocated_storage = var.storage.allocated
  storage_encrypted = var.storage.encrypted

  instance_class = var.instance.class

  username = var.database.username
  password = var.database.password

  parameter_group_name = var.configuration.parameter_group_name
  db_subnet_group_name = var.configuration.subnet_group_name
  vpc_security_group_ids = var.instance.vpc_security_gs

  publicly_accessible = false

  deletion_protection = var.configuration.deletion_protection

  enabled_cloudwatch_logs_exports = ["postgresql"]

  backup_window = "00:00-01:00"

  skip_final_snapshot = true

  tags = {
    Name = "postgres_db"
  }
}

