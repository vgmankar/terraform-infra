resource "aws_security_group" "webserver-security-group" {
  
name        = "allow_http"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.javahome_vpc.id}"

  ingress {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  

  tags = {
    Name = "allow_tls"
  }
}