output "dns_externo" {
  value = "${aws_instance.web.public_dns}"
}

output "ip_externo" {
  value = "${aws_instance.web.public_ip}"
  #value = "${aws_elb.web.dns_name}"
}
