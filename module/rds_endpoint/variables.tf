
variable "region_and_az" {
  type    = string
}

variable "vpc_id" {
  type    = string
}

variable "vpc_name" {
  type    = string
}

variable "vpc_cidr_block" {
  type    = string
}

variable "database_subnets_ids" {
  type    = list(string)
}

variable "database_route_table_ids" {
  type    = list(string)
}

variable "private_route_table_ids" {
  type    = list(string)
}