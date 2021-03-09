resource "aws_lb" "example" {
  name               = "example"
  load_balancer_type = "application"
  internal           = false
  subnets = [
    aws_default_subnet.ap-northeast-2a.id,
    aws_default_subnet.ap-northeast-2b.id,
    aws_default_subnet.ap-northeast-2c.id,
    aws_default_subnet.ap-northeast-2d.id,
  ]
  security_groups = [
    aws_security_group.lb.id,
    aws_security_group.ec2-for-ecs.id,
  ]
}

resource "aws_lb_target_group" "example" {
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_default_vpc.default-vpc.id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}
