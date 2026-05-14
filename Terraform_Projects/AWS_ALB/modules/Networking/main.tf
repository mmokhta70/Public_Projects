#=====================================
# fetch all the az in your region 
#=====================================

locals {
     azs = data.aws_availability_zone.available.names
}

data "aws_availability_zone" "available" {
state = "available"
}