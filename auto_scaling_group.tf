data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "self"]
}

resource "aws_launch_configuration" "example" {
  name_prefix   = "example"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true
  }
  iam_instance_profile = aws_iam_instance_profile.ecs_service_role.name
  key_name             = "example"
  security_groups = [
    aws_security_group.ec2-for-ecs.id,
  ]
  associate_public_ip_address = true
  user_data                   = <<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=example" >> /etc/ecs/ecs.config
EOF
}

resource "aws_autoscaling_group" "example" {
  name                      = "example"
  launch_configuration      = aws_launch_configuration.example.name
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  health_check_type         = "ELB"
  health_check_grace_period = 300
  vpc_zone_identifier = [
    aws_default_subnet.ap-northeast-2a.id,
    aws_default_subnet.ap-northeast-2b.id,
    aws_default_subnet.ap-northeast-2c.id,
    aws_default_subnet.ap-northeast-2d.id,
  ]
  target_group_arns     = [aws_lb_target_group.example.arn]
  protect_from_scale_in = true
  lifecycle {
    create_before_destroy = true
  }
}