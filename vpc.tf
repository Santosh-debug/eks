resource aws_vpc "prudential_vpc" {
   cidr_block = "${var.vpc_cidr}"
   tags = {
     Name = "PrudentialVPC"
 }
}
# Create IGW and attach it to prudential_vpc
resource "aws_internet_gateway" "prudential_igw" {
   vpc_id = "${aws_vpc.prudential_vpc.id}"
   tags = {
     Name = "main"
 }
}
# Build subnets for our VPCs
resource "aws_subnet" "public" {
    count = 2
    vpc_id = "${aws_vpc.prudential_vpc.id}"
    cidr_block = "${element(var.pub-cidr,count.index)}"
    map_public_ip_on_launch = "true"
    tags = {
       Name = "Subnet-${count.index +1}"
 }
}
resource "aws_route_table" "public_rt" {
     vpc_id = "${aws_vpc.prudential_vpc.id}"
     route {
       cidr_block = "0.0.0.0/0"
       gateway_id = "${aws_internet_gateway.prudential_igw.id}"
 }
      tags = {
        Name = "PublicRT"
 }
}
# Attach route table with public subnets
resource "aws_route_table_association" "a" {
    count = "${length(var.pub-cidr)}"
    subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
    route_table_id = "${aws_route_table.public_rt.id}"
 }
