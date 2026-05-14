output "alb_dns_name" {
  value = aws_lb.alb.dns_name
  description = "The DNS name of the ALB."
}

output "alb_arn" {
     description = "The ARN of the ALB."
     value = aws_lb.main_alb.arn
}


output "target_group_arn" {
     value = aws_alb_target_group.main_alb_tg.arn
     description = "The ARN of the target group."
}


output "listener_arn" {
     value = aws_alb_listener.main_alb_listener.arn
     description = "HTTP listener ARN"
}

output "listener_arn_https" {
     value = try(aws_alb_listener.main_alb_listener_HTTPS[0].arn, "")
     description = "HTTPS listener ARN"
}