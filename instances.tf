resource "aws_instance" "webserver" {
    count             = "${length(var.subnet_cidr)}"
    ami = "${lookup(var.webserver-ami,var.region)}"
    instance_type = "${var.instance-type}"
    security_groups = ["${aws_security_group.webserver-security-group.id}"]
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  user_data = "${file("install_httpd.sh")}"
}