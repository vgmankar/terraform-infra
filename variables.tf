variable "region" {
  default = "us-west-2"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "subnet_cidr" {
  default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "webserver-ami"{
default = "ami-083ac7c7ecf9bb9b0"
}

variable "instance-type"{
    default="t2.micro"
}
variable "azs" {
  default = ["us-west-2a", "us-west-2b"]
}