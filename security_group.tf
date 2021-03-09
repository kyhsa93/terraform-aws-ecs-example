resource "aws_security_group" "lb" {
  name   = "allow-all-lb"
  vpc_id = aws_default_vpc.default-vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2-for-ecs" {
  description = "ecs instance security group"
  vpc_id      = aws_default_vpc.default-vpc.id

  ingress {
    description = "dynamic port mapping from lb"
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    security_groups = [
      aws_security_group.lb.id,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
