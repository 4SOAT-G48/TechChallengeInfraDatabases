######################################################
# Get VPC and subnet information
######################################################
data "aws_vpc" "vpc" {
  cidr_block = local.vpc_params.vpc_cidr
}

data "aws_security_groups" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}


/*
######################################################
# Get databese subnet and route table information
######################################################
data "aws_subnets" "database" {
  filter {
    name   = "tag:Name"
    values = ["fiap-4soat-g48-tc-dev-vpc-db-us-east-1a", "fiap-4soat-g48-tc-dev-vpc-db-us-east-1b"]
  }
}
data "aws_subnet" "database" {
  for_each = toset(data.aws_subnets.database.ids)
  id       = each.value
}

data "aws_route_tables" "database" {
  filter {
    name   = "tag:Name"
    values = ["fiap-4soat-g48-tc-dev-vpc-database-us-east-1a", "fiap-4soat-g48-tc-dev-vpc-database-us-east-1b"]
  }
}

######################################################
# Get databese subnet and route table information
######################################################
data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["fiap-4soat-g48-tc-dev-vpc-private-us-east-1a", "fiap-4soat-g48-tc-dev-vpc-private-us-east-1b"]
  }
}
data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

data "aws_route_tables" "private" {
  filter {
    name   = "tag:Name"
    values = ["fiap-4soat-g48-tc-dev-vpc-private-us-east-1a", "fiap-4soat-g48-tc-dev-vpc-private-us-east-1b"]
  }
}
*/

######################################################
# chama o modulo rds passando os parametro com os valores das variaveis
######################################################
module "rds" {
  source = "../../module/rds"

  database = {
    name     = local.rds_config.database.name
    username = local.rds_config.database.username
    password = local.rds_config.database.password
  }

  storage = {
    type      = local.rds_config.storage.type
    allocated = local.rds_config.storage.allocated
    encrypted = local.rds_config.storage.encrypted
    max_size  = local.rds_config.storage.max_allocated_storage
  }

  engine = {
    type    = local.rds_config.engine.type
    version = local.rds_config.engine.version
  }

  instance = {
    class           = local.rds_config.instance.class
    vpc_security_gs = data.aws_security_groups.selected.ids #local.rds_config.instance.vpc_security_group_ids
    multi_az        = local.rds_config.instance.multi_az
  }

  configuration = {
    parameter_group_name = local.rds_config.configuration.parameter_group_name
    subnet_group_name    = local.rds_config.configuration.subnet_group_name
    deletion_protection  = local.rds_config.configuration.deletion_protection
  }

  backup = {
    retention_period = local.rds_config.backup.retention_period
    skip_final       = local.rds_config.backup.skip_final_snapshot
  }

  monitoring = {
    interval = local.rds_config.monitoring.interval
  }
}

/*
module "endpoint" {
  source = "../../module/rds_endpoint"

  database_subnets_ids     = data.aws_subnets.database.ids
  database_route_table_ids = data.aws_route_tables.private.ids
  private_route_table_ids  = data.aws_route_tables.private.ids
  region_and_az            = var.region
  vpc_cidr_block           = local.vpc_params.vpc_cidr
  vpc_id                   = data.aws_vpc.vpc.id
  vpc_name                 = data.aws_vpc.vpc.tags.Name
}
*/