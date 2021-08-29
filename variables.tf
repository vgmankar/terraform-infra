variable "region" {
  default = "us-west-2"
}

variable "webserver-ami"{
  type=map
  
 default = {
us-west-2 = "ami-083ac7c7ecf9bb9b0"
us-west-1 ="ami-04b6c97b14c54de18"
  }
}

variable "instance_count"{
  default=3
}

variable "instance_tags"{
  type=list
  default = ["Ser1","Ser2","Ser3"]

}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "subnet_cidr" {
  default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "subnet_cidr_pvt" {
  default = ["10.20.3.0/24", "10.20.4.0/24"]
}


variable "instance-type"{
    default="t2.micro"
}
variable "azs" {
  default = ["us-west-2a", "us-west-2b"]
}