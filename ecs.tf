resource "aws_ecs_cluster" "gatus_cluster" {
  name = "gatus_cluster"
}

resource "aws_ecs_task_definition" "gatus_definition" {
  family                   = "gatus_definition"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions = jsonencode([
    {
      name  = "gatus_container"
      image = "${aws_ecr_repository.gatus.repository_url}:v1"
      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = 8080
        }
      ]

  }])
}

resource "aws_ecs_service" "gatus_service" {
  name            = "gatus_service"
  cluster         = aws_ecs_cluster.gatus_cluster.id
  task_definition = aws_ecs_task_definition.gatus_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = [aws_subnet.PublicSubnetA.id, aws_subnet.PublicSubnetB.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.gatus_target.arn
    container_name   = "gatus_container"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.gatus_listener,aws_alb_listener.https_listener, aws_iam_role_policy_attachment.ecs_execution_role_policy]

}