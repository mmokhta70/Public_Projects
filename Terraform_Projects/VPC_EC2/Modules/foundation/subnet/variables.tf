variable "vpc_id" {
  description = "the vpc we want use to create a subnet form it "
  type        = string
}

variable "cidr_block" {
  description = "This is block of ip addrss for subnet we need"
  type        = string
}

variable "availability_zone" {
  description = "define an availability zone here"
  type        = string
}


variable "subnet_name" {
  description = "we use this for Name in tags"
  type        = string
}
