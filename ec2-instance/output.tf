output "ip_externo" {
  value = "${aws_elb.web.dns_name}"
}
