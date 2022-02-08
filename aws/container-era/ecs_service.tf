resource "aws_ecs_service" "webapp_service" {
    name = "sample-service"
    cluster = aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.service.arn
    desired_count = 1
    launch_type = "EC2"
}