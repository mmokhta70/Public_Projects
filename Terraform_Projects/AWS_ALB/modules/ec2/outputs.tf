output "web_instance_ids" {
  value       = aws_instance.web[*].id
  description = "all the web severs ec2 instance ids"
}

output "web_instance_ips" {
  value       = aws_instance.web[*].private_ip
  description = "Web server private IPs"
}

output "db_instance_ids" {
  value       = aws_instance.db[*].id
  description = "all the db servers ec2 instance ids"
}

output "db_instance_ips" {
  value       = aws_instance.db[*].private_ip
  description = "DB server private IPs — never exposed publicly"
}
