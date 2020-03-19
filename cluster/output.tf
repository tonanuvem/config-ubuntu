output "Master dns_externo" {
  value = "${aws_instance.master.public_dns}"
}

output "Master ip_externo" {
  value = "${aws_instance.master.public_ip}"
}

output "Node 1 dns_externo" {
  value = "${aws_instance.node1.public_dns}"
}

output "Node 1 ip_externo" {
  value = "${aws_instance.node1.public_ip}"
}

output "Node 2 dns_externo" {
  value = "${aws_instance.node2.public_dns}"
}

output "Node 2 ip_externo" {
  value = "${aws_instance.node2.public_ip}"
}
