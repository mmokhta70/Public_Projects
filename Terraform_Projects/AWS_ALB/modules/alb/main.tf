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
healthy_threshold = 3
unhealthy_threshold = 3
interval = 30
timeout = 5
matcher = "200-399"

    } 
    tags = merge(var.common_tags, {
      Name = "${var.project_name}-${var.environment}-alb-tg"
    })
}
