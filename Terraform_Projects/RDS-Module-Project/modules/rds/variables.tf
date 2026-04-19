
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
