output "vpc" {
  value = data.aws_vpc.vpc
}
#
#output "vpc_subnets" {
#  value = data.aws_subnets.database
#}
#
#output "database_subnet_ids" {
#  value = data.aws_subnet.database
#}
#
#output "database_route_table_ids" {
#  value = data.aws_route_tables.database
#}
#
#output "private_route_table_ids" {
#  value = data.aws_route_tables.private
#}

output "postgres_db_endpoint" {
  value = module.rds.postgres_db_endpoint
}

output "postgres_db_address" {
  value = module.rds.postgres_db_address
}

output "postgres_db_port" {
  value = module.rds.postgres_db_port
}

output "security_groups" {
  value = data.aws_security_groups.selected
}
