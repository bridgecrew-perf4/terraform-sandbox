resource "aws_iam_role" "ecs_task_role" {
    name = "container-era-ecs-task-role"
    path = "/"
    assume_role_policy = file("./ecs_task_assume_role_policy.json")
}
