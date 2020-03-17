# config-ubuntu

Scripts para preparar a VM Ubuntu para rodar os LABS no Educate.

O pacote de cloud-init configura aspectos específicos de uma nova instância.

Passos:
> nano ~/.aws/credentials
> inserir credenciais
> cd ec2-instance
> terraform init
> terraform plan
> terraform apply

Fontes:

> https://github.com/akskap/esk8s
> https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples/two-tier
> https://github.com/heap/terraform-ebs-attachmentizer
