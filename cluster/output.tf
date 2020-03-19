output "Master_dns_externo" {
  value = "${aws_instance.master.public_dns}"
}

output "Master_ip_externo" {
  value = "${aws_instance.master.public_ip}"
}

output "Node_1_dns_externo" {
  value = "${aws_instance.node1.public_dns}"
}

output "Node_1_ip_externo" {
  value = "${aws_instance.node1.public_ip}"
}

output "Node_2_dns_externo" {
  value = "${aws_instance.node2.public_dns}"
}

output "Node_2_ip_externo" {
  value = "${aws_instance.node2.public_ip}"
}
