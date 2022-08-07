#/bin/bash
set -x

file=kind-calico-svc-bgp

kind create cluster --config=./$file.yaml

kubectl taint nodes --all node-role.kubernetes.io/master-

for i in $(docker ps  -a --format "table {{.Names}}"|grep $file );do echo $i;docker cp /usr/bin/calicoctl $i:/usr/bin/calicoctl;docker cp /usr/bin/ping $i:/usr/bin/ping;docker exec -it $i  bash -c "sed -i -e 's/jp.archive.ubuntu.com\|archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list";done

date
