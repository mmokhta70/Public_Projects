
#=================== RDS instance ===================#
#
resource "aws_db_instance" "this" {
  identifier = var.identifier

  #---------- engine config ----------#
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  #---------- storage config ----------#
  allocated_storage = var.storage_size
  storage_type      = "gp3"
  storage_encrypted = true

  #---------- database config ----------#
  db_name  = var.db_name
  username = var.credential.username
  password = var.credential.password

  #---------- security group config ----------#
  db_subnet_group_name = aws_db_sunbet_group.rds.name
}
