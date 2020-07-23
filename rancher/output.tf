output "rancher_server_url" {
  value = module.rancher_common.rancher_url
}

output "Node_1_ip_externo" {
  value = aws_instance.quickstart_node.public_ip
}

output "Node_2_ip_externo" {
  value = aws_instance.quickstart_node_2.public_ip
}
  
output "Node_3_ip_externo" {
  value = aws_instance.quickstart_node_3.public_ip
}
