Exemplo criado com base na documentação Oficial: 

<li> https://rancher.com/docs/rancher/v2.x/en/quick-start-guide/deployment/amazon-aws-qs/

<li> https://github.com/rancher/terraform-provider-rke#installing-the-provider

<li> https://github.com/rancher/quickstart

Deploy

> terraform init
<br>
> terraform apply

Kubernetes configurations will also be generated:

> kube_config_server.yaml contains credentials to access the RKE cluster supporting the Rancher server
<br>
> kube_config_workload.yaml contains credentials to access the provisioned workload cluster

Remover

> terraform destroy -auto-approve
