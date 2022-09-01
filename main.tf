provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "prudential-terrastate"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_iam_role" "ec2-jump-role" {
  name               = "jump-role"
  assume_role_policy = "${file("assumerolepolicy.json")}"
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy      = "${file("policys.json")}"
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = ["${aws_iam_role.ec2-jump-role.id}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_instance_profile" "test_profile" {
  name       = "test_profile"
  role       = "${aws_iam_role.ec2-jump-role.id}"
}

resource "aws_key_pair" "ssh-demo" {
  key_name   = "sshkey"
  public_key = "${file("sshkey.pub")}"
}

resource "aws_instance" "jump-server" {
               # count = "${length(var.subnets_cidr)}"
                ami             = "${var.instance-ami}"
                instance_type   = "${var.instance_type}"
                security_groups = ["${aws_security_group.web-sg.id}"]
                subnet_id       = "subnet-08f15fdf1c4ee8eb4"
                iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
                key_name        = "${aws_key_pair.ssh-demo.id}"
                user_data       = "${file("install_soft.sh")}"
                tags = {
                Name = "jump-server"
                }
              }

