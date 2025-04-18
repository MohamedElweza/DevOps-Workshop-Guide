
resource "aws_lb" "web_elb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets           = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]
}

resource "aws_lb_target_group" "tg" {
  name     = "web-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "app_tg_attach" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.app_server.id
  port            = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_elb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
