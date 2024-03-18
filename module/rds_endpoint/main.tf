
################################################################################
# VPC Endpoints Module for RDS
################################################################################
module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id                = var.vpc_id
  create_security_group = true

  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = [var.vpc_cidr_block]
    }
  }

  endpoints = {
    rds = {
      service             = "com.amazonaws.us-east-1a.rds"
      service_type        = "Interface"
      private_dns_enabled = true
      subnet_ids          = var.database_subnets_ids
      route_table_ids     = flatten([var.database_route_table_ids, var.private_route_table_ids])
      tags                = { Name = "${var.vpc_name}-rds-ep" }
    }
  }
}

