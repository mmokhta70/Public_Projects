terraform {
  backend "s3" {
    bucket         = "tf_state"
    key            = "dev/terraform.tfsate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
  }
}
