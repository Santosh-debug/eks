resource aws_security_group "web-sg" {
   name = "allow_All"
   description = "Allow All inbound traffic"
   vpc_id = "${aws_vpc.prudential_vpc.id}"
ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}
