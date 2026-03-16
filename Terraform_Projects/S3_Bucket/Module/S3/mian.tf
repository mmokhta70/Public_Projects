resource "aws_s3_bucket" "static_web" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_website_configuration" "web_config" {
  bucket = aws_s3_bucket.static_web.id
  index_document {
    suffix = "index.hrml"
  }
  error_document {
    key = "error.html"
  }
}

#this part gives public access to the website
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.static_web.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "read_only_policy" {
  bucket = aws_s3_bucket.static_web.id
  policy = jsondecode({
    statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action = [
        "s3:GetObject"
      ]
      Resouorce = "${aws_s3_bucket.static_web.arn}/*"
    }]
  })
}

resource "aws_s3_object" "index" {
  bucket       = var.bucket_name
  key          = "index.html"
  source       = var.html_file_path
  content_type = "text/html"
}
