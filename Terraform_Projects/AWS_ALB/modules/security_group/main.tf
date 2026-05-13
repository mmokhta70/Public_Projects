#-----------------
# Create SG-ALB (facing to the internet)
#-----------------
resource "aws_security_group" "sg-alb" {
  name   = "${var.project_name}-sg-alb"
  vpc_id = aws_vpc.main.id
  #------------------accept all http traffic from internet
  ingress {
    description = "allow all HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "accept all HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #------------------- sends all trrafic to the web servers
  egress {
    description = "send all traffic toward web servers"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all protocols allowed
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.project_name}-sg-alb"
}


#-----------------
# Create SG-public (used for web servers)
#-----------------
resource "aws_security_group" "sg_public" {
  vpc_id = aws_vpc.main.id
  name   = "${var.project_name}-sg_public"

  #---- only the traffic comes from the alb are accepted
  ingress {
    from_port   = 443
    to_port     = 433
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.sg-alb.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
