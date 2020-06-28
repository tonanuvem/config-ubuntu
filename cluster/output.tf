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

output "Node_3_dns_externo" {
  value = "${aws_instance.node3.public_dns}"
}

output "Node_3_ip_externo" {
  value = "${aws_instance.node3.public_ip}"
}
