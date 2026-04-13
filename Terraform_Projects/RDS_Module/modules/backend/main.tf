resource "aws_s3_bucket" "tf_state" {
  bucket = local.dynamo_db_config.bucket_name

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "version" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.tf_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#create dynamod for state locking
resource "aws_dynamodb_table" "state_lock" {
  name = local.dynamo_db_config.dynamo_db_table_name

  #primary key of the dyanmodb table
  hash_key = "LockID"
  #example : "LockID": "global/terraform.tfstate-md5"

  #Defines a DynamoDB attribute
  attribute {
    name = "LockID"
    type = "S" # S -> String
  }
}
