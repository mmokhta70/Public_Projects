locals {
  common_tags = {
    owner     = "Mehrdad.Mokhtari1370@gmail.com"
    manged_by = "Terraform"
  }
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "rds_sg_id" {
  type = list(string)
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "storage_size" {
  type    = number
  default = 10
  validation {
    condition     = var.storage_size >= 5 && var.storage_size <= 20
    error_message = "the storage size should be between 5GB to 20GB"
  }
}

variable "engine" {
  type    = string
  default = "postgres-latest"
  validation {
    condition     = contains(["postgres-latest", "postgres-14"])
    error_message = "Db engine must be postgres-latest or  postgres-14"
  }

}

variable "credential" {
  type = object({
    username = string
    password = string
  })
  sensitive = true
  validation {
    condition = (
      length(regexall("[a-zA-Z]+", var.credential.password)) > 0
      && length(regexall("[0-9]+", var.credential.password)) > 0
      && length(regexall("^[a-zA-Z0-9!@£$%^&*()+-_]{8,}$", var.credential.password)) > 0
    )
    error_message = <<-EOT
                 Password must follow the below format:
                 1. Conatins at least 1 character,
                 2. Conatins at least 1 digit,
                 3. Be at least 8 characters long
                 EOT
  }

}
