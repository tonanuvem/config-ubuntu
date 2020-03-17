# config-ubuntu

Scripts para preparar a VM Ubuntu para rodar os LABS no Educate.

O pacote de cloud-init configura aspectos específicos de uma nova instância.

1) Preparação:
> nano ~/.aws/credentials <br>
> inserir credenciais <br>
> executar o comando em sua maquina local: ssh-keygen -y -f ./chave-fiap.pem > public_key.pem <br>

> git clone  <br>
> pegar o conteudo do arquivo e inserir no public_key.pem.  <br>

2) Execução
> cd ec2-instance  <br>
> terraform init  <br>
> terraform plan  <br>
> terraform apply  <br>

3) Conectar 
> ssh <br>
> cat /var/log/cloud-init-output.log > script_init.log <br>
<br>
O arquivo de log de saída de cloud-init (/var/log/cloud-init-output.log) captura a saída do console para facilitar a depuração de seus scripts após uma execução se a instância não se comportar da maneira desejada.

Quando um script de dados do usuário é processado, ele é copiado para /var/lib/cloud/instances/instance-id/ e executado a partir desse diretório.

Fontes:

> https://github.com/akskap/esk8s
> https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples/two-tier
> https://github.com/heap/terraform-ebs-attachmentizer
