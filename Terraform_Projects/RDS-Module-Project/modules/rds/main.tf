
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
  db_subnet_group_name   = aws_db_sunbet_group.rds.name
  vpc_security_group_ids = var.security_group_ids
}


#=================== Secret Manager config ===================#
resource "aws_secretsmanager_secret" "db" {
  name = "${var.identifier}-db-secret"
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsondecode({
    username = var.credential.username
    password = var.credential.password
  })
}

#=================== Subnet group ===================#
resource "aws_db_subnet_group" "this" {
  name       = "rds_subnet_group"
  subnet_ids = var.private_subnet_ids
  tags = merge(var.tags, {
    Name = "${local.name}-db-subnet-group}"
  })
}
