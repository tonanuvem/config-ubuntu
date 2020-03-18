Steps:

$ mkdir certs
<br>$ dd if=/dev/urandom of=~/.rnd bs=256 count=1
<br>$ openssl req -nodes -newkey rsa:2048 -keyout certs/dashboard.key -out certs/dashboard.csr -subj "/C=/ST=/L=/O=/OU=/CN=kubernetes-dashboard"
<br>$ openssl x509 -req -sha256 -days 365 -in certs/dashboard.csr -signkey certs/dashboard.key -out certs/dashboard.crt
<br>$ kubectl create secret generic kubernetes-dashboard-certs --from-file=certs -n kube-system

Ajustar o serice com Nodeport:

$ kubectl create -f kubernetes-dashboard.yaml

Links:

> https://github.com/terraform-aws-modules/terraform-aws-elb/tree/master/examples/complete <br>
> https://hackernoon.com/getting-a-free-ssl-certificate-on-aws-a-how-to-guide-6ef29e576d22 <br>
> https://github.com/kubernetes/dashboard/issues/2954
