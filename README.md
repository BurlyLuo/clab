## CONTAINERlab + KinD
![](https://github.com/BurlyLuo/clab/blob/master/KinD.png)
## Gitee: https://gitee.com/rowan-wcni
### 1. CONTAINERlab and KinD to deploy a new K8S cluster
The tool KinD can deploy a K8S cluster quicklly, but all the nodes usder the same subnet, so if want set the nodes under different subnets, CONTAINERlab can provide the network resources.

### 2. Deploy the K8S cluster with KinD:
```
git clone https://github.com/BurlyLuo/clab.git
root@hive:~/local/clab# kind create cluster --config=./kind-calico.yaml --image=kindest/node:v1.23.4
Creating cluster "clab-bgp-cplane-demo" ...
 ✓ Ensuring node image (kindest/node:v1.23.4) 
 ✓ Preparing nodes      
 ✓ Writing configuration 
 ✓ Starting control-plane ️ 
 ✓ Installing StorageClass 
 ✓ Joining worker nodes 
Set kubectl context to "kind-clab-bgp-cplane-demo"
You can now use your cluster with:
kubectl cluster-info --context kind-clab-bgp-cplane-demo
Have a question, bug, or feature request? Let us know! https://kind.sigs.k8s.io/#community 
``` 
Once done ,we can get a K8S cluster without CNI.
```
# kubectl get nodes -owide 
NAME                                 STATUS     ROLES                  AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION      CONTAINER-RUNTIME
clab-bgp-cplane-demo-control-plane   NotReady   control-plane,master   15m   v1.23.4   172.18.0.3    <none>        Ubuntu 21.10   5.15.0-46-generic   containerd://1.5.10
clab-bgp-cplane-demo-worker          NotReady   <none>                 14m   v1.23.4   172.18.0.2    <none>        Ubuntu 21.10   5.15.0-46-generic   containerd://1.5.10
clab-bgp-cplane-demo-worker2         NotReady   <none>                 14m   v1.23.4   172.18.0.5    <none>        Ubuntu 21.10   5.15.0-46-generic   containerd://1.5.10
clab-bgp-cplane-demo-worker3         NotReady   <none>                 14m   v1.23.4   172.18.0.4    <none>        Ubuntu 21.10   5.15.0-46-generic   containerd://1.5.10
```

![](https://github.com/BurlyLuo/clab/blob/master/CONTAINERlab.png)
### 3. Deploy the network resources with CONTAINERlab
```
# brctl addbr br-leaf0
# ifconfig br-leaf0 up
# brctl addbr br-leaf1
# ifconfig br-leaf1 up

# clab -t topo.yaml deploy 
INFO[0000] Containerlab v0.30.0 started                 
INFO[0000] Parsing & checking topology file: topo.yaml  
INFO[0000] Pulling docker.io/burlyluo/nettoolbox:latest Docker image 
INFO[0025] Done pulling docker.io/burlyluo/nettoolbox:latest 
INFO[0025] Creating lab directory: /root/local/clab/clab-bgp-cplane-demo 
INFO[0025] Creating docker network: Name="clab", IPv4Subnet="172.20.20.0/24", IPv6Subnet="2001:172:20:20::/64", MTU="1500" 
INFO[0025] Creating container: "leaf1"                  
INFO[0025] Creating container: "leaf0"                  
INFO[0025] Creating container: "server2"                
INFO[0025] Creating container: "spine1"                 
INFO[0025] Creating container: "server4"                
INFO[0025] Creating container: "spine0"                 
INFO[0025] Creating container: "server1"                
INFO[0025] Creating container: "server3"                
INFO[0029] Creating virtual wire: br-leaf0:br-leaf0-net1 <--> server2:net0 
INFO[0030] Creating virtual wire: br-leaf1:br-leaf1-net1 <--> server4:net0 
INFO[0030] Creating virtual wire: br-leaf0:br-leaf0-net0 <--> server1:net0 
INFO[0030] Creating virtual wire: br-leaf1:br-leaf1-net0 <--> server3:net0 
INFO[0034] Creating virtual wire: leaf1:eth1 <--> spine0:eth2 
INFO[0034] Creating virtual wire: leaf1:eth2 <--> spine1:eth2 
INFO[0034] Creating virtual wire: leaf1:eth3 <--> br-leaf1:br-leaf1-net2 
INFO[0034] Creating virtual wire: leaf0:eth3 <--> br-leaf0:br-leaf0-net2 
INFO[0034] Creating virtual wire: leaf0:eth1 <--> spine0:eth1 
INFO[0034] Creating virtual wire: leaf0:eth2 <--> spine1:eth1 
INFO[0048] Adding containerlab host entries to /etc/hosts file 
INFO[0050]  New containerlab version 0.31.0 is available! Release notes: https://containerlab.dev/rn/0.31/
Run 'containerlab version upgrade' to upgrade or go check other installation options at https://containerlab.dev/install/ 
+---+------------------------------+--------------+----------------------------+-------+---------+----------------+----------------------+
| # |             Name             | Container ID |           Image            | Kind  |  State  |  IPv4 Address  |     IPv6 Address     |
+---+------------------------------+--------------+----------------------------+-------+---------+----------------+----------------------+
| 1 | clab-bgp-cplane-demo-leaf0   | e56e5a89a665 | vyos/vyos:1.2.8            | linux | running | 172.20.20.5/24 | 2001:172:20:20::5/64 |
| 2 | clab-bgp-cplane-demo-leaf1   | e6979ddaebdb | vyos/vyos:1.2.8            | linux | running | 172.20.20.4/24 | 2001:172:20:20::4/64 |
| 3 | clab-bgp-cplane-demo-server1 | f8cb8157ada7 | burlyluo/nettoolbox:latest | linux | running | N/A            | N/A                  |
| 4 | clab-bgp-cplane-demo-server2 | 96033749619e | burlyluo/nettoolbox:latest | linux | running | N/A            | N/A                  |
| 5 | clab-bgp-cplane-demo-server3 | 976cb956af5f | burlyluo/nettoolbox:latest | linux | running | N/A            | N/A                  |
| 6 | clab-bgp-cplane-demo-server4 | fa4f0980aac0 | burlyluo/nettoolbox:latest | linux | running | N/A            | N/A                  |
| 7 | clab-bgp-cplane-demo-spine0  | 39c0217a7d2b | vyos/vyos:1.2.8            | linux | running | 172.20.20.2/24 | 2001:172:20:20::2/64 |
| 8 | clab-bgp-cplane-demo-spine1  | 66b8e593dae2 | vyos/vyos:1.2.8            | linux | running | 172.20.20.3/24 | 2001:172:20:20::3/64 |
+---+------------------------------+--------------+----------------------------+-------+---------+----------------+----------------------+
```

### 4. There is key note that how to combine the network resources which create by CONTAINERlab with KinD:
    server1:
      kind: linux
      image: burlyluo/nettoolbox:latest
      network-mode: container:control-plane
      exec:
      - ip addr add 192.168.5.10/24 dev net0     # 1. use the container mode network
      - ip route replace default via 192.168.5.1 # 2. replace the default gateway due to the most of CNI will select the default interface nic as the CNI interface.
 
 the router's configuration can be found at [startup-config](https://github.com/BurlyLuo/clab/tree/master/startup-config)
So with this logical, we can get a full topo as below:

![](https://github.com/BurlyLuo/clab/blob/master/TOPO.png)



### 5. Apply the CNI
```
# kubectl apply -f calico.yaml 
configmap/calico-config created
customresourcedefinition.apiextensions.k8s.io/bgpconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/bgppeers.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/blockaffinities.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/caliconodestatuses.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/clusterinformations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/felixconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworksets.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/hostendpoints.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamblocks.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamconfigs.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamhandles.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ippools.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipreservations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/kubecontrollersconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networksets.crd.projectcalico.org created
clusterrole.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrolebinding.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrole.rbac.authorization.k8s.io/calico-node created
clusterrolebinding.rbac.authorization.k8s.io/calico-node created
daemonset.apps/calico-node created
serviceaccount/calico-node created
deployment.apps/calico-kube-controllers created
serviceaccount/calico-kube-controllers created
poddisruptionbudget.policy/calico-kube-controllers created
# 
```
