terraform {
  backend "s3" {
    bucket         = "terrafrom_state for dev environmet dhoulb be here"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "terraform-state-lock-dev"
  }
}
