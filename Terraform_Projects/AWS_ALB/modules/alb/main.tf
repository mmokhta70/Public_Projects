#===================================
# Application load blanacer
#===================================
resource "aws_alb" "main_alb" {
  name               = "${var.project_name}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids
  tags = merge(var.common_tags, {
    name = "${var.project_name}-${var.environment}-alb"
  })
}

#===================================
# Create TARGET GROUP
#===================================
 resource "aws_alb_target_group" "main_alb_tg" {
  name = "${var.project_name}-${var.environment}-alb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id 

health_check {
enabled = true
path = "/"
protocol = "HTTP"
#------------------- addvance health check parameters
healthy_threshold = 3
unhealthy_threshold = 3
interval = 30
timeout = 5
matcher = "200-399" # Success codes - The HTTP codes to use when checking for a successful response from a target.

    } 
    tags = merge(var.common_tags, {
      Name = "${var.project_name}-${var.environment}-alb-tg"
    })
}

#===================================
# Create LISTENER -  Port 80
#===================================
resource "aws_alb_listener" "main_alb_listener" {
  load_balancer_arn = aws_alb.main_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirection"
    redirect  {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }

  }

tags = merge(var.common_tags , {
  Name = "${var.project_name}-${var.environment}-alb-listener"
})
}

#===================================
# Create LISTENER -  Port 443
#===================================
resource "aws_alb_listener" "main_alb_listener_HTTPS"{
  count = var.certificate_arn != "" ? 1 : 0 #only created when certificate_arn is provided
  load_balancer_arn = aws_alb.main_alb.arn
  port = 443
  protocol = "HTTPS"
  certificate_arn = var.certificate_arn

  default_action {
    type= "forward"
    target_group_arn = aws_alb_target_group.main_alb_tg.arn
  }

  tags= merge(var.common_tags , {
    Name = "${var.project_name}-${var.environment}-alb-listener-HTTPS"
  })

}