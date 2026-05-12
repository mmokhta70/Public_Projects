variable "cidr_block" {
  type = string
  validation {
    condition = can(regex(
      "^(10\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}|172\\.(1[6-9]|2[0-9]|3[01])\\.\\d{1,3}\\.\\d{1,3}|192\\.168\\.\\d{1,3}\\.\\d{1,3})/(8|9|1[0-9]|2[0-8])$",
      var.vpc_cidr
    ))
    error_message = "vpc_cidr must be a valid RFC 1918 private CIDR (10.x.x.x, 172.16-31.x.x, or 192.168.x.x) with a prefix length between /8 and /28."
  }
}
