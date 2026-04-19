
#=================== RDS instance ===================#
resource "aws_db_instance" "this" {
  identifier  = var.identifier

  #---------- engine config ----------#
  engine = "postgres"
  engine_version = var.engine_version
  instance_class =
}
