#vpc for application
resource "aws_vpc" "javahome_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Main"
  }
}

#create gateway and attached to VPC
resource "aws_internet_gateway" "javahome_igw" {
  vpc_id = "${aws_vpc.javahome_vpc.id}"
  tags = {
    Name = "Main_IGW"
  }
}

# Build for subnet
resource "aws_subnet" "public" {
  count             = "${length(var.subnet_cidr)}"
  vpc_id            = "${aws_vpc.javahome_vpc.id}"
  cidr_block        = element(var.subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch=true
  tags = {
    Name = "Subnet-${count.index + 1}"
  }
}


resource "aws_subnet" "private" {
  count             = "${length(var.subnet_cidr_pvt)}"
  vpc_id            = "${aws_vpc.javahome_vpc.id}"
  cidr_block        = element(var.subnet_cidr_pvt, count.index)
  availability_zone = element(var.azs, count.index)
  #map_public_ip_on_launch=true
  tags = {
    Name = "SubnetPri-${count.index + 1}"
  }
}

# route table
resource "aws_route_table" "public_Route" {
 vpc_id = "${aws_vpc.javahome_vpc.id}"

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id =  "${aws_internet_gateway.javahome_igw.id}"
        }
  
    tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table" "private_Route" {
 vpc_id = "${aws_vpc.javahome_vpc.id}"

  route= []
  #{
      #cidr_block = "0.0.0.0/0"
      #gateway_id =  "${aws_internet_gateway.javahome_igw.id}"
       # }
  
    tags = {
    Name = "private_rt"
  }
}
# route table association
resource "aws_route_table_association" "rt_Association" {
  count="${length(var.subnet_cidr)}"
  subnet_id      = "${element(aws_subnet.public.*.id,count.index)}"
  route_table_id = "${aws_route_table.public_Route.id}"
}

resource "aws_route_table_association" "pvt_rt_Association" {
  count="${length(var.subnet_cidr_pvt)}"
  subnet_id      = "${element(aws_subnet.private.*.id,count.index)}"
  route_table_id = "${aws_route_table.private_Route.id}"
}