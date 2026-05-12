variable "vpc_id" {
  type = string
}

variable "gateway_id" {
  type = string
}

variable "subnet_id" {
  description = "Subnet to associate with this route table"
  type        = string
}
