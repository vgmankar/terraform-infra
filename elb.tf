resource "aws_elb" "javahome-elb" {
  name               = "javahome-elb"
  #availability_zones = ["${var.azs}"]
subnets="${aws_subnet.public.*.id}"
security_groups =  ["${aws_security_group.webserver-security-group.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 10
  }

  instances                   = "${aws_instance.webserver.*.id}"
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "webserver-elb"
  }
}

output "elb_dns"{
    value="${aws_elb.javahome-elb.dns_name}"
}