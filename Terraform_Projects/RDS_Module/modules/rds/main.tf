resource "aws_db_subnet_group" "rds" {
  subnet_ids = var.private_subnet_ids
}
resource "aws_db_isntance" "main" {
  instance_class         = var.instance_class
  identifier             = "database"
  engine                 = var.engine
  allocated_storage      = var.storage_size
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = var.rds_sg_id
  publicly_accessible    = false
  skip_final_snapshot    = true
}
