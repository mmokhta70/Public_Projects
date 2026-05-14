#====================================
#create Linux 2023 via datasource - for source you can go to the below link and find the latest AMI for your region
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
#====================================
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

