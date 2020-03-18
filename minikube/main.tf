data "template_file" "init" {
  template = "${file("${path.module}/setup.sh")}"
}

resource "aws_instance" "esk8s_instance" {
  ami                         = "${var.instance_ami_id}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = true
  subnet_id                   = "${var.instance_subnet_id}"
  vpc_security_group_ids      = ["${aws_security_group.esk8s_instance_sg.id}"]
  user_data                   = "${data.template_file.init.rendered}"
  key_name                    = "${var.instance_key_name}"

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_size = 200
  }

  tags = {
	Name = "esk8s instance"
	Application = "minikube"
        Environment = "test"
        Description = "Test instance"
  }
}

resource "aws_security_group" "esk8s_instance_sg" {
  vpc_id = "${var.instance_vpc_id}"
  name_prefix   = "esk8s_instance_sg"
}

resource "aws_security_group_rule" "esk8s_sg_ingress_1" {
  from_port         = 0
  protocol          = "All"
  security_group_id = "${aws_security_group.esk8s_instance_sg.id}"
  to_port           = 65535
  type              = "ingress"
  cidr_blocks       = "${var.ec2_ingress_cidr}"
}

resource "aws_security_group_rule" "esk8s_sg_ingress_2" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.esk8s_instance_sg.id}"
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sg_egress" {
  from_port         = -1
  protocol          = "All"
  security_group_id = "${aws_security_group.esk8s_instance_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
  to_port           = -1
  type              = "egress"
}

provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile_name}"
}

output "public_dns" {
  value = "${aws_instance.esk8s_instance.public_dns}"
  description = "Public DNS for the EC2 instance"
}

output "public_ip" {
  value = "${aws_instance.esk8s_instance.public_ip}"
  description = "Public IP for the EC2 instance"
}
