resource "aws_alb" "gatus_alb" {
  subnets         = [aws_subnet.PublicSubnetA.id, aws_subnet.PublicSubnetB.id]
  security_groups = [aws_security_group.alb_sg.id]
}

resource "aws_alb_target_group" "gatus_target" {
  name        = "gatus-target"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc.id
  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = "30"
    timeout             = 5
  }
}

resource "aws_alb_listener" "gatus_listener" {
  load_balancer_arn = aws_alb.gatus_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
        port = "443"
        protocol = "HTTPS"
        status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https_listener" {
  load_balancer_arn = aws_alb.gatus_alb.arn
  port              = 443
  protocol          = "HTTPS"

  certificate_arn = aws_acm_certificate_validation.cert.certificate_arn

  default_action {
    target_group_arn = aws_alb_target_group.gatus_target.arn
    type             = "forward"
  }
}


