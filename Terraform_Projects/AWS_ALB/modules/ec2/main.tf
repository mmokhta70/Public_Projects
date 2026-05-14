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

#====================================
#The key pair is only useful if the SG lets SSH through.
#====================================
resource "aws_key_pair" "this" {
  key_name = "${var.project_name}-${var.environment}-key"
  public_key = file("~/.ssh/${var.project_name}-${var.environment}-key.pub")
  tags = merge(var.common_tags, {
    "Name" = "${var.project_name}-${var.environment}-key"
  })
}


#====================================
# web server EC2 instance that receive traffic from the ALB only
#====================================
resource "aws_instance" "web" {
  count = length(var.public_subnet)
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type


  #----------- pick the matching subnets and azs for each instance -----------
  subnet_id = var.public_subnet[count.index]
  vpc_security_group_ids = [var.sg_public_id]
  key_name = aws_key_pair.this.key_name

  tags = merge (var.common_tags , {
    Name = "${var.project_name}-${var.environment}-web-${count.index + 1}"
    type= "web-server"
    AZ = var.azs[count.index]
  })
}
