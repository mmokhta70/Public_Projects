
variable "identifier" {
  type = string
}
variable "engine_version" {
  type    = number
  default = 14
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "storage_size" {
  type    = number
  default = 10
}
variable "db_name" {
  type = string
}

variable "credential" {
  type = list(object({
    username = string
    password = string
  }))
  sensitive = true
}
