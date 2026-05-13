output "sg_alb_id" {
  value       = aws_security_group.sg-alb.id
  description = "security group application load balancer level"
}

output "sg_public_id" {
  value       = aws_security_group.sg_public.id
  description = "security group public web servers level"
}

output "sg_private_id" {
  value       = aws_security_group.sg_private.id
  description = "security group private, MYSQL servers level"
}
