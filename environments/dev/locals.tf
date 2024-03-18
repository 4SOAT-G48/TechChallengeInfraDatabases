locals {
  #configuração do ambiente
  environment  = "dev"
  owners       = "fiap-4soat-g48"
  project_name = "fiap-4soat-g48-tc"
  component    = "devops"
  env_name     = "${local.project_name}-${local.environment}"
  vpc_name     = "${local.project_name}-${local.environment}-vpc"

  aws_default_tags = {
    owners      = local.owners
    component   = local.component
    created-by  = "terraform"
    environment = local.environment
  }
  vpc_params = {
    vpc_cidr = "10.1.0.0/16"
  }

  rds_config = {
    database = {
      name     = "${local.env_name}-db"
      username = local.db_credentials_admin["username"]
      password = local.db_credentials_admin["password"]
      port     = 5432
    }

    storage = {
      type                  = "gp3"
      allocated             = 20
      encrypted             = true
      max_allocated_storage = 40
    }

    engine = {
      type    = "postgres"
      version = "16.1"
    }

    instance = {
      class    = "db.t3.micro"
      multi_az = false
    }

    configuration = {
      parameter_group_name = "default.postgres16"
      subnet_group_name    = "${local.vpc_name}-db-subnet-group"
      deletion_protection  = false
    }

    backup = {
      skip_final_snapshot = true
      retention_period    = 7
    }

    monitoring = {
      interval = 60
    }
  }
}