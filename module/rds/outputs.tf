
output "postgres_db_endpoint" {
  value = aws_db_instance.postgres_db.endpoint
}

output "postgres_db_address" {
  value = aws_db_instance.postgres_db.address
}

output "postgres_db_port" {
  value = aws_db_instance.postgres_db.port
}

output "postgres_db_username" {
  value = aws_db_instance.postgres_db.username
}

output "postgres_db_name" {
  value = aws_db_instance.postgres_db.db_name
}
