locals {
  dynamo_db_config = {
    bucket_name          = "terrafrom_state"
    dynamo_db_table_name = "s3_lock_state"
  }

}
