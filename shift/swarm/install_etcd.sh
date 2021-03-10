# https://etcd.io/docs/v2/docker_guide/
# Running etcd in standalone mode
# In order to expose the etcd API to clients outside of the Docker host you’ll need use the host IP address when configuring etcd.

export HostIP=$(~/ip)

# The following docker run command will expose the etcd client API over ports 4001 and 2379, and expose the peer port over 2380.
# This will run the latest release version of etcd. You can specify version if needed (e.g. quay.io/coreos/etcd:v2.2.0).

docker run -d -v /usr/share/ca-certificates/:/etc/ssl/certs -p 4001:4001 -p 2380:2380 -p 2379:2379 \
 --name etcd quay.io/coreos/etcd:v2.3.8 \
 -name etcd0 \
 -advertise-client-urls http://${HostIP}:2379,http://${HostIP}:4001 \
 -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
 -initial-advertise-peer-urls http://${HostIP}:2380 \
 -listen-peer-urls http://0.0.0.0:2380 \
 -initial-cluster-token etcd-cluster-1 \
 -initial-cluster etcd0=http://${HostIP}:2380 \
 -initial-cluster-state new

# Configure etcd clients to use the Docker host IP and one of the listening ports from above.

etcdctl -C http://${HostIP}:2379 member list
etcdctl -C http://${HostIP}:4001 member list
