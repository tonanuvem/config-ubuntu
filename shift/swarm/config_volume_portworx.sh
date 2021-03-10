# Cada Worker possui um disco extra (/dev/xvdb) criado pelo Terraform:

echo "Configuraçoes de disco: "
lsblk

# https://docs.portworx.com/install-with-other/docker/swarm/
REL="/2.6"  # Portworx v2.6 release

latest_stable=$(curl -fsSL "https://install.portworx.com$REL/?type=dock&stork=false&aut=false" | awk '/image: / {print $2}')

# Download Bundle (reminder, you will still need to run `px-runc install ..` after this step)
sudo docker run --entrypoint /runc-entry-point.sh \
    --rm -i --privileged=true \
    -v /opt/pwx:/opt/pwx -v /etc/pwx:/etc/pwx \
    $latest_stable

# ETCD rodando no master
MASTER=$(~/environment/ip | awk -Fv '{ if ( !($1 ~  "None") && (/vm_0/) ) { print $1} }')

# RUN "px-runc install" command from the bundle to configure your installation
sudo /opt/pwx/bin/px-runc install -c FIAP \
    -k etcd://$MASTER:2379 \
    -s /dev/xvda1

# Verificar status:
echo "Verificando status : "
sudo pxctl status

#PX_POD=$(kubectl get pods -l name=portworx -n kube-system -o jsonpath='{.items[0].metadata.name}')
#docker exec -it $PX_POD -n kube-system -- /opt/pwx/bin/pxctl status
