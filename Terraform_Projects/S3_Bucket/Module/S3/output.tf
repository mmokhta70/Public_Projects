#hre we will send the url of the website to the root module to use
output "static_website_url" {
  value = aws_s3_bucket_website_configuration.web_config.website_endpoint
}
