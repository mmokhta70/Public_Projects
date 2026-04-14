provider "aws" {
  region = "eu-west-2"
}

module "backend" {
  source               = "../../modules/backend"
  bucket_name          = "terrafrom_state"
  dynamo_db_table_name = "s3_lock_state"

}
