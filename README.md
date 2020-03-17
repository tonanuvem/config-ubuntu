# config-ubuntu

Scripts para preparar a VM Ubuntu para rodar os LABS no Educate.

O pacote de cloud-init configura aspectos específicos de uma nova instância.

1) Preparação:
> nano ~/.aws/credentials
> inserir credenciais
> executar o comando em sua maquina local: ssh-keygen -y -f ./chave-fiap.pem > public_key.pem

> git clone
> pegar o conteudo do arquivo e inserir no public_key.pem.

2) Execução
> cd ec2-instance
> terraform init
> terraform plan
> terraform apply

Fontes:

> https://github.com/akskap/esk8s
> https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples/two-tier
> https://github.com/heap/terraform-ebs-attachmentizer
