resource "aws_lb" "lb" {
    name = "sample-lb"
    internal = false
    load_balancer_type = "application"

    security_groups = [
        aws_security_group.elb_sg.id
    ]

    subnets = [
        aws_subnet.public_subnet_1.id,
        aws_subnet.public_subnet_2.id
    ]
}

resource "aws_lb_target_group" "http" {
    name = "samaple-http"
    port = 8080
    protocol = "HTTP"
    vpc_id = aws_vpc.vpc.id
    health_check {
        interval = 30
        path = "/health_check"
        port = "traffic-port"
        protocol = "HTTP"
        timeout = 10
        healthy_threshold = 3
        unhealthy_threshold = 3
    }
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.lb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
      target_group_arn = aws_lb_target_group.http.arn
      type = "forward"
    }
}