resource "aws_ecs_task_definition" "service" {
    family = "sample-service"
    container_definitions = file("./task-definitions/service.json")
    task_role_arn = aws_iam_role.ecs_task_role.arn
    network_mode = "bridge"
}