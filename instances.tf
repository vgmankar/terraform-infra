resource "aws_instance" "webserver" {
   # count             = "${length(var.subnet_cidr)}"
    count = "${var.instance_count}"
    ami = "${lookup(var.webserver-ami,var.region)}"
    instance_type = "${var.instance-type}"
    security_groups = ["${aws_security_group.webserver-security-group.id}"]
  subnet_id = "${element(aws_subnet.public.*.id, 0)}"
  user_data = "${file("install_httpd.sh")}"
tags = {
  Name="Terraform-${element(var.instance_tags,count.index)}"
}
}