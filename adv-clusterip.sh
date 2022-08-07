calicoctl patch BGPConfig default --patch '{"spec": {"serviceClusterIPs": [{"cidr": "10.96.0.0/16"}]}}'
