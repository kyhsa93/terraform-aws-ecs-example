resource "aws_ecs_cluster" "example" {
  name               = "example"
  capacity_providers = [aws_ecs_capacity_provider.example.name]
}

resource "aws_ecs_capacity_provider" "example" {
  name = "example-capacity-provider"
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.example.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 85
    }
  }
}

resource "aws_ecs_task_definition" "example" {
  family = "example"
  container_definitions = templatefile("container-definitions.json", {
    DATABASE_USER           = var.DATABASE_USER
    DATABASE_PASSWORD       = var.DATABASE_PASSWORD
    DATABASE_NAME           = var.DATABASE_NAME
    DATABASE_HOST           = var.DATABASE_HOST
  })
}

resource "aws_ecs_service" "example" {
  name            = "example"
  cluster         = aws_ecs_cluster.example.id
  task_definition = aws_ecs_task_definition.example.arn
  desired_count   = 1
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.example.arn
    container_name   = "example"
    container_port   = 3000
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
  launch_type = "EC2"
  depends_on  = [aws_lb_listener.http]
}

resource "aws_cloudwatch_log_group" "example" {
  name = "/ecs/example"
}
