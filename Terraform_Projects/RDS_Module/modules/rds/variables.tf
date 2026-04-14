
#---------------------------
# database identity
#---------------------------

variable "identifier" {
  type = string
  validation {
    condition     = length(var.identifier) > 3
    error_message = "identifier must be larger than 3 charachters"
  }
}

variable "engine_version" {
  type    = string
  default = "14.11"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "storage_size" {
  type    = number
  default = 15
}

variable "db_name" {
  type = string
}

#---------------------------
# networking config
#---------------------------

variable "private_subnet_ids" {
  type = list(string)
}

variable "rds_security_group_id" {
  type = list(string)
}

#---------------------------
# credential config
#---------------------------
variable "credential" {
  type = object({
    username = string
    password = string
  })
  sensitive = true
}
