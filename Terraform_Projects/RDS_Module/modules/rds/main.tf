#---------------------------
# secret manager
#---------------------------

resource "aws_secretsmanager_secret" "db" {
  name = "${var.identifier}-db-secret"
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    username = var.credential.username
    password = var.credential.password
  })
}

#---------------------------
# Subnet groups
#---------------------------

resource "aws_db_subnet_group" "rds" {
  name       = "rds_subnet_group"
  subnet_ids = var.private_subnet_ids
  tags = {
    Name = "${var.identifier}-subnet-group"
  }
}

#---------------------------
# RDS instance
#---------------------------

resource "aws_db_instance" "main" {
  identifier             = var.identifier
  engine                 = "postgres"
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.storage_size
  storage_type           = "gp3"
  storage_encrypted      = true
  db_name                = var.db_name
  username               = var.credential.username
  password               = var.credential.password
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = var.rds_security_group_id
}
