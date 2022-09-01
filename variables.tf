variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
   default = "10.20.0.0/16"
}
variable "pub-cidr" {
  type = list(string)
  default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "pvt-cidr" {
  type = list(string)
  default = ["10.20.20.0/24", "10.20.21.0/24"]
}

variable "azs" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
variable "instance-ami" {
  default = "ami-09e67e426f25ce0d7" # Virginia
}
variable "instance_type" {
  default = "t2.micro"
}
