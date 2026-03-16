provider "aws" {
  region = "eu-west-2"
}
module "static_website" {
  source         = "./Module/S3"
  bucket_name    = var.bucket_name
  html_file_path = "./web/index.html"
}
