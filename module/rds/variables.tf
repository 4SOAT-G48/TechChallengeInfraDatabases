variable "database" {
  type = object({
    name = string
    username = string
    password = string
  })
}

variable "storage" {
  type = object({
    type = string
    allocated = number
    encrypted = bool
    max_size = number
  })
}

variable "engine" {
  type = object({
    type = string
    version = string
  })
}

variable "instance" {
  type = object({
    class = string
    vpc_security_gs = list(string)
    multi_az = bool
  })
}

variable "configuration" {
  type = object({
    parameter_group_name = string
    subnet_group_name = string
    deletion_protection = bool
  })
}

variable "backup" {
  type = object({
    retention_period = number
    skip_final = bool
  })
}

variable "monitoring" {
  type = object({
    interval = number
  })
}
