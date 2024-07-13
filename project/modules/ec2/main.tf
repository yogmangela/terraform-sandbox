resource "aws_launch_configuration" "web" {
  name          = "web-launch-configuration"
  image_id      = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  security_groups = [
    var.security_group,
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
  launch_configuration = aws_launch_configuration.web.id
  vpc_zone_identifier  = var.subnet_ids
  min_size             = 1
  max_size             = 4
  desired_capacity     = 1
  health_check_type    = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "webapi-instance"
    propagate_at_launch = true
  }
}

resource "aws_elb" "web" {
  name               = "webapi-elb"
  availability_zones = var.availability_zones

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  instances = aws_autoscaling_group.web.*.id
}

output "elb_name" {
  value = aws_elb.web.name
}
